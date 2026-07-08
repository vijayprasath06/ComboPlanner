import 'package:isar/isar.dart';

part 'plan_history.g.dart';

@collection
class PlanHistory {
  Id id = Isar.autoIncrement;

  late String mallId;
  late String mallName;
  late String strategyName;
  late double totalCost;
  late int peopleCount;
  late DateTime savedAt;

  /// JSON-encoded stall route list e.g. ["KFC", "Subway"]
  late List<String> stallsUsed;

  /// JSON-encoded flat list of item names for display
  late List<String> itemNames;

  /// Plain-text share string generated at save time
  late String shareText;
}
