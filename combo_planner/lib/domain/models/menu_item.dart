import 'package:isar/isar.dart';
import '../enums/engine_category.dart';
import '../enums/dietary_tag.dart';

part 'menu_item.g.dart';

@collection
class MenuItem {
  Id id = Isar.autoIncrement;

  late String internalId;

  late String name;
  late double basePrice;
  late double taxAdjustedPrice;

  @Enumerated(EnumType.name)
  late EngineCategory engineCategory;

  @Enumerated(EnumType.name)
  late DietaryTag dietaryTag;

  late List<String> tags;
  
  late String stallId;
  late String stallName;
  late String mallId;
  
  bool isBlacklisted = false;
  bool isVendorCombo = false;
  int estimatedPrepTimeMins = 10;
}
