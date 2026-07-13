import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/mall.dart';
import '../domain/models/meal_plan.dart';
import '../domain/models/plan_history.dart';
import '../domain/models/trending_combo.dart';
import '../data/repositories/menu_repository.dart';
import '../services/time_engine_service.dart';
import '../services/knapsack_service.dart';
import '../services/supabase_service.dart';
import '../domain/enums/engine_category.dart';
import '../domain/models/menu_item.dart';

class PlannerProvider with ChangeNotifier {
  final MenuRepository repository;
  final Isar isar;
  final TimeEngineService timeEngine = TimeEngineService();

  PlannerProvider(this.repository, this.isar);

  Mall? selectedMall;
  double budget = 1000.0;
  int vegCount = 2;
  int nonVegCount = 2;
  int vendorLimit = 2;
  bool strictPureVeg = false;

  bool applyZomatoGold = false;
  bool applySwiggyDineout = false;
  String mealTime = 'Now';

  bool get isGenerateDisabled {
    if (vegCount + nonVegCount == 0) return true;
    if (vendorLimit == 1 && strictPureVeg && vegCount > 0 && nonVegCount > 0) return true;
    return false;
  }

  // User food preferences (wired in from UserProvider after login)
  Set<String> userLikedTags    = {};
  Set<String> userDislikedTags = {};

  List<EngineCategory> whitelistedCategories = [];
  List<MealPlan> mealPlans   = [];
  List<PlanHistory> planHistory = [];
  Set<String> blacklistedItemIds = {};

  // Budget-too-tight state
  bool budgetTooTight            = false;
  double minimumBudgetRequired   = 0;

  bool isGenerating    = false;
  bool isSavingHistory = false;

  // ── Hot-swap state ───────────────────────────────────────────────────────
  bool _isHotSwapping = false;
  bool get isHotSwapping => _isHotSwapping;

  // Message shown when a swap finds no alternatives
  String? swapFailureMessage;

  // ── Setters ──────────────────────────────────────────────────────────────

  void setMall(Mall mall) {
    selectedMall = mall;
    notifyListeners();
  }

  void updateBudget(double value) {
    budget = value;
    notifyListeners();
  }

  void updateVegCount(int count) {
    if (count >= 0) vegCount = count;
    notifyListeners();
  }

  void updateNonVegCount(int count) {
    if (count >= 0) nonVegCount = count;
    notifyListeners();
  }

  void updateVendorLimit(int limit) {
    if (limit >= 1 && limit <= 3) vendorLimit = limit;
    notifyListeners();
  }

  void toggleStrictPureVeg(bool value) {
    strictPureVeg = value;
    notifyListeners();
  }

  void toggleZomatoGold(bool value) {
    applyZomatoGold = value;
    notifyListeners();
  }

  void toggleSwiggyDineout(bool value) {
    applySwiggyDineout = value;
    notifyListeners();
  }

  void updateMealTime(String time) {
    mealTime = time;
    notifyListeners();
  }

  void refreshState() {
    notifyListeners();
  }

  /// Called by UserProvider after login to sync food preferences.
  void setUserPreferences({
    required Set<String> liked,
    required Set<String> disliked,
  }) {
    userLikedTags    = liked;
    userDislikedTags = disliked;
    // Don't regenerate automatically — user must tap "Generate" again
  }

  // ── Plan Generation ──────────────────────────────────────────────────────

  Future<void> generatePlans() async {
    if (selectedMall == null) return;

    isGenerating = true;
    budgetTooTight = false;
    swapFailureMessage = null;
    notifyListeners();

    try {
      whitelistedCategories = timeEngine.getWhitelistedCategories();

      double effectiveBudget = budget;
      if (applyZomatoGold || applySwiggyDineout) {
        effectiveBudget = budget / 0.85; // 15% discount inflation
      }

      final params = KnapsackParams(
        isarDirectory: isar.directory!,
        mallId: selectedMall!.mallId,
        blacklistedItemIds: blacklistedItemIds,
        strictPureVeg: strictPureVeg,
        budget: effectiveBudget,
        vegCount: vegCount,
        nonVegCount: nonVegCount,
        maxStalls: vendorLimit,
        allowedCategories: whitelistedCategories,
        likedTags: userLikedTags,
        dislikedTags: userDislikedTags,
      );

      final result = await KnapsackService.computePlans(params);
      mealPlans             = result.plans;
      budgetTooTight        = result.budgetTooTight;
      minimumBudgetRequired = result.minimumBudgetRequired;
    } finally {
      isGenerating = false;
      notifyListeners();
    }
  }

