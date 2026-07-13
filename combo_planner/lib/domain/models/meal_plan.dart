import 'menu_item.dart';

enum StrategyType {
  balanced,
  heavyweight,
  express
}

class MealPlan {
  final StrategyType strategy;
  final Map<int, List<MenuItem>> assignments;
  double totalCost;
  final List<String> stallsUsed;
  final bool withinBudget;

  MealPlan({
    required this.strategy,
    required this.assignments,
    required this.totalCost,
    required this.stallsUsed,
    required this.withinBudget,
  });
}
