import '../../domain/models/menu_item.dart';
import '../../domain/models/trending_combo.dart';

abstract class MenuRepository {
  Future<List<MenuItem>> getItemsForMall(String mallId);
  Future<void> reportPriceMismatch(String internalId, double newPrice);
  Future<List<TrendingCombo>> getTrendingCombos(String mallId);
}
