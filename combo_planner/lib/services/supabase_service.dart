import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/models/plan_history.dart';
import '../domain/models/trending_combo.dart';
import '../domain/models/menu_item.dart';
import 'package:isar/isar.dart';

class SupabaseService {
  final _supabase = Supabase.instance.client;

  // ── Trending Combos ────────────────────────────────────────────────────────
  Future<List<TrendingCombo>> fetchTrendingCombos(String mallId) async {
    try {
      final response = await _supabase
          .from('trending_combos')
          .select()
          .eq('mall_id', mallId)
          .order('accepted_count', ascending: false)
          .limit(5);

      return (response as List).map((row) {
        return TrendingCombo()
          ..mallId = row['mall_id']
          ..label = row['label']
          ..totalPrice = (row['total_price'] as num).toDouble()
          ..items = List<String>.from(row['item_names'] ?? [])
          ..timestamp = DateTime.now()
          ..acceptedCount = row['accepted_count'] ?? 1;
      }).toList();
    } catch (e) {
      // Fallback to local or empty if network fails
      return [];
    }
  }

  Future<void> logComboAcceptance(TrendingCombo combo) async {
    if (_supabase.auth.currentUser == null) return;
    try {
      // Upsert: If exists, we can't easily increment via REST upsert without a function, 
      // but we can just use a simple Edge Function or raw SQL RPC later.
      // For now, let's call an RPC if we had one. But since we don't, we just insert history.
    } catch (e) {
      // Ignore
    }
  }

  // ── Plan History ───────────────────────────────────────────────────────────
  Future<void> savePlanHistory(PlanHistory history) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return; // Only save to cloud if logged in

    try {
      await _supabase.from('plan_history').insert({
        'user_id': user.id,
        'mall_id': history.mallId,
        'mall_name': history.mallName,
        'strategy_name': history.strategyName,
        'total_cost': history.totalCost,
        'people_count': history.peopleCount,
        'stalls_used': history.stallsUsed,
        'item_names': history.itemNames,
        'share_text': history.shareText,
      });
    } catch (e) {
      // Queue in Isar for later if it fails? (Local sync queue can be handled later)
    }
  }

  Future<List<PlanHistory>> fetchUserHistory() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    try {
      final response = await _supabase
          .from('plan_history')
          .select()
          .eq('user_id', user.id)
          .order('saved_at', ascending: false);

      return (response as List).map((row) {
        return PlanHistory()
          ..mallId = row['mall_id']
          ..mallName = row['mall_name']
          ..strategyName = row['strategy_name']
          ..totalCost = (row['total_cost'] as num).toDouble()
          ..peopleCount = row['people_count']
          ..stallsUsed = List<String>.from(row['stalls_used'])
          ..itemNames = List<String>.from(row['item_names'])
          ..shareText = row['share_text']
          ..savedAt = DateTime.parse(row['saved_at']);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  // ── Migration ────────────────────────────────────────────────────────────
  Future<void> migrateLocalHistoryToCloud(Isar isar) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    try {
      // Get all local history
      final localHistory = await isar.planHistorys.where().findAll();
      if (localHistory.isEmpty) return;

      // Check what we already have in cloud
      final cloudHistory = await fetchUserHistory();
      final cloudKeys = cloudHistory.map((h) => '\${h.mallId}_\${h.savedAt.millisecondsSinceEpoch}').toSet();

      final toUpload = localHistory.where((h) {
        final key = '\${h.mallId}_\${h.savedAt.millisecondsSinceEpoch}';
        return !cloudKeys.contains(key);
      }).toList();

      for (var history in toUpload) {
        await savePlanHistory(history);
      }
    } catch (e) {
      // Ignore migration errors
    }
  }

  // ── Price Consensus ────────────────────────────────────────────────────────
  Future<void> reportPriceMismatch(String itemInternalId, String mallId, double newPrice) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Must be logged in to report prices');

    await _supabase.from('price_reports').upsert({
      'item_internal_id': itemInternalId,
      'mall_id': mallId,
      'reported_price': newPrice,
      'user_id': user.id,
    });
  }

  Future<void> syncConsensusPricesToLocal(Isar isar) async {
    try {
      // Read from the price_consensus view
      final response = await _supabase.from('price_consensus').select();
      
      await isar.writeTxn(() async {
        for (var row in response) {
          final itemId = row['item_internal_id'];
          final mallId = row['mall_id'];
          final newPrice = (row['consensus_price'] as num).toDouble();
          
          final item = await isar.menuItems
              .filter()
              .internalIdEqualTo(itemId)
              .and()
              .mallIdEqualTo(mallId)
              .findFirst();
              
          if (item != null && item.basePrice != newPrice) {
            item.basePrice = newPrice;
            item.taxAdjustedPrice = newPrice * 1.05;
            await isar.menuItems.put(item);
          }
        }
      });
    } catch (e) {
      // Silently fail sync
    }
  }
}
