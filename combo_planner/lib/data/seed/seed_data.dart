import 'package:isar/isar.dart';
import '../../domain/enums/engine_category.dart';
import '../../domain/enums/dietary_tag.dart';
import '../../domain/models/mall.dart';
import '../../domain/models/stall.dart';
import '../../domain/models/menu_item.dart';
import '../../domain/models/trending_combo.dart';

bool _isSeeding = false;

Future<void> seedDatabase(Isar isar) async {
  if (_isSeeding) return;
  _isSeeding = true;
  
  try {
    if (await isar.malls.count() > 0) {
      return;
    }

    await isar.writeTxn(() async {
      await isar.malls.clear();
      await isar.stalls.clear();
      await isar.menuItems.clear();
      await isar.trendingCombos.clear();

      final malls = [
        Mall()..id = 1..mallId = 'm1'..name = 'VR Chennai'..location = 'Anna Nagar'..lat = 13.0841..lng = 80.1983,
        Mall()..id = 2..mallId = 'm2'..name = 'Phoenix Marketcity'..location = 'Velachery'..lat = 12.9915..lng = 80.2166,
        Mall()..id = 3..mallId = 'm3'..name = 'Express Avenue'..location = 'Royapettah'..lat = 13.0583..lng = 80.2638,
        Mall()..id = 4..mallId = 'm4'..name = 'Nexus Vijaya Mall'..location = 'Vadapalani'..lat = 13.0485..lng = 80.2104,
        Mall()..id = 5..mallId = 'm5'..name = 'The Marina Mall'..location = 'OMR, Egattur'..lat = 12.8258..lng = 80.2223,
        Mall()..id = 6..mallId = 'm6'..name = 'Ampa Skywalk'..location = 'Aminjikarai'..lat = 13.0734..lng = 80.2212,
      ];
      await isar.malls.putAll(malls);

      int stallCounter = 1;
      int itemCounter = 1;
      int comboCounter = 1;

      final stallTemplates = [
        {
          'name': 'KFC',
          'cuisine': 'Fast Food',
          'items': [
            {'name': 'Zinger Burger', 'basePrice': 249.0, 'cat': EngineCategory.main, 'diet': DietaryTag.nonVeg, 'tags': ['Fast Food']},
            {'name': 'Popcorn Chicken', 'basePrice': 189.0, 'cat': EngineCategory.side, 'diet': DietaryTag.nonVeg, 'tags': ['Fast Food']},
            {'name': 'Hot Wings', 'basePrice': 169.0, 'cat': EngineCategory.side, 'diet': DietaryTag.nonVeg, 'tags': ['Fast Food']},
            {'name': 'Veg Zinger', 'basePrice': 199.0, 'cat': EngineCategory.main, 'diet': DietaryTag.veg, 'tags': ['Fast Food']},
            {'name': 'Fries', 'basePrice': 109.0, 'cat': EngineCategory.side, 'diet': DietaryTag.veg, 'tags': ['Fast Food']},
            {'name': 'Pepsi', 'basePrice': 69.0, 'cat': EngineCategory.beverage, 'diet': DietaryTag.veg, 'tags': ['Beverage']},
            {'name': 'Chicken Roll', 'basePrice': 149.0, 'cat': EngineCategory.main, 'diet': DietaryTag.nonVeg, 'tags': ['Fast Food']},
            {'name': 'Choco Lava Cake', 'basePrice': 99.0, 'cat': EngineCategory.side, 'diet': DietaryTag.veg, 'tags': ['Dessert']},
          ],
        },
        {
          'name': 'Sangeetha',
          'cuisine': 'South Indian',
          'items': [
            {'name': 'Ghee Roast Dosa', 'basePrice': 129.0, 'cat': EngineCategory.main, 'diet': DietaryTag.veg, 'tags': ['South Indian']},
            {'name': 'Idli (2 pcs)', 'basePrice': 69.0, 'cat': EngineCategory.main, 'diet': DietaryTag.veg, 'tags': ['South Indian']},
            {'name': 'Medu Vada', 'basePrice': 49.0, 'cat': EngineCategory.side, 'diet': DietaryTag.veg, 'tags': ['South Indian']},
            {'name': 'Mini Meals', 'basePrice': 149.0, 'cat': EngineCategory.main, 'diet': DietaryTag.veg, 'tags': ['South Indian']},
            {'name': 'Filter Coffee', 'basePrice': 49.0, 'cat': EngineCategory.beverage, 'diet': DietaryTag.veg, 'tags': ['Beverage']},
            {'name': 'Pongal', 'basePrice': 99.0, 'cat': EngineCategory.main, 'diet': DietaryTag.veg, 'tags': ['South Indian']},
            {'name': 'Rava Dosa', 'basePrice': 119.0, 'cat': EngineCategory.main, 'diet': DietaryTag.veg, 'tags': ['South Indian']},
            {'name': 'Sweet Kesari', 'basePrice': 59.0, 'cat': EngineCategory.side, 'diet': DietaryTag.veg, 'tags': ['Dessert']},
          ],
        },
        {
          'name': 'Wow! Momo',
          'cuisine': 'Fast Food',
          'items': [
            {'name': 'Paneer Momo', 'basePrice': 199.0, 'cat': EngineCategory.main, 'diet': DietaryTag.veg, 'tags': ['Fast Food']},
            {'name': 'Chicken Momo', 'basePrice': 219.0, 'cat': EngineCategory.main, 'diet': DietaryTag.nonVeg, 'tags': ['Fast Food']},
            {'name': 'Veg Darjeeling Momo', 'basePrice': 149.0, 'cat': EngineCategory.main, 'diet': DietaryTag.veg, 'tags': ['Fast Food']},
            {'name': 'Chicken Darjeeling Momo', 'basePrice': 169.0, 'cat': EngineCategory.main, 'diet': DietaryTag.nonVeg, 'tags': ['Fast Food']},
            {'name': 'Moburg Veg', 'basePrice': 129.0, 'cat': EngineCategory.side, 'diet': DietaryTag.veg, 'tags': ['Fast Food']},
            {'name': 'Moburg Chicken', 'basePrice': 149.0, 'cat': EngineCategory.side, 'diet': DietaryTag.nonVeg, 'tags': ['Fast Food']},
            {'name': 'Diet Coke', 'basePrice': 60.0, 'cat': EngineCategory.beverage, 'diet': DietaryTag.veg, 'tags': ['Beverage']},
            {'name': 'Chocolate Momo', 'basePrice': 119.0, 'cat': EngineCategory.side, 'diet': DietaryTag.veg, 'tags': ['Dessert']},
          ],
        },
        {
          'name': 'Burger King',
          'cuisine': 'Fast Food',
          'items': [
            {'name': 'Whopper Jr. Chicken', 'basePrice': 229.0, 'cat': EngineCategory.main, 'diet': DietaryTag.nonVeg, 'tags': ['Fast Food']},
            {'name': 'Veg Whopper', 'basePrice': 209.0, 'cat': EngineCategory.main, 'diet': DietaryTag.veg, 'tags': ['Fast Food']},
            {'name': 'Crispy Chicken Burger', 'basePrice': 119.0, 'cat': EngineCategory.main, 'diet': DietaryTag.nonVeg, 'tags': ['Fast Food']},
            {'name': 'Crispy Veg Burger', 'basePrice': 99.0, 'cat': EngineCategory.main, 'diet': DietaryTag.veg, 'tags': ['Fast Food']},
            {'name': 'Onion Rings', 'basePrice': 129.0, 'cat': EngineCategory.side, 'diet': DietaryTag.veg, 'tags': ['Fast Food']},
            {'name': 'Peri Peri Fries', 'basePrice': 139.0, 'cat': EngineCategory.side, 'diet': DietaryTag.veg, 'tags': ['Fast Food']},
            {'name': 'Iced Tea', 'basePrice': 89.0, 'cat': EngineCategory.beverage, 'diet': DietaryTag.veg, 'tags': ['Beverage']},
            {'name': 'Chocolate Shake', 'basePrice': 159.0, 'cat': EngineCategory.beverage, 'diet': DietaryTag.veg, 'tags': ['Dessert']},
          ],
        },
        {
          'name': 'Behrouz Biryani',
          'cuisine': 'Biryani',
          'items': [
            {'name': 'Dum Gosht Biryani', 'basePrice': 449.0, 'cat': EngineCategory.main, 'diet': DietaryTag.nonVeg, 'tags': ['Biryani']},
            {'name': 'Murgh Makhani Biryani', 'basePrice': 349.0, 'cat': EngineCategory.main, 'diet': DietaryTag.nonVeg, 'tags': ['Biryani']},
            {'name': 'Subz-e-Falafel Biryani', 'basePrice': 299.0, 'cat': EngineCategory.main, 'diet': DietaryTag.veg, 'tags': ['Biryani']},
            {'name': 'Paneer Subz Biryani', 'basePrice': 329.0, 'cat': EngineCategory.main, 'diet': DietaryTag.veg, 'tags': ['Biryani']},
            {'name': 'Mint Raita', 'basePrice': 49.0, 'cat': EngineCategory.side, 'diet': DietaryTag.veg, 'tags': ['Side']},
            {'name': 'Gulab Jamun', 'basePrice': 79.0, 'cat': EngineCategory.side, 'diet': DietaryTag.veg, 'tags': ['Dessert']},
            {'name': 'Chicken Keema', 'basePrice': 249.0, 'cat': EngineCategory.side, 'diet': DietaryTag.nonVeg, 'tags': ['Side']},
            {'name': 'Buttermilk', 'basePrice': 59.0, 'cat': EngineCategory.beverage, 'diet': DietaryTag.veg, 'tags': ['Beverage']},
          ],
        },
      ];

      final dbStalls = <Stall>[];
      final dbItems = <MenuItem>[];

      for (var mall in malls) {
        for (var st in stallTemplates) {
          final stallIdVal = stallCounter++;
          final stallId = 's$stallIdVal';
          final stallName = st['name'] as String;
          dbStalls.add(Stall()
            ..id = stallIdVal
            ..stallId = stallId
            ..name = stallName
            ..mallId = mall.mallId
            ..cuisineType = st['cuisine'] as String);

          for (var it in st['items'] as List<Map<String, dynamic>>) {
            final itemIdVal = itemCounter++;
            final internalId = 'i$itemIdVal';
            final basePrice = it['basePrice'] as double;
            dbItems.add(MenuItem()
              ..id = itemIdVal
              ..internalId = internalId
              ..name = it['name'] as String
              ..basePrice = basePrice
              ..taxAdjustedPrice = basePrice * 1.05
              ..engineCategory = it['cat'] as EngineCategory
              ..dietaryTag = it['diet'] as DietaryTag
              ..tags = it['tags'] as List<String>
              ..stallId = stallId
              ..stallName = stallName
              ..mallId = mall.mallId
              ..isBlacklisted = false);
          }
        }
        
        final combos = [
          TrendingCombo()
            ..id = comboCounter++
            ..mallId = mall.mallId
            ..label = "${mall.name} Budget Feast"
            ..items = ['Zinger Burger', 'Popcorn Chicken', 'Pepsi']
            ..totalPrice = (249.0+189.0+69.0) * 1.05
            ..acceptedCount = 145
            ..timestamp = DateTime.now().subtract(const Duration(hours: 2)),
          TrendingCombo()
            ..id = comboCounter++
            ..mallId = mall.mallId
            ..label = "South Indian Delight"
            ..items = ['Ghee Roast Dosa', 'Medu Vada', 'Filter Coffee']
            ..totalPrice = (129.0+49.0+49.0) * 1.05
            ..acceptedCount = 98
            ..timestamp = DateTime.now().subtract(const Duration(hours: 5)),
          TrendingCombo()
            ..id = comboCounter++
            ..mallId = mall.mallId
            ..label = "Biryani Party"
            ..items = ['Murgh Makhani Biryani', 'Mint Raita', 'Gulab Jamun']
            ..totalPrice = (349.0+49.0+79.0) * 1.05
            ..acceptedCount = 230
            ..timestamp = DateTime.now().subtract(const Duration(hours: 1)),
        ];
        await isar.trendingCombos.putAll(combos);
      }

      await isar.stalls.putAll(dbStalls);
      await isar.menuItems.putAll(dbItems);
    });
  } finally {
    _isSeeding = false;
  }
}
