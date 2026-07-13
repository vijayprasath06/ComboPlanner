import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/models/meal_plan.dart';
import '../../domain/models/menu_item.dart';
import '../../providers/planner_provider.dart';
import '../../data/repositories/menu_repository.dart';
import '../../services/plan_share_service.dart';
import '../../theme/app_theme.dart';

class PlanDetailScreen extends StatefulWidget {
  final MealPlan plan;
  final String strategyLabel;

  const PlanDetailScreen({super.key, required this.plan, required this.strategyLabel});

  @override
  State<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends State<PlanDetailScreen> {
  late MealPlan _plan;

  @override
  void initState() {
    super.initState();
    _plan = widget.plan;
    // Attach listener AFTER first frame so context.read is safe
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlannerProvider>().addListener(_onProviderChange);
    });
  }

  @override
  void dispose() {
    // Safe removal — provider may already be gone if widget is disposed
    // during generation. Use try/catch to prevent dispose-time crashes.
    try {
      context.read<PlannerProvider>().removeListener(_onProviderChange);
    } catch (_) {}
    super.dispose();
  }

  /// Listens to PlannerProvider changes and updates the local plan snapshot.
  /// This replaces the buggy `context.watch` inside `didChangeDependencies`.
  void _onProviderChange() {
    if (!mounted) return;
    final provider = context.read<PlannerProvider>();

    // Show swap-failure message if the provider set one
    if (provider.swapFailureMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.swapFailureMessage!),
          backgroundColor: AppTheme.primaryLight,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    // Update local plan only when generation is complete and plans exist
    if (!provider.isGenerating && provider.mealPlans.isNotEmpty) {
      final updated = provider.mealPlans
          .where((p) => p.strategy == _plan.strategy)
          .firstOrNull;
      // Only update if we got a valid replacement — never null out the plan
      if (updated != null) {
        setState(() => _plan = updated);
      }
    }
  }

  Future<void> _hotSwap(BuildContext ctx, MenuItem item) async {
    HapticFeedback.heavyImpact();
    
    // Get alternatives from the same stall
    final repo = ctx.read<MenuRepository>();
    final alternatives = await repo.getAlternativesFromStall(
      item.stallId, 
      item.engineCategory.name, 
      item.dietaryTag.name
    );
    
    final otherOptions = alternatives.where((a) => a.internalId != item.internalId).toList();
    
    if (otherOptions.isEmpty) {
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('No alternatives available from this stall in this category.')),
        );
      }
      return;
    }

    if (!ctx.mounted) return;
    
    // Show bottom sheet
    final selectedNewItem = await showModalBottomSheet<MenuItem>(
      context: ctx,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Swap ${item.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: otherOptions.length,
                  itemBuilder: (context, index) {
                    final alt = otherOptions[index];
                    return ListTile(
                      title: Text(alt.name),
                      trailing: Text('₹${alt.taxAdjustedPrice.toStringAsFixed(0)}'),
                      onTap: () => Navigator.pop(context, alt),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (selectedNewItem != null && ctx.mounted) {
      // Update plan locally
      setState(() {
        for (var person in _plan.assignments.keys) {
          final items = _plan.assignments[person]!;
          final idx = items.indexWhere((i) => i.internalId == item.internalId);
          if (idx != -1) {
            items[idx] = selectedNewItem;
            break;
          }
        }
        // Recalculate cost
        double total = 0;
        for (var items in _plan.assignments.values) {
          total += items.fold(0.0, (sum, i) => sum + i.taxAdjustedPrice);
        }
        _plan.totalCost = total;
      });
      ctx.read<PlannerProvider>().refreshState();
    }
  }

  Map<String, List<MenuItem>> _groupByStall() {
    final Map<String, List<MenuItem>> stallMap = {};
    for (final items in _plan.assignments.values) {
      for (final item in items) {
        stallMap.putIfAbsent(item.stallName, () => []).add(item);
      }
    }
    return stallMap;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlannerProvider>();
    final stallGroups = _groupByStall();
    final isSwapping = provider.isHotSwapping || provider.isGenerating;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppTheme.background,
          body: CustomScrollView(
        slivers: [
          // Hero header
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: AppTheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(gradient: AppTheme.heroGradient),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.strategyLabel,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Your Plan', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                                Text(
                                  '${_plan.assignments.length} people · ${_plan.stallsUsed.length} stall${_plan.stallsUsed.length == 1 ? '' : 's'}',
                                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 13),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₹${_plan.totalCost.toStringAsFixed(0)}',
                                  style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'incl. 5% GST',
                                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              title: const Text('Plan Detail', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              collapseMode: CollapseMode.pin,
            ),
          ),

          // Stall route indicator
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.route_rounded, color: AppTheme.primary, size: 16),
                      SizedBox(width: 6),
                      Text('Collection Route', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryDark, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      for (int i = 0; i < _plan.stallsUsed.length; i++) ...[
                        _StallPill(name: _plan.stallsUsed[i], index: i + 1),
                        if (i < _plan.stallsUsed.length - 1)
                          const Icon(Icons.arrow_forward_rounded, size: 14, color: AppTheme.textSecondary),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Swipe hint
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.swipe_left_rounded, size: 14, color: AppTheme.textSecondary),
                  SizedBox(width: 4),
                  Text(
                    'Swipe any item left to hot-swap it',
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 10)),

          // Per-stall grouped items
          if (provider.isGenerating)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: Column(
                  children: [
                    CircularProgressIndicator(color: AppTheme.primary),
                    SizedBox(height: 12),
                    Text('Hot-swapping...', style: TextStyle(color: AppTheme.textSecondary)),
                  ],
                )),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final stallName = stallGroups.keys.elementAt(i);
                  final items = stallGroups[stallName]!;
                  final stallTotal = items.fold(0.0, (sum, item) => sum + item.taxAdjustedPrice);

                  return Container(
                    margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stall header
                        Container(
                          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFF8F0),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: AppTheme.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(stallName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    Text('${items.length} items to collect', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                                  ],
                                ),
                              ),
                              Text(
                                '₹${stallTotal.toStringAsFixed(0)}',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary, fontSize: 15),
                              ),
                            ],
                          ),
                        ),

                        // Items in this stall
                        ...items.asMap().entries.map((entry) {
                          final item = entry.value;
                          final isLast = entry.key == items.length - 1;
                            return _SwipeableItemTile(
                              item: item,
                              showDivider: !isLast,
                              onHotSwap: () => _hotSwap(context, item),
                            );
                        }),
                      ],
                    ),
                  );
                },
                childCount: stallGroups.length,
              ),
            ),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),

      // Floating bottom done button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, -4))],
        ),
        child: Row(
          children: [
            // Share button
            IconButton(
              onPressed: () {
                final provider = context.read<PlannerProvider>();
                final allItems = _plan.assignments.values.expand((e) => e).toList();
                final shareText = provider.buildShareTextPublic(_plan, allItems);
                PlanShareService.share(shareText);
              },
              icon: const Icon(Icons.share_rounded, color: AppTheme.primary),
              tooltip: 'Share Plan',
              style: IconButton.styleFrom(
                backgroundColor: AppTheme.primary.withValues(alpha: 0.08),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(width: 8),
            // Bill Splitter & Pay button
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  final total = _plan.totalCost;
                  final perPerson = total / _plan.assignments.length;
                  final uri = Uri.parse('upi://pay?pa=receiver@upi&pn=Foodie&am=${total.toStringAsFixed(2)}&cu=INR');
                  
                  final shareText = "🍔 Combo Planner Bill Split 🍔\nTotal: ₹${total.toStringAsFixed(0)}\nEach person owes: ₹${perPerson.toStringAsFixed(0)}\nPay here: $uri";
                  PlanShareService.share(shareText);
                  
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                },
                icon: const Icon(Icons.currency_rupee_rounded, size: 18),
                label: const Text('Split Bill', style: TextStyle(fontSize: 13)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.teal,
                  side: const BorderSide(color: Colors.teal),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: provider.isSavingHistory
                    ? null
                    : () async {
                        HapticFeedback.heavyImpact();
                        await context.read<PlannerProvider>().acceptPlan(_plan);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('🎉 Plan saved to history! Enjoy your meal!'),
                              backgroundColor: AppTheme.vegGreen,
                              duration: Duration(seconds: 3),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                icon: provider.isSavingHistory
                    ? const SizedBox(
                        width: 16, height: 16,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.check_circle_outline_rounded),
                label: Text(provider.isSavingHistory ? 'Saving...' : "Let's Eat! 🍛"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.vegGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    ), // closes Scaffold

    // ── Hot-swap loading overlay ────────────────────────────────────────────
    if (isSwapping)
      Container(
        color: Colors.black.withValues(alpha: 0.45),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: AppTheme.accent, strokeWidth: 3),
                SizedBox(height: 14),
                Text('Finding alternatives…',
                    style: TextStyle(
                      color: AppTheme.textOnDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    )),
              ],
            ),
          ),
        ),
      ),
  ],
); // closes Stack
  }
}

