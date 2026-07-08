import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/plan_history.dart';
import '../../providers/planner_provider.dart';
import '../../services/plan_share_service.dart';
import '../../theme/app_theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlannerProvider>().loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final history = context.watch<PlannerProvider>().planHistory;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Plan History'),
        actions: [
          if (history.isNotEmpty)
            TextButton(
              onPressed: () => _confirmClear(context),
              child: const Text('Clear All', style: TextStyle(color: Colors.white70, fontSize: 13)),
            ),
        ],
      ),
      body: history.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('📋', style: TextStyle(fontSize: 56)),
                  const SizedBox(height: 16),
                  Text('No history yet', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  const Text(
                    'Accept a plan with "Let\'s Eat!" to save it here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Info bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, size: 14, color: AppTheme.textSecondary),
                      const SizedBox(width: 6),
                      Text(
                        '${history.length}/20 plans saved · auto-clears after 30 days',
                        style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: history.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, i) => _HistoryCard(entry: history[i]),
                  ),
                ),
              ],
            ),
    );
  }

  void _confirmClear(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Clear History?'),
        content: const Text('This will delete all saved plans. This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Clear all history via provider
              ctx.read<PlannerProvider>().clearHistory();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final PlanHistory entry;
  const _HistoryCard({required this.entry});

  String _strategyEmoji(String name) {
    if (name.contains('Balanced')) return '⚖️';
    if (name.contains('Heavyweight')) return '💪';
    if (name.contains('Express')) return '⚡';
    return '🍽️';
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays} days ago';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(_strategyEmoji(entry.strategyName), style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.strategyName,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(entry.mallName,
                          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${entry.totalCost.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      _formatDate(entry.savedAt),
                      style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Route
            Row(
              children: [
                const Icon(Icons.route_rounded, size: 12, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    entry.stallsUsed.join(' → '),
                    style: const TextStyle(fontSize: 11, color: AppTheme.primaryDark, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Item names
            Text(
              entry.itemNames.take(5).join(', ') + (entry.itemNames.length > 5 ? '...' : ''),
              style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            // People count
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${entry.peopleCount} people',
                    style: const TextStyle(fontSize: 11, color: AppTheme.primaryDark, fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                // Share button
                GestureDetector(
                  onTap: () => _share(entry.shareText),
                  child: const Row(
                    children: [
                      Icon(Icons.share_rounded, size: 14, color: AppTheme.primary),
                      SizedBox(width: 4),
                      Text('Share', style: TextStyle(fontSize: 12, color: AppTheme.primary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _share(String text) {
    PlanShareService.share(text);
  }

}
