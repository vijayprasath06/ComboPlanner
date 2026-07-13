import 'package:isar/isar.dart';
import 'package:combo_planner/domain/models/mall.dart';
import 'package:combo_planner/domain/models/menu_item.dart';
import 'package:combo_planner/domain/models/stall.dart';
import 'package:combo_planner/domain/models/trending_combo.dart';
import 'package:combo_planner/domain/models/plan_history.dart';
import 'package:combo_planner/services/knapsack_service.dart';

void main() async {
  await Isar.initializeIsarCore(download: true);
  
  final params = KnapsackParams(
    budget: 300.0,
    vegCount: 1,
    nonVegCount: 1,
    mallId: 'm1',
    maxStalls: 3,
    allowedCategories: ['main', 'side', 'beverage'],
    strictPureVeg: false,
    likedTags: [],
    dislikedTags: [],
    blacklistedItemIds: [],
    isarDirectory: 'C:\\Users\\admin\\.gemini\\antigravity\\brain\\b640f0ad-f14b-4141-808f-8bad67eb67c9',
  );

  final result = await KnapsackService.computePlans(params);
  
  print('Budget Too Tight: \${result.budgetTooTight}');
  print('Min Budget: \${result.minimumBudgetRequired}');
  print('Plans length: \${result.plans.length}');
  for (var p in result.plans) {
    print('Plan: \${p.strategy.name} - Cost: \${p.totalCost}');
  }
}
