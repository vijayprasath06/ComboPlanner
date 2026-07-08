import 'package:isar/isar.dart';

part 'trending_combo.g.dart';

@collection
class TrendingCombo {
  Id id = Isar.autoIncrement;

  late String mallId;
  late String label;
  late List<String> items;
  late double totalPrice;
  late int acceptedCount;
  late DateTime timestamp;
}
