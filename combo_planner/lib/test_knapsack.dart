import 'dart:io';
import 'package:combo_planner/domain/enums/dietary_tag.dart';
import 'package:combo_planner/domain/enums/engine_category.dart';
import 'package:combo_planner/domain/models/mall.dart';
import 'package:combo_planner/domain/models/menu_item.dart';
import 'package:combo_planner/domain/models/stall.dart';
import 'package:combo_planner/services/knapsack_service.dart';

void main() async {
  // Mock the DB inputs directly instead of using Isar to avoid path issues.
  
  final items = [
    MenuItem()..id=1..internalId='i1'..name='Veg Burger'..basePrice=100..taxAdjustedPrice=105..engineCategory=EngineCategory.main..dietaryTag=DietaryTag.veg..stallId='s1'..tags=['Fast Food'],
    MenuItem()..id=2..internalId='i2'..name='Chicken Burger'..basePrice=150..taxAdjustedPrice=157.5..engineCategory=EngineCategory.main..dietaryTag=DietaryTag.nonVeg..stallId='s1'..tags=['Fast Food'],
    MenuItem()..id=3..internalId='i3'..name='Fries'..basePrice=50..taxAdjustedPrice=52.5..engineCategory=EngineCategory.side..dietaryTag=DietaryTag.veg..stallId='s1'..tags=['Fast Food'],
    MenuItem()..id=4..internalId='i4'..name='Coke'..basePrice=40..taxAdjustedPrice=42..engineCategory=EngineCategory.beverage..dietaryTag=DietaryTag.veg..stallId='s1'..tags=['Beverage'],
  ];
  
  final stalls = [
    Stall()..id=1..stallId='s1'..name='Burger Shop'..mallId='m1'..cuisineType='Fast Food'..isPureVeg=false,
  ];
  
  final params = KnapsackParams(
    budget: 500.0,
    vegCount: 1,
    nonVegCount: 1,
    mallId: 'm1',
    likedTags: [],
    dislikedTags: [],
    blacklistedItemIds: [],
    strictPureVeg: false,
  );
  
  print('Starting knapsack...');
  final result = await KnapsackService.generatePlans(params, items, stalls);
  
  print('Budget Too Tight: \${result.budgetTooTight}');
  print('Heavy: \${result.heavyPlan != null}');
  print('Balanced: \${result.balancedPlan != null}');
  print('Express: \${result.expressPlan != null}');
}
