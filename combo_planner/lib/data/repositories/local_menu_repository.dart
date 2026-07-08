import 'package:isar/isar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../domain/models/menu_item.dart';
import '../../domain/models/trending_combo.dart';
import 'menu_repository.dart';

import '../../services/supabase_service.dart';

class LocalMenuRepository implements MenuRepository {
  final Isar isar;
  final SupabaseService _supabaseService = SupabaseService();

  LocalMenuRepository(this.isar);

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
        Fluttertoast.showToast(msg: "Failed to report price: \${e.toString()}");
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
}
