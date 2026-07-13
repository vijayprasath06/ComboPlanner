import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/meal_plan.dart';
import '../../providers/planner_provider.dart';
import '../../theme/app_theme.dart';
import 'item_tile.dart';

class StrategyCard extends StatelessWidget {
  final MealPlan plan;
  const StrategyCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PlannerProvider>();
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Cost:', style: Theme.of(context).textTheme.titleLarge),
                Text('?${plan.totalCost.toStringAsFixed(0)}', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppTheme.primary)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Stalls to visit: ${plan.stallsUsed.join(', ')}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: plan.assignments.length,
                itemBuilder: (context, i) {
                  final personIndex = plan.assignments.keys.elementAt(i);
                  final items = plan.assignments[personIndex]!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text('Person ${personIndex + 1}', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      ...items.map((item) => ItemTile(
                        item: item,
                        onHotSwap: () => provider.hotSwapItem(item.internalId),
                      )),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
