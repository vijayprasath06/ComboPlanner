import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/planner_provider.dart';
import '../../providers/user_provider.dart';
import '../../theme/app_theme.dart';
import 'results_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlannerProvider>();
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Group Matrix'),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Budget Section
                  _SectionCard(
                    icon: Icons.account_balance_wallet_rounded,
                    title: 'Total Budget',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('₹', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                provider.budget.toStringAsFixed(0),
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: AppTheme.primary,
                            inactiveTrackColor: AppTheme.primary.withValues(alpha: 0.2),
                            thumbColor: AppTheme.primary,
                            overlayColor: AppTheme.primary.withValues(alpha: 0.15),
                            trackHeight: 4,
                          ),
                          child: Slider(
                            value: provider.budget.clamp(200, 10000),
                            min: 200,
                            max: 10000,
                            divisions: 98,
                            onChanged: (v) {
                              HapticFeedback.selectionClick();
                              provider.updateBudget(v);
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('₹200', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                            Text('₹10,000', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Per-person budget indicator
                        Builder(builder: (context) {
                          final total = provider.vegCount + provider.nonVegCount;
                          if (total == 0) return const SizedBox.shrink();
                          final perPerson = provider.budget / total;
                          final isTooLow = perPerson < 150;
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isTooLow ? Colors.red.shade50 : Colors.green.shade50,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isTooLow ? Colors.red.shade200 : Colors.green.shade200,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(isTooLow ? '⚠️' : '✅', style: const TextStyle(fontSize: 14)),
                                const SizedBox(width: 8),
                                Text(
                                  isTooLow
                                      ? '≈₹${perPerson.toStringAsFixed(0)}/person — budget may be too tight'
                                      : '≈₹${perPerson.toStringAsFixed(0)}/person — looks good!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isTooLow ? Colors.red.shade700 : Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),


                  const SizedBox(height: 16),

                  // Group Demographics Section
                  _SectionCard(
                    icon: Icons.people_alt_rounded,
                    title: 'Group Demographics',
                    child: Column(
                      children: [
                        _DietCounter(
                          label: 'Vegetarian',
                          emoji: '🟢',
                          count: provider.vegCount,
                          color: AppTheme.vegGreen,
                          onIncrement: () {
                            HapticFeedback.selectionClick();
                            provider.updateVegCount(provider.vegCount + 1);
                          },
                          onDecrement: () {
                            HapticFeedback.selectionClick();
                            provider.updateVegCount(provider.vegCount - 1);
                          },
                        ),
                        const Divider(height: 24),
                        _DietCounter(
                          label: 'Non-Vegetarian',
                          emoji: '🔴',
                          count: provider.nonVegCount,
                          color: AppTheme.nonVegRed,
                          onIncrement: () {
                            HapticFeedback.selectionClick();
                            provider.updateNonVegCount(provider.nonVegCount + 1);
                          },
                          onDecrement: () {
                            HapticFeedback.selectionClick();
                            provider.updateNonVegCount(provider.nonVegCount - 1);
                          },
                        ),
                        if (provider.vegCount + provider.nonVegCount == 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.warning_amber_rounded, size: 16, color: Colors.red),
                                  SizedBox(width: 6),
                                  Text('Add at least 1 person', style: TextStyle(color: Colors.red, fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Vendor Limit Section
                  _SectionCard(
                    icon: Icons.storefront_rounded,
                    title: 'Max Stalls to Visit',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (i) {
                            final val = i + 1;
                            final isSelected = provider.vendorLimit == val;
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: i < 2 ? 8 : 0),
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    provider.updateVendorLimit(val);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    decoration: BoxDecoration(
                                      color: isSelected ? AppTheme.primary : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected ? AppTheme.primary : Colors.grey.shade300,
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          val == 1 ? '1️⃣' : val == 2 ? '2️⃣' : '3️⃣',
                                          style: const TextStyle(fontSize: 22),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          val == 1 ? 'Express' : val == 2 ? 'Balanced' : 'Explorer',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? Colors.white : AppTheme.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          provider.vendorLimit == 1
                              ? 'All food from a single stall — fastest checkout.'
                              : provider.vendorLimit == 2
                                  ? 'Visit up to 2 stalls — good variety.'
                                  : 'Visit up to 3 stalls — maximum options.',
                          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Summary Card
                  if (provider.vegCount + provider.nonVegCount > 0)
                    _SummaryCard(
                      budget: provider.budget,
                      vegCount: provider.vegCount,
                      nonVegCount: provider.nonVegCount,
                      vendorLimit: provider.vendorLimit,
                      mallName: provider.selectedMall?.name ?? 'Unknown',
                    ),
                ].animate(interval: 100.ms).fade(duration: 400.ms).slideY(begin: 0.1, curve: Curves.easeOutQuad),
              ),
            ),
          ),

          // Sticky bottom button
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
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (provider.vegCount + provider.nonVegCount > 0 && !provider.isGenerating)
                    ? () async {
                        HapticFeedback.heavyImpact();
                        
                        // Sync preferences from user to planner
                        final userProvider = context.read<UserProvider>();
                        provider.userLikedTags = userProvider.likedTags;
                        provider.userDislikedTags = userProvider.dislikedTags;
                        
                        await provider.generatePlans();
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ResultsScreen()),
                          );
                        }
                      }
                    : null,
                icon: provider.isGenerating
                    ? const SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.auto_awesome_rounded),
                label: Text(provider.isGenerating ? 'Generating...' : 'Generate Combos'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _SectionCard({required this.icon, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: AppTheme.primary),
              const SizedBox(width: 8),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _DietCounter extends StatelessWidget {
  final String label;
  final String emoji;
  final int count;
  final Color color;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _DietCounter({
    required this.label,
    required this.emoji,
    required this.count,
    required this.color,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        ),
        Row(
          children: [
            _CounterButton(
              icon: Icons.remove,
              onPressed: count > 0 ? onDecrement : null,
              color: color,
            ),
            Container(
              width: 44,
              alignment: Alignment.center,
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: count > 0 ? color : AppTheme.textSecondary,
                ),
              ),
            ),
            _CounterButton(icon: Icons.add, onPressed: onIncrement, color: color),
          ],
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color color;

  const _CounterButton({required this.icon, this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: onPressed != null ? color.withValues(alpha: 0.1) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: onPressed != null ? color.withValues(alpha: 0.3) : Colors.grey.shade200),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 18, color: onPressed != null ? color : Colors.grey),
        onPressed: onPressed,
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final double budget;
  final int vegCount;
  final int nonVegCount;
  final int vendorLimit;
  final String mallName;

  const _SummaryCard({
    required this.budget,
    required this.vegCount,
    required this.nonVegCount,
    required this.vendorLimit,
    required this.mallName,
  });

  @override
  Widget build(BuildContext context) {
    final perPerson = budget / (vegCount + nonVegCount);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.summarize_rounded, color: AppTheme.primary, size: 18),
              SizedBox(width: 6),
              Text('Summary', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryDark)),
            ],
          ),
          const SizedBox(height: 10),
          _SummaryRow('📍 Mall', mallName),
          _SummaryRow('👥 Group', '${vegCount + nonVegCount} people ($vegCount🟢 + $nonVegCount🔴)'),
          _SummaryRow('💰 Budget', '₹${budget.toStringAsFixed(0)} (≈₹${perPerson.toStringAsFixed(0)}/person)'),
          _SummaryRow('🏪 Max Stalls', '$vendorLimit'),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