  // ── Hot-Swap (crash-safe) ─────────────────────────────────────────────────
  //
  // Fix for the "app stops after 2 swaps" bug:
  //   • Guard: only one swap at a time (prevents concurrent generation)
  //   • Snapshot: save current plans before swapping
  //   • Rollback: if new generation yields empty plans, undo the blacklist
  //     and restore the previous plans — instead of showing a blank screen
  //   • Blacklist cap: if blacklist grows to 10+ items, clear it to allow
  //     fresh results (prevents "no items left" deadlock)
  Future<void> hotSwapItem(String internalId) async {
    if (_isHotSwapping || isGenerating) return; // prevent concurrent swaps

    _isHotSwapping = true;
    swapFailureMessage = null;
    notifyListeners();

    // Cap blacklist to prevent deadlock
    if (blacklistedItemIds.length >= 10) {
      blacklistedItemIds.clear();
    }

    final snapshot = List<MealPlan>.from(mealPlans);
    blacklistedItemIds.add(internalId);

    try {
      await generatePlans();

      // Rollback if regeneration produced no plans
      if (mealPlans.isEmpty && snapshot.isNotEmpty) {
        blacklistedItemIds.remove(internalId);
        mealPlans          = snapshot;
        budgetTooTight     = false;
        swapFailureMessage = 'No other options available for this item.';
        notifyListeners();
      }
    } finally {
      _isHotSwapping = false;
      notifyListeners();
    }
  }

  // ── Plan History ──────────────────────────────────────────────────────────

  Future<void> loadHistory() async {
    final localHistory = await isar.planHistorys
        .where()
        .sortBySavedAtDesc()
        .findAll();
        
    List<PlanHistory> cloudHistory = [];
    try {
      final supabaseService = SupabaseService();
      cloudHistory = await supabaseService.fetchUserHistory();
    } catch (_) {}
    
    final allHistoryMap = <String, PlanHistory>{};
    
    // Add local first
    for (var h in localHistory) {
      final key = '\${h.mallId}_\${h.savedAt.millisecondsSinceEpoch}';
      allHistoryMap[key] = h;
    }
    
    // Merge cloud (overwrites if same mall/time, but mostly additive for cross-device)
    for (var h in cloudHistory) {
      final key = '\${h.mallId}_\${h.savedAt.millisecondsSinceEpoch}';
      allHistoryMap[key] = h;
    }
    
    planHistory = allHistoryMap.values.toList()
      ..sort((a, b) {
        final aTime = a.savedAt;
        final bTime = b.savedAt;
        return bTime.compareTo(aTime);
      });
      
    notifyListeners();
  }

  Future<void> clearHistory() async {
    await isar.writeTxn(() async {
      await isar.planHistorys.clear();
    });
    planHistory = [];
    notifyListeners();
  }

