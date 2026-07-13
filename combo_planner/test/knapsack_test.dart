import 'package:flutter_test/flutter_test.dart';
import 'package:combo_planner/domain/models/mall.dart';
import 'package:combo_planner/domain/models/menu_item.dart';
import 'package:combo_planner/domain/models/stall.dart';
import 'package:combo_planner/domain/models/trending_combo.dart';
import 'package:combo_planner/domain/models/plan_history.dart';
import 'package:combo_planner/domain/enums/engine_category.dart';
import 'package:combo_planner/services/knapsack_service.dart';
import 'package:combo_planner/data/seed/seed_data.dart';
import 'package:isar/isar.dart';
import 'dart:io';

void main() {
  late Isar isar;
  late Directory tempDir;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
    tempDir = Directory.systemTemp.createTempSync('isar_test');
    isar = await Isar.open(
      [MallSchema, MenuItemSchema, StallSchema, TrendingComboSchema, PlanHistorySchema],
      directory: tempDir.path,
    );
    await seedDatabase(isar);
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  KnapsackParams makeParams({required int veg, required int nonVeg, required double budget, int maxStalls = 2}) {
    return KnapsackParams(
      budget: budget,
      vegCount: veg,
      nonVegCount: nonVeg,
      mallId: 'm1',
      maxStalls: maxStalls,
      allowedCategories: [EngineCategory.main, EngineCategory.side, EngineCategory.beverage],
      strictPureVeg: false,
      likedTags: <String>{},
      dislikedTags: <String>{},
      blacklistedItemIds: <String>{},
      isarDirectory: tempDir.path,
    );
  }

  test('veg=1 nonVeg=1 budget=1000 maxStalls=2', () async {
    final r = await KnapsackService.computePlans(makeParams(veg: 1, nonVeg: 1, budget: 1000));
    print('Plans: ${r.plans.length}, budgetTooTight: ${r.budgetTooTight}, minBudget: ${r.minimumBudgetRequired}');
    for (var p in r.plans) print('  ${p.strategy.name} cost=${p.totalCost}');
    expect(r.plans.isNotEmpty, true, reason: 'Should find at least one plan');
  });

  test('veg=0 nonVeg=2 budget=1000 maxStalls=2', () async {
    final r = await KnapsackService.computePlans(makeParams(veg: 0, nonVeg: 2, budget: 1000));
    print('Plans: ${r.plans.length}, budgetTooTight: ${r.budgetTooTight}, minBudget: ${r.minimumBudgetRequired}');
    for (var p in r.plans) print('  ${p.strategy.name} cost=${p.totalCost}');
    expect(r.plans.isNotEmpty, true, reason: 'Should find at least one plan');
  });

  test('veg=3 nonVeg=1 budget=1000 maxStalls=2', () async {
    final r = await KnapsackService.computePlans(makeParams(veg: 3, nonVeg: 1, budget: 1000));
    print('Plans: ${r.plans.length}, budgetTooTight: ${r.budgetTooTight}, minBudget: ${r.minimumBudgetRequired}');
    for (var p in r.plans) print('  ${p.strategy.name} cost=${p.totalCost}');
    expect(r.plans.isNotEmpty, true, reason: 'Should find at least one plan');
  });

  test('veg=2 nonVeg=2 budget=1000 maxStalls=2', () async {
    final r = await KnapsackService.computePlans(makeParams(veg: 2, nonVeg: 2, budget: 1000));
    print('Plans: ${r.plans.length}, budgetTooTight: ${r.budgetTooTight}, minBudget: ${r.minimumBudgetRequired}');
    for (var p in r.plans) print('  ${p.strategy.name} cost=${p.totalCost}');
    expect(r.plans.isNotEmpty, true, reason: 'Should find at least one plan');
  });
}
