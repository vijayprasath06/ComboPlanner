import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import '../domain/models/mall.dart';
import '../domain/models/stall.dart';
import '../domain/models/menu_item.dart';
import '../domain/models/meal_plan.dart';
import '../domain/models/trending_combo.dart';
import '../domain/models/plan_history.dart';
import '../domain/enums/dietary_tag.dart';
import '../domain/enums/engine_category.dart';

class KnapsackParams {
  final String isarDirectory;
  final String mallId;
  final Set<String> blacklistedItemIds;
  final bool strictPureVeg;
  final double budget;
  final int vegCount;
  final int nonVegCount;
  final int maxStalls;
  final List<EngineCategory> allowedCategories;
  final Set<String> likedTags;
  final Set<String> dislikedTags;

  KnapsackParams({
    required this.isarDirectory,
    required this.mallId,
    required this.blacklistedItemIds,
    required this.strictPureVeg,
    required this.budget,
    required this.vegCount,
    required this.nonVegCount,
    required this.maxStalls,
    required this.allowedCategories,
    this.likedTags = const {},
    this.dislikedTags = const {},
  });
}

class KnapsackResult {
  final List<MealPlan> plans;
  final bool budgetTooTight;
  final double minimumBudgetRequired;

  const KnapsackResult({
    required this.plans,
    required this.budgetTooTight,
    required this.minimumBudgetRequired,
  });
}

class KnapsackService {
  static Future<KnapsackResult> computePlans(KnapsackParams params) async {
    return await compute(_generatePlans, params);
  }

  static KnapsackResult _generatePlans(KnapsackParams params) {
    // 2.1: Isar Isolate Bottleneck - Direct DB Access inside Isolate
    final isar = Isar.openSync(
      [MallSchema, MenuItemSchema, StallSchema, TrendingComboSchema, PlanHistorySchema],
      directory: params.isarDirectory,
    );

    final rawItems = isar.menuItems.filter().mallIdEqualTo(params.mallId).findAllSync();
    final availableItems = rawItems.where((e) => !params.blacklistedItemIds.contains(e.internalId)).toList();

    final stalls = isar.stalls.filter().mallIdEqualTo(params.mallId).findAllSync();
    final stallMap = { for (var s in stalls) s.stallId: s };

    // ── DEBUG ──────────────────────────────────────────────────────────────
    debugPrint('[KS] mallId=${params.mallId} budget=${params.budget} veg=${params.vegCount} nonVeg=${params.nonVegCount}');
    debugPrint('[KS] rawItems=${rawItems.length} availableItems=${availableItems.length} stalls=${stalls.length}');
    debugPrint('[KS] allowedCategories=${params.allowedCategories.map((e) => e.name).join(',')}');
    final mainCount = availableItems.where((e) => e.engineCategory.name == 'main').length;
    final vegMainCount = availableItems.where((e) => e.engineCategory.name == 'main' && e.dietaryTag.name == 'veg').length;
    final nonVegMainCount = availableItems.where((e) => e.engineCategory.name == 'main' && e.dietaryTag.name == 'nonVeg').length;
    debugPrint('[KS] mainItems=$mainCount (veg=$vegMainCount nonVeg=$nonVegMainCount)');
    final stallIds = rawItems.map((e) => e.stallId).toSet();
    debugPrint('[KS] stallIds=${stallIds.join(",")} stallMapSize=${stallMap.length}');
    // ── END DEBUG ──────────────────────────────────────────────────────────

    final int totalPeople = params.vegCount + params.nonVegCount;
    final minBudget = _estimateMinBudget(availableItems, params.vegCount, params.nonVegCount);

    bool snackMode = false;
    if (totalPeople > 0 && params.budget < minBudget) {
      // 2.2: Snack Mode Fallback
      snackMode = true;
    }

    debugPrint('[KS] minBudget=$minBudget snackMode=$snackMode');

    final balanced = _buildStrategy(params, availableItems, stallMap, StrategyType.balanced,
        wantSide: true, wantBeverage: true, singleStall: false, descending: false, snackMode: snackMode);
    final heavy = _buildStrategy(params, availableItems, stallMap, StrategyType.heavyweight,
        wantSide: true, wantBeverage: true, singleStall: false, descending: true, snackMode: snackMode);
    final express = _buildStrategy(params, availableItems, stallMap, StrategyType.express,
        wantSide: true, wantBeverage: false, singleStall: true, descending: false, snackMode: snackMode);

    final plans = <MealPlan?>[balanced, heavy, express].whereType<MealPlan>().toList();

    debugPrint('[KS] balanced=${balanced != null} heavy=${heavy != null} express=${express != null} total=${plans.length}');

    isar.close();

    return KnapsackResult(
      plans: plans,
      budgetTooTight: plans.isEmpty,
      minimumBudgetRequired: minBudget,
    );
  }