  /// Save accepted plan to history (max 20, rolling 30-day delete)
  Future<void> acceptPlan(MealPlan plan) async {
    if (selectedMall == null) return;

    isSavingHistory = true;
    notifyListeners();

    try {
      final allItems   = plan.assignments.values.expand((items) => items).toList();
      final itemNames  = allItems.map((e) => e.name).toList();
      final shareText  = _buildShareText(plan, allItems);

      final history = PlanHistory()
        ..mallId       = selectedMall!.mallId
        ..mallName     = selectedMall!.name
        ..strategyName = _strategyLabel(plan.strategy)
        ..totalCost    = plan.totalCost
        ..peopleCount  = plan.assignments.length
        ..savedAt      = DateTime.now()
        ..stallsUsed   = plan.stallsUsed
        ..itemNames    = itemNames
        ..shareText    = shareText;

      await isar.writeTxn(() async {
        await isar.planHistorys.put(history);
      });

      // ── Cloud Sync ──────────────────────────────────────────────────────────
      try {
        final supabaseService = SupabaseService();
        await supabaseService.savePlanHistory(history);
      } catch (_) {
        // Fallback to local only for now if offline
      }

      await _enforceHistoryLimit();
      await _feedTrendingCombo(plan, allItems);
      await loadHistory();
    } finally {
      isSavingHistory = false;
      notifyListeners();
    }
  }

  Future<void> _enforceHistoryLimit() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 30));
    await isar.writeTxn(() async {
      final old = await isar.planHistorys
          .filter()
          .savedAtLessThan(cutoff)
          .findAll();
      await isar.planHistorys.deleteAll(old.map((e) => e.id).toList());
    });

    final all = await isar.planHistorys.where().sortBySavedAtDesc().findAll();
    if (all.length > 20) {
      final toDelete = all.sublist(20);
      await isar.writeTxn(() async {
        await isar.planHistorys.deleteAll(toDelete.map((e) => e.id).toList());
      });
    }
  }

  Future<void> _feedTrendingCombo(MealPlan plan, List<MenuItem> items) async {
    if (selectedMall == null) return;

    final label     = '${_strategyLabel(plan.strategy)} @ ${selectedMall!.name}';
    final itemNames = items.map((e) => e.name).toList();

    final existing = await isar.trendingCombos
        .filter()
        .mallIdEqualTo(selectedMall!.mallId)
        .and()
        .labelEqualTo(label)
        .findFirst();

    await isar.writeTxn(() async {
      if (existing != null) {
        existing.acceptedCount++;
        await isar.trendingCombos.put(existing);
      } else {
        final newCombo = TrendingCombo()
          ..mallId       = selectedMall!.mallId
          ..label        = label
          ..items        = itemNames.take(4).toList()
          ..totalPrice   = plan.totalCost
          ..acceptedCount = 1;
        await isar.trendingCombos.put(newCombo);
      }
    });
  }

  String _strategyLabel(StrategyType type) {
    switch (type) {
      case StrategyType.balanced:    return 'Balanced Meal';
      case StrategyType.heavyweight: return 'Heavyweight';
      case StrategyType.express:     return 'Single-Stall Express';
    }
  }

  /// Public wrapper for share text (used by PlanDetailScreen)
  String buildShareTextPublic(MealPlan plan, List<MenuItem> items) {
    return _buildShareText(plan, items);
  }

  String _buildShareText(MealPlan plan, List<MenuItem> items) {
    final mall      = selectedMall?.name ?? 'Food Court';
    final strategy  = _strategyLabel(plan.strategy);
    final total     = plan.totalCost.toStringAsFixed(0);
    final people    = plan.assignments.length;
    final perPerson = (plan.totalCost / people).toStringAsFixed(0);
    final stalls    = plan.stallsUsed.join(' → ');

    final Map<String, int> itemCounts = {};
    for (final item in items) {
      itemCounts[item.name] = (itemCounts[item.name] ?? 0) + 1;
    }
    final itemList = itemCounts.entries
        .map((e) => e.value > 1 ? '${e.value}x ${e.key}' : e.key)
        .take(6)
        .join(', ');

    return '🔥 Combo Planner — $mall\n'
        '📋 $strategy | $people people\n'
        '🏪 Route: $stalls\n'
        '🍴 $itemList\n'
        '💰 Total: ₹$total (≈₹$perPerson/person)\n'
        '📶 Planned with Combo Planner';
  }

  // ── Seeding Flag ──────────────────────────────────────────────────────────

  static Future<bool> isAlreadySeeded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('db_seeded_v1') ?? false;
  }

  static Future<void> markSeeded() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('db_seeded_v1', true);
  }
}
