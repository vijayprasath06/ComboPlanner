import 'package:isar/isar.dart';

part 'mall.g.dart';

@collection
class Mall {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String mallId;

  late String name;
  late String location;
  late double lat;
  late double lng;
}