  static double _estimateMinBudget(List<MenuItem> items, int vegCount, int nonVegCount) {
    final filtered = items.where((e) => e.engineCategory == EngineCategory.main).toList();

    final cheapestVeg = filtered
        .where((e) => e.dietaryTag == DietaryTag.veg)
        .map((e) => e.taxAdjustedPrice)
        .fold<double>(double.infinity, (a, b) => a < b ? a : b);

    final cheapestNonVeg = filtered
        .where((e) => e.dietaryTag == DietaryTag.nonVeg)
        .map((e) => e.taxAdjustedPrice)
        .fold<double>(double.infinity, (a, b) => a < b ? a : b);

    double min = 0;
    if (vegCount > 0 && cheapestVeg != double.infinity) {
      min += cheapestVeg * vegCount;
    }
    if (nonVegCount > 0 && cheapestNonVeg != double.infinity) {
      min += cheapestNonVeg * nonVegCount;
    }
    return min * 1.1; // 10% buffer
  }

  static MealPlan? _buildStrategy(
    KnapsackParams params,
    List<MenuItem> availableItems,
    Map<String, Stall> stallMap,
    StrategyType type, {
    required bool wantSide,
    required bool wantBeverage,
    required bool singleStall,
    required bool descending,
    required bool snackMode,
  }) {
    final int totalPeople = params.vegCount + params.nonVegCount;
    if (totalPeople == 0) return null;

    final int maxAllowedStalls = singleStall ? 1 : params.maxStalls;
    final List<String> allowedCategoryNames = params.allowedCategories.map((e) => e.name).toList();

    // Filter items by allowed categories and disliked tags
    List<MenuItem> filtered = availableItems.where((e) {
      if (!allowedCategoryNames.contains(e.engineCategory.name)) return false;
      if (snackMode && e.engineCategory == EngineCategory.main) return false;
      return true;
    }).toList();

    // Apply dislike filter, but fall back to unfiltered if it removes all mains
    if (params.dislikedTags.isNotEmpty) {
      final withDislike = filtered.where((e) {
        final nameLower = e.name.toLowerCase();
        for (final tag in params.dislikedTags) {
          final t = tag.toLowerCase();
          if (nameLower.contains(t) || e.tags.any((et) => et.toLowerCase() == t)) return false;
        }
        return true;
      }).toList();
      final hasVegMain = withDislike.any((e) => e.engineCategory == EngineCategory.main && e.dietaryTag == DietaryTag.veg);
      final hasNonVegMain = withDislike.any((e) => e.engineCategory == EngineCategory.main && e.dietaryTag == DietaryTag.nonVeg);
      if ((params.vegCount == 0 || hasVegMain) && (params.nonVegCount == 0 || hasNonVegMain)) {
        filtered = withDislike;
      }
    }

    if (filtered.isEmpty) return null;

    // Score stalls by how many relevant mains they have
    final Map<String, _StallScore> stallScores = {};
    for (final item in filtered) {
      final score = stallScores.putIfAbsent(item.stallId, () => _StallScore(stallId: item.stallId, stallName: item.stallName));
      if (item.engineCategory == EngineCategory.main || snackMode) {
        if (item.dietaryTag == DietaryTag.veg) score.vegMains++;
        if (item.dietaryTag == DietaryTag.nonVeg) score.nonVegMains++;
      }
      score.totalItems++;
    }

    // Sort stalls: stalls with both veg+nonveg mains first, then by item count
    final sortedStalls = stallScores.values.toList()
      ..sort((a, b) {
        final aScore = (a.vegMains > 0 ? 2 : 0) + (a.nonVegMains > 0 ? 2 : 0) + a.totalItems;
        final bScore = (b.vegMains > 0 ? 2 : 0) + (b.nonVegMains > 0 ? 2 : 0) + b.totalItems;
        return bScore.compareTo(aScore);
      });

    // Helper: sort items by liked tags and price
    List<MenuItem> sortItems(List<MenuItem> items) {
      int cmp(MenuItem a, MenuItem b) {
        if (a.isVendorCombo && !b.isVendorCombo) return -1;
        if (!a.isVendorCombo && b.isVendorCombo) return 1;
        return descending
            ? b.taxAdjustedPrice.compareTo(a.taxAdjustedPrice)
            : a.taxAdjustedPrice.compareTo(b.taxAdjustedPrice);
      }
      if (params.likedTags.isEmpty) return items..sort(cmp);
      final liked = <MenuItem>[], other = <MenuItem>[];
      for (final item in items) {
        final n = item.name.toLowerCase();
        final isLiked = params.likedTags.any((t) => n.contains(t.toLowerCase()) || item.tags.any((et) => et.toLowerCase() == t.toLowerCase()));
        (isLiked ? liked : other).add(item);
      }
      liked.sort(cmp); other.sort(cmp);
      return [...liked, ...other];
    }

    // Generate stall combos
    List<List<_StallScore>> generateCombinations(List<_StallScore> list, int maxLen) {
      final result = <List<_StallScore>>[];
      void combine(int start, List<_StallScore> current) {
        if (current.isNotEmpty) result.add(List.from(current));
        if (current.length == maxLen) return;
        for (int i = start; i < list.length; i++) {
          current.add(list[i]);
          combine(i + 1, current);
          current.removeLast();
        }
      }
      combine(0, []);
      return result;
    }

    final topStalls = sortedStalls.take(10).toList();
    final stallCombinations = singleStall
        ? topStalls.map((s) => [s]).toList()
        : generateCombinations(topStalls, maxAllowedStalls);

    debugPrint('[KS-BS] type=${type.name} topStalls=${topStalls.length} combos=${stallCombinations.length} maxAllowed=$maxAllowedStalls singleStall=$singleStall');
    if (topStalls.isNotEmpty) {
      debugPrint('[KS-BS] stall0=${topStalls[0].stallId} veg=${topStalls[0].vegMains} nonveg=${topStalls[0].nonVegMains}');
    }
    debugPrint('[KS-BS] filteredCount=${filtered.length} stallScoreKeys=${stallScores.keys.join(",")}');

    MealPlan? bestPlan;
    double bestCost = -1;

    for (final selectedStalls in stallCombinations) {
      if (selectedStalls.isEmpty) continue;

      final selectedIds = selectedStalls.map((s) => s.stallId).toSet();
      final candidates = filtered.where((e) => selectedIds.contains(e.stallId)).toList();
      debugPrint('[KS-COMBO] selectedIds=${selectedIds.join(",")} candidates=${candidates.length}');

      // Check that this combo can satisfy dietary requirements
      final hasVegMain = candidates.any((e) => e.engineCategory == EngineCategory.main && e.dietaryTag == DietaryTag.veg);
      final hasNonVegMain = candidates.any((e) => e.engineCategory == EngineCategory.main && e.dietaryTag == DietaryTag.nonVeg);
      if (!snackMode) {
        if (params.vegCount > 0 && !hasVegMain) continue;
        if (params.nonVegCount > 0 && !hasNonVegMain) continue;
      }

      // Partition items
      List<MenuItem> vegMains, nonVegMains, sides, bevs;
      if (params.strictPureVeg) {
        final pureVegStalls = selectedStalls.where((s) => (stallScores[s.stallId]?.nonVegMains ?? 0) == 0).map((s) => s.stallId).toSet();
        vegMains = sortItems(candidates.where((e) => e.engineCategory == EngineCategory.main && e.dietaryTag == DietaryTag.veg && pureVegStalls.contains(e.stallId)).toList());
        sides = sortItems(candidates.where((e) => e.engineCategory == EngineCategory.side && pureVegStalls.contains(e.stallId)).toList());
        bevs = sortItems(candidates.where((e) => e.engineCategory == EngineCategory.beverage && pureVegStalls.contains(e.stallId)).toList());
      } else {
        vegMains = sortItems(candidates.where((e) => e.engineCategory == EngineCategory.main && e.dietaryTag == DietaryTag.veg).toList());
        sides = sortItems(candidates.where((e) => e.engineCategory == EngineCategory.side).toList());
        bevs = sortItems(candidates.where((e) => e.engineCategory == EngineCategory.beverage).toList());
      }
      nonVegMains = sortItems(candidates.where((e) => e.engineCategory == EngineCategory.main && e.dietaryTag == DietaryTag.nonVeg).toList());

      // Build assignments greedily
      final Map<int, List<MenuItem>> assignments = { for (int i = 0; i < totalPeople; i++) i: [] };
      double totalCost = 0;
      final Set<String> usedStalls = {};
      final Set<String> mainStalls = {}; // only stalls used for mains (for limit check)
      bool valid = true;

      // Step 1: Assign one main per person
      if (!snackMode) {
        int vi = 0, ni = 0;
        for (int p = 0; p < totalPeople; p++) {
          final isVeg = p < params.vegCount;
          MenuItem? main;
          if (isVeg && vegMains.isNotEmpty) {
            main = vegMains[vi % vegMains.length]; vi++;
          } else if (!isVeg && nonVegMains.isNotEmpty) {
            main = nonVegMains[ni % nonVegMains.length]; ni++;
          }
          if (main == null || totalCost + main.taxAdjustedPrice > params.budget) {
            debugPrint('[KS-FAIL] p=$p isVeg=$isVeg main=${main?.name ?? "NULL"} cost=${main?.taxAdjustedPrice} totalSoFar=$totalCost budget=${params.budget} vegMainsLen=${vegMains.length} nonVegMainsLen=${nonVegMains.length}');
            valid = false; break;
          }
          assignments[p]!.add(main);
          totalCost += main.taxAdjustedPrice;
          usedStalls.add(main.stallId);
          mainStalls.add(main.stallId);
        }
        if (!valid) continue;
        debugPrint('[KS-BS] combo OK: cost=$totalCost mains=${mainStalls.join(",")}');
      }

      // Step 2: Assign sides (one per person, skip if over budget)
      if (wantSide) {
        final usedSides = <String>{};
        for (int p = 0; p < totalPeople; p++) {
          for (final side in sides) {
            if (usedSides.contains(side.internalId)) continue;
            if (totalCost + side.taxAdjustedPrice <= params.budget) {
              assignments[p]!.add(side);
              totalCost += side.taxAdjustedPrice;
              usedStalls.add(side.stallId);
              usedSides.add(side.internalId);
              break;
            }
          }
        }
      }

      // Step 3: Assign beverages (one per person, skip if over budget)
      if (wantBeverage) {
        final usedBevs = <String>{};
        for (int p = 0; p < totalPeople; p++) {
          for (final bev in bevs) {
            if (usedBevs.contains(bev.internalId)) continue;
            if (totalCost + bev.taxAdjustedPrice <= params.budget) {
              assignments[p]!.add(bev);
              totalCost += bev.taxAdjustedPrice;
              usedStalls.add(bev.stallId);
              usedBevs.add(bev.internalId);
              break;
            }
          }
        }
      }

      // Step 4: Add packaging charges
      for (final sId in usedStalls) {
        double charge = stallMap[sId]?.packagingCharge ?? 0.0;
        if (charge.isNaN) charge = 0.0;
        totalCost += charge;
      }

      if (totalCost > params.budget) {
        debugPrint('[KS-BS] SKIP cost > budget: $totalCost > ${params.budget}');
        continue;
      }
      // Only count main-dish stalls toward the vendor limit
      if (mainStalls.length > maxAllowedStalls) {
        debugPrint('[KS-BS] SKIP mainStalls > max: ${mainStalls.length} > $maxAllowedStalls');
        continue;
      }

      if (totalCost > bestCost) {
        bestCost = totalCost;
        bestPlan = MealPlan(
          strategy: type,
          assignments: assignments,
          totalCost: totalCost,
          stallsUsed: usedStalls.map((id) => stallMap[id]?.name ?? id).toList(),
          withinBudget: true,
        );
        debugPrint('[KS-BS] bestPlan updated to $totalCost');
      } else {
        debugPrint('[KS-BS] totalCost $totalCost <= bestCost $bestCost');
      }
    }

    debugPrint('[KS-BS] loop finished, bestPlan != null: ${bestPlan != null}');
    return bestPlan;

    return bestPlan;
  }
}

class _StallScore {
  final String stallId;
  final String stallName;
  int vegMains = 0;
  int nonVegMains = 0;
  int totalItems = 0;

  _StallScore({required this.stallId, required this.stallName});
}