class _StallPill extends StatelessWidget {
  final String name;
  final int index;
  const _StallPill({required this.name, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
            child: Center(child: Text('$index', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(width: 5),
          Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primaryDark)),
        ],
      ),
    );
  }
}

class _SwipeableItemTile extends StatelessWidget {
  final MenuItem item;
  final bool showDivider;
  final VoidCallback onHotSwap;

  const _SwipeableItemTile({
    required this.item,
    required this.showDivider,
    required this.onHotSwap,
  });

  String _categoryEmoji(String category) {
    switch (category.toLowerCase()) {
      case 'main': return '🍽️';
      case 'side': return '🍟';
      case 'beverage': return '🥤';
      default: return '🍴';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.internalId),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Hot Swap?'),
            content: Text('Replace "${item.name}" with a different item?'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Swap It'),
              ),
            ],
          ),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: const BoxDecoration(color: Color(0xFFD32F2F)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.swap_horiz_rounded, color: Colors.white, size: 24),
            SizedBox(height: 4),
            Text('Swap', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      onDismissed: (_) => onHotSwap(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Text(_categoryEmoji(item.engineCategory.name), style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: item.dietaryTag.name == 'veg'
                                  ? AppTheme.vegGreen.withValues(alpha: 0.1)
                                  : AppTheme.nonVegRed.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: item.dietaryTag.name == 'veg' ? AppTheme.vegGreen : AppTheme.nonVegRed,
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              item.dietaryTag.name == 'veg' ? '🟢 Veg' : '🔴 Non-Veg',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: item.dietaryTag.name == 'veg' ? AppTheme.vegGreen : AppTheme.nonVegRed,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(item.stallName, style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${item.taxAdjustedPrice.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (showDivider)
            Divider(height: 1, indent: 14, endIndent: 14, color: Colors.grey.shade100),
        ],
      ),
    );
  }
}

