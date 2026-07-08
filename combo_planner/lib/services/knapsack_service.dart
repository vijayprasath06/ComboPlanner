import 'package:flutter/foundation.dart';
import '../domain/models/menu_item.dart';
import '../domain/models/meal_plan.dart';
import '../domain/enums/dietary_tag.dart';
import '../domain/enums/engine_category.dart';

class KnapsackParams {
  final double budget;
  final int vegCount;
  final int nonVegCount;
  final int maxStalls;
  final List<MenuItem> availableItems;
  final List<EngineCategory> allowedCategories;
  final Set<String> likedTags;
  final Set<String> dislikedTags;

  KnapsackParams({
    required this.budget,
    required this.vegCount,
    required this.nonVegCount,
    required this.maxStalls,
    required this.availableItems,
    required this.allowedCategories,
    this.likedTags = const {},
    this.dislikedTags = const {},
  });
}

/// Holds the result of a knapsack computation including failure info.
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
    final int totalPeople = params.vegCount + params.nonVegCount;

    // Estimate minimum viable budget before we try anything
    final minBudget = _estimateMinBudget(params);
    if (totalPeople > 0 && params.budget < minBudget) {
      return KnapsackResult(
        plans: [],
        budgetTooTight: true,
        minimumBudgetRequired: minBudget,
      );
    }

    final balanced = _buildStrategy(params, StrategyType.balanced,
        wantSide: true, wantBeverage: true, singleStall: false, descending: false);
    final heavy = _buildStrategy(params, StrategyType.heavyweight,
        wantSide: true, wantBeverage: true, singleStall: false, descending: true);
    final express = _buildStrategy(params, StrategyType.express,
        wantSide: true, wantBeverage: false, singleStall: true, descending: false);

    final plans = [
      if (balanced != null) balanced,
      if (heavy != null) heavy,
      if (express != null) express,
    ];

    return KnapsackResult(
      plans: plans,
      budgetTooTight: plans.isEmpty,
      minimumBudgetRequired: minBudget,
    );
  }

  /// Estimate minimum budget needed to feed all people with cheapest mains.
  static double _estimateMinBudget(KnapsackParams params) {
    final filtered = params.availableItems
        .where((e) => e.engineCategory == EngineCategory.main)
        .toList();

    final cheapestVeg = filtered
        .where((e) => e.dietaryTag == DietaryTag.veg)
        .map((e) => e.taxAdjustedPrice)
        .fold<double>(double.infinity, (a, b) => a < b ? a : b);

    final cheapestNonVeg = filtered
        .where((e) => e.dietaryTag == DietaryTag.nonVeg)
        .map((e) => e.taxAdjustedPrice)
        .fold<double>(double.infinity, (a, b) => a < b ? a : b);

    double min = 0;
    if (params.vegCount > 0 && cheapestVeg != double.infinity) {
      min += cheapestVeg * params.vegCount;
    }
    if (params.nonVegCount > 0 && cheapestNonVeg != double.infinity) {
      min += cheapestNonVeg * params.nonVegCount;
    }
    // Add 10% buffer for sides
    return min * 1.1;
  }

  /// Deterministic greedy knapsack with FAIR per-person budget allocation.
  ///
  /// Fair = totalBudget / totalPeople → each person gets an equal share.
  /// Preferences: disliked items are excluded, liked items are boosted (sorted first).
  static MealPlan? _buildStrategy(
    KnapsackParams params,
    StrategyType type, {
    required bool wantSide,
    required bool wantBeverage,
    required bool singleStall,
    required bool descending,
  }) {
    final int totalPeople = params.vegCount + params.nonVegCount;
    if (totalPeople == 0) return null;

    // ── FAIR BUDGET: each person gets an equal share ──
    final double perPersonBudget = params.budget / totalPeople;

    final int maxAllowedStalls = singleStall ? 1 : params.maxStalls;
    final List<String> allowedCategoryNames =
        params.allowedCategories.map((e) => e.name).toList();

    // Filter: allowed categories + exclude disliked items
    final filtered = params.availableItems.where((e) {
      if (!allowedCategoryNames.contains(e.engineCategory.name)) return false;
      // Exclude items whose name, category, or tags match any disliked tag
      if (params.dislikedTags.isNotEmpty) {
        final nameLower = e.name.toLowerCase();
        final catLower = e.engineCategory.name.toLowerCase();
        for (final tag in params.dislikedTags) {
          final tLower = tag.toLowerCase();
          if (nameLower.contains(tLower) || catLower == tLower || e.tags.any((et) => et.toLowerCase() == tLower)) {
            return false;
          }
        }
      }
      return true;
    }).toList();

    if (filtered.isEmpty) return null;

    // Score each stall
    final Map<String, _StallScore> stallScores = {};
    for (final item in filtered) {
      final score = stallScores.putIfAbsent(
          item.stallId,
          () => _StallScore(stallId: item.stallId, stallName: item.stallName));
      if (item.engineCategory == EngineCategory.main) {
        if (item.dietaryTag == DietaryTag.veg) score.vegMains++;
        if (item.dietaryTag == DietaryTag.nonVeg) score.nonVegMains++;
      }
      score.totalItems++;
    }

    final sortedStalls = stallScores.values.toList()
      ..sort((a, b) {
        final aHasBoth = (a.vegMains > 0 && a.nonVegMains > 0) ? 1 : 0;
        final bHasBoth = (b.vegMains > 0 && b.nonVegMains > 0) ? 1 : 0;
        if (bHasBoth != aHasBoth) return bHasBoth.compareTo(aHasBoth);
        return b.totalItems.compareTo(a.totalItems);
      });

    MealPlan? bestPlan;
    double bestCost = -1;

    final maxAttempts = singleStall ? sortedStalls.length : 1;
    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      List<_StallScore> selectedStalls;
      if (singleStall) {
        selectedStalls = [sortedStalls[attempt]];
      } else {
        selectedStalls = sortedStalls.take(maxAllowedStalls).toList();
      }

      final selectedIds = selectedStalls.map((s) => s.stallId).toSet();
      final candidates =
          filtered.where((e) => selectedIds.contains(e.stallId)).toList();

      // Sort with preference boost: liked items appear first
      List<MenuItem> _sortWithPreferences(List<MenuItem> items) {
        int comparePrices(MenuItem a, MenuItem b) {
          return descending 
            ? b.taxAdjustedPrice.compareTo(a.taxAdjustedPrice)
            : a.taxAdjustedPrice.compareTo(b.taxAdjustedPrice);
        }
        
        if (params.likedTags.isEmpty) {
          return items..sort(comparePrices);
        }
        final liked = <MenuItem>[];
        final neutral = <MenuItem>[];
        for (final item in items) {
          final nameLower = item.name.toLowerCase();
          final catLower = item.engineCategory.name.toLowerCase();
          final isLiked = params.likedTags.any((tag) {
            final tLower = tag.toLowerCase();
            return nameLower.contains(tLower) || catLower == tLower || item.tags.any((et) => et.toLowerCase() == tLower);
          });
          if (isLiked) liked.add(item); else neutral.add(item);
        }
        liked.sort(comparePrices);
        neutral.sort(comparePrices);
        return [...liked, ...neutral];
      }

      final vegMains = _sortWithPreferences(candidates
          .where((e) =>
              e.engineCategory == EngineCategory.main &&
              e.dietaryTag == DietaryTag.veg)
          .toList());

      final nonVegMains = _sortWithPreferences(candidates
          .where((e) =>
              e.engineCategory == EngineCategory.main &&
              e.dietaryTag == DietaryTag.nonVeg)
          .toList());

      final sides = candidates
          .where((e) => e.engineCategory == EngineCategory.side)
          .toList()
        ..sort((a, b) => descending 
          ? b.taxAdjustedPrice.compareTo(a.taxAdjustedPrice)
          : a.taxAdjustedPrice.compareTo(b.taxAdjustedPrice));

      final bevs = candidates
          .where((e) => e.engineCategory == EngineCategory.beverage)
          .toList()
        ..sort((a, b) => descending 
          ? b.taxAdjustedPrice.compareTo(a.taxAdjustedPrice)
          : a.taxAdjustedPrice.compareTo(b.taxAdjustedPrice));

      if (params.vegCount > 0 && vegMains.isEmpty) continue;
      if (params.nonVegCount > 0 && nonVegMains.isEmpty) continue;

      final Map<int, List<MenuItem>> assignments = {};
      double totalCost = 0;
      bool valid = true;

      int vegIndex = 0, nonVegIndex = 0;

      // ── PASS 1: Mains — each person limited to perPersonBudget ──
      for (int p = 0; p < totalPeople; p++) {
        final isVeg = p < params.vegCount;
        MenuItem mainItem;
        if (isVeg) {
          mainItem = vegMains[vegIndex % vegMains.length];
          vegIndex++;
        } else {
          mainItem = nonVegMains[nonVegIndex % nonVegMains.length];
          nonVegIndex++;
        }

        // Fair check: main must fit within this person's share
        if (mainItem.taxAdjustedPrice > perPersonBudget) {
          valid = false;
          break;
        }

        assignments[p] = [mainItem];
        totalCost += mainItem.taxAdjustedPrice;
      }

      if (!valid) continue;

      // ── PASS 2: Sides — each person uses their own remaining budget ──
      if (wantSide && sides.isNotEmpty) {
        int sideIndex = 0;
        for (int p = 0; p < totalPeople; p++) {
          final personSpend = assignments[p]!
              .fold(0.0, (sum, item) => sum + item.taxAdjustedPrice);
          final personRemaining = perPersonBudget - personSpend;
          final side = sides[sideIndex % sides.length];
          if (side.taxAdjustedPrice <= personRemaining) {
            assignments[p]!.add(side);
            totalCost += side.taxAdjustedPrice;
          }
          sideIndex++;
        }
      }

      // ── PASS 3: Beverages — same per-person fairness ──
      if (wantBeverage && bevs.isNotEmpty) {
        int bevIndex = 0;
        for (int p = 0; p < totalPeople; p++) {
          final personSpend = assignments[p]!
              .fold(0.0, (sum, item) => sum + item.taxAdjustedPrice);
          final personRemaining = perPersonBudget - personSpend;
          final bev = bevs[bevIndex % bevs.length];
          if (bev.taxAdjustedPrice <= personRemaining) {
            assignments[p]!.add(bev);
            totalCost += bev.taxAdjustedPrice;
          }
          bevIndex++;
        }
      }

      if (totalCost > bestCost && totalCost <= params.budget) {
        bestCost = totalCost;
        bestPlan = MealPlan(
          strategy: type,
          assignments: assignments,
          totalCost: totalCost,
          stallsUsed: selectedStalls.map((s) => s.stallName).toList(),
          withinBudget: true,
        );
        if (!singleStall) break;
      }
    }

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
