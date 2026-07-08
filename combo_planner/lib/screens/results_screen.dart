import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/planner_provider.dart';
import '../../domain/models/meal_plan.dart';
import '../../theme/app_theme.dart';
import 'plan_detail_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlannerProvider>();

    if (provider.isGenerating) {
      return Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: AppTheme.accent, strokeWidth: 3),
              const SizedBox(height: 20),
              Text(
                'Crunching numbers...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                'Finding the best combos within your budget',
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    // ── Budget-too-tight error state ────────────────────────────────────
    if (provider.budgetTooTight) {
      final minReq = provider.minimumBudgetRequired;
      final people = provider.vegCount + provider.nonVegCount;
      return Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(title: const Text('No Plans Found')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Column(
                  children: [
                    const Icon(Icons.warning_amber_rounded, size: 56, color: AppTheme.error),
                    const SizedBox(height: 16),
                    Text(
                      'Budget Too Tight',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'With ₹${provider.budget.toStringAsFixed(0)} for $people people, '
                      'that’s ₹${(provider.budget / people).toStringAsFixed(0)}/person — '
                      'below the minimum needed to order a main dish.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppTheme.textSecondary, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.accent.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.lightbulb_outline, color: AppTheme.accent, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Increase budget to at least ₹${minReq.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: AppTheme.accentDark,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Go Back & Adjust'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final balanced = provider.mealPlans.where((e) => e.strategy == StrategyType.balanced).firstOrNull;
    final heavy = provider.mealPlans.where((e) => e.strategy == StrategyType.heavyweight).firstOrNull;
    final express = provider.mealPlans.where((e) => e.strategy == StrategyType.express).firstOrNull;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          title: const Text('Your Combos'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: Container(
              color: AppTheme.primary,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
              child: const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: AppTheme.accent,
                tabs: [
                  Tab(text: 'Balanced'),
                  Tab(text: 'Heavyweight'),
                  Tab(text: 'Express'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _PlanTab(plan: balanced, strategyLabel: 'Balanced Meal', strategyDesc: 'Everyone gets a Main + Side + Beverage.'),
            _PlanTab(plan: heavy, strategyLabel: 'Heavyweight', strategyDesc: 'Premium items — maximizes your budget.'),
            _PlanTab(plan: express, strategyLabel: 'Single-Stall Express', strategyDesc: 'All food from one counter — fastest checkout.'),
          ],
        ),
      ),
    );
  }
}

class _PlanTab extends StatelessWidget {
  final MealPlan? plan;
  final String strategyLabel;
  final String strategyDesc;

  const _PlanTab({this.plan, required this.strategyLabel, required this.strategyDesc});

  @override
  Widget build(BuildContext context) {
    if (plan == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_off_rounded, size: 64, color: AppTheme.textSecondary),
              const SizedBox(height: 16),
              Text(
                'No plan found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'Could not find a valid combo within your budget. Try increasing the budget or vendor limit.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    final totalPeople = plan!.assignments.length;
    final stallCount = plan!.stallsUsed.length;

    return Column(
      children: [
        // Strategy header banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          decoration: BoxDecoration(
            gradient: AppTheme.cardGradient,
            border: const Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(strategyLabel, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(strategyDesc, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${plan!.totalCost.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                  Text(
                    'incl. GST',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Stall pills row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.white,
          child: Row(
            children: [
              const Icon(Icons.store_mall_directory_rounded, size: 14, color: AppTheme.textSecondary),
              const SizedBox(width: 6),
              Text(
                '$stallCount stall${stallCount == 1 ? '' : 's'}: ',
                style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
              ),
              Expanded(
                child: Text(
                  plan!.stallsUsed.join(' → '),
                  style: const TextStyle(
                    color: AppTheme.primaryDark,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        // Per-person cards list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: plan!.assignments.length,
            itemBuilder: (context, i) {
              final personIndex = plan!.assignments.keys.elementAt(i);
              final items = plan!.assignments[personIndex]!;
              final isVeg = items.every((item) => item.dietaryTag.name == 'veg');
              final personTotal = items.fold(0.0, (sum, item) => sum + item.taxAdjustedPrice);

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: totalPeople <= 3,
                    leading: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: isVeg ? AppTheme.vegGreen.withValues(alpha: 0.12) : AppTheme.nonVegRed.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          isVeg ? '🟢' : '🔴',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    title: Text(
                      'Person ${personIndex + 1}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: AppTheme.textDark),
                    ),
                    subtitle: Text(
                      '${items.length} items · ₹${personTotal.toStringAsFixed(0)}',
                      style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '₹${personTotal.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const Icon(Icons.expand_more, size: 18, color: AppTheme.textSecondary),
                      ],
                    ),
                    children: items.map((item) {
                      return ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        leading: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: item.dietaryTag.name == 'veg'
                                ? AppTheme.vegGreen.withValues(alpha: 0.1)
                                : AppTheme.nonVegRed.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Icon(
                              _categoryIcon(item.engineCategory.name),
                              size: 16,
                              color: item.dietaryTag.name == 'veg' ? AppTheme.vegGreen : AppTheme.nonVegRed,
                            ),
                          ),
                        ),
                        title: Text(item.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        subtitle: Text(item.stallName, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                        trailing: Text(
                          '₹${item.taxAdjustedPrice.toStringAsFixed(0)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ).animate(delay: (i * 100).ms).fade(duration: 400.ms).slideX(begin: 0.1, curve: Curves.easeOutQuad);
            },
          ),
        ),

        // Bottom action bar
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.read<PlannerProvider>().generatePlans();
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Regenerate'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.primary),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () {
                    HapticFeedback.heavyImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlanDetailScreen(plan: plan!, strategyLabel: strategyLabel),
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle_rounded),
                  label: const Text('Select This Plan'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'main': return Icons.restaurant_rounded;
      case 'side': return Icons.fastfood_rounded;
      case 'beverage': return Icons.local_drink_rounded;
      default: return Icons.restaurant_menu_rounded;
    }
  }
}
