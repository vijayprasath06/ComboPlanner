import 'package:flutter/material.dart';
import '../../domain/models/menu_item.dart';
import '../../theme/app_theme.dart';

class ItemTile extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onHotSwap;

  const ItemTile({
    super.key,
    required this.item,
    required this.onHotSwap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.internalId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: AppTheme.dismissRed,
        child: const Icon(Icons.swap_horiz, color: Colors.white),
      ),
      onDismissed: (_) => onHotSwap(),
      child: ListTile(
        title: Text(item.name, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text(item.stallName, style: Theme.of(context).textTheme.bodySmall),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('?${item.taxAdjustedPrice.toStringAsFixed(0)}', style: Theme.of(context).textTheme.bodyLarge),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(color: AppTheme.gstBadge.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                  child: const Text('incl. GST', style: TextStyle(fontSize: 8, color: Colors.amber)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

