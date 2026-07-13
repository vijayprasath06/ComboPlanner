import 'package:isar/isar.dart';

part 'stall.g.dart';

@collection
class Stall {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String stallId;

  late String name;
  late String mallId;
  late String cuisineType;
  
  double packagingCharge = 0.0;
  bool isPureVeg = false;
}
