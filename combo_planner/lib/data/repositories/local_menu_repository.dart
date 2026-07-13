import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../domain/models/mall.dart';
import '../../domain/models/stall.dart';
import '../../domain/models/menu_item.dart';
import '../../domain/models/trending_combo.dart';
import '../../domain/enums/engine_category.dart';
import '../../domain/enums/dietary_tag.dart';
import 'menu_repository.dart';
import '../../services/supabase_service.dart';

class LocalMenuRepository implements MenuRepository {
  final Isar isar;
  final SupabaseService _supabaseService = SupabaseService();

  LocalMenuRepository(this.isar);

  Future<void> seedFromJson() async {
    if (await isar.malls.count() > 0) return;

    final String jsonString = await rootBundle.loadString('assets/real_menu_data.json');
    final Map<String, dynamic> data = json.decode(jsonString);

    await isar.writeTxn(() async {
      await isar.malls.clear();
      await isar.stalls.clear();
      await isar.menuItems.clear();
      await isar.trendingCombos.clear();

      // 1. Malls
      final mallsJson = data['malls'] as List? ?? [];
      final dbMalls = mallsJson.map((m) => Mall()
        ..mallId = m['mallId']
        ..name = m['name']
        ..location = m['location'] ?? ''
        ..lat = (m['lat'] ?? 0.0).toDouble()
        ..lng = (m['lng'] ?? 0.0).toDouble()
      ).toList();
      await isar.malls.putAll(dbMalls);

      // 2. Stalls
      final stallsJson = data['stalls'] as List? ?? [];
      final dbStalls = stallsJson.map((s) => Stall()
        ..stallId = s['stallId']
        ..name = s['name']
        ..mallId = s['mallId']
        ..cuisineType = s['category'] ?? ''
        ..isPureVeg = s['isPureVeg'] ?? false
        ..packagingCharge = (s['packagingCharge'] ?? 0.0).toDouble()
      ).toList();
      await isar.stalls.putAll(dbStalls);

      // 3. Menu Items
      final itemsJson = data['items'] as List? ?? [];
      final dbItems = itemsJson.map((it) => MenuItem()
        ..internalId = it['internalId']
        ..name = it['name']
        ..basePrice = (it['basePrice'] ?? 0.0).toDouble()
        ..taxAdjustedPrice = (it['taxAdjustedPrice'] ?? 0.0).toDouble()
        ..engineCategory = EngineCategory.values.firstWhere(
            (e) => e.name == it['engineCategory'],
            orElse: () => EngineCategory.main)
        ..dietaryTag = DietaryTag.values.firstWhere(
            (e) => e.name == it['dietaryTag'],
            orElse: () => DietaryTag.veg)
        ..tags = (it['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? []
        ..stallId = it['stallId']
        ..stallName = stallsJson.firstWhere((s) => s['stallId'] == it['stallId'], orElse: () => {'name': 'Unknown'})['name']
        ..mallId = it['mallId']
        ..isBlacklisted = false
        ..isVendorCombo = it['isVendorCombo'] ?? false
        ..estimatedPrepTimeMins = it['estimatedPrepTimeMins'] ?? 10
      ).toList();
      await isar.menuItems.putAll(dbItems);
      
      // Trending combos are not in this json schema yet, but can be added later.
    });
  }

  @override
  Future<List<MenuItem>> getItemsForMall(String mallId) async {
    // Optionally trigger a background price sync
    _supabaseService.syncConsensusPricesToLocal(isar);
    return await isar.menuItems.filter().mallIdEqualTo(mallId).findAll();
  }

  @override
  Future<void> reportPriceMismatch(String internalId, double newPrice) async {
    final item = await isar.menuItems.filter().internalIdEqualTo(internalId).findFirst();
    if (item != null) {
      try {
        await _supabaseService.reportPriceMismatch(internalId, item.mallId, newPrice);
        Fluttertoast.showToast(msg: "Price report submitted to cloud!");
      } catch (e) {
        Fluttertoast.showToast(msg: "Failed to report price: ${e.toString()}");
      }
    }
  }

  @override
  Future<List<TrendingCombo>> getTrendingCombos(String mallId) async {
    final cloudCombos = await _supabaseService.fetchTrendingCombos(mallId);
    if (cloudCombos.isNotEmpty) {
      return cloudCombos;
    }
    // Fallback to local
    return await isar.trendingCombos.filter().mallIdEqualTo(mallId).findAll();
  }

  @override
  Future<List<MenuItem>> getAlternativesFromStall(String stallId, String engineCategory, String dietaryTag) async {
    final ec = EngineCategory.values.firstWhere((e) => e.name == engineCategory);
    final dt = DietaryTag.values.firstWhere((e) => e.name == dietaryTag);
    return await isar.menuItems
        .filter()
        .stallIdEqualTo(stallId)
        .engineCategoryEqualTo(ec)
        .dietaryTagEqualTo(dt)
        .findAll();
  }
}
