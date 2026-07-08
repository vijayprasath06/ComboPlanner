import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import '../../domain/models/mall.dart';
import '../../domain/models/trending_combo.dart';
import '../../providers/planner_provider.dart';
import '../../data/repositories/local_menu_repository.dart';
import '../../services/geofence_service.dart';
import '../../theme/app_theme.dart';
import 'widgets/mall_selector_sheet.dart';
import 'widgets/trending_combo_card.dart';
import 'history_screen.dart';
import 'input_screen.dart';
import 'profile_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
class HomeScreen extends StatefulWidget {
  final Isar isar;
  const HomeScreen({super.key, required this.isar});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TrendingCombo> _combos = [];
  bool _isDetectingLocation = false;
  String? _geofenceDetectedMallName;

  @override
  void initState() {
    super.initState();
    _tryAutoDetectMall();
  }

  Future<void> _tryAutoDetectMall() async {
    setState(() => _isDetectingLocation = true);
    try {
      final allMalls = await widget.isar.malls.where().findAll();
      final detected = await GeofenceService.detectNearestMall(allMalls);
      if (detected != null && mounted) {
        HapticFeedback.lightImpact();
        context.read<PlannerProvider>().setMall(detected);
        final repo = LocalMenuRepository(widget.isar);
        final combos = await repo.getTrendingCombos(detected.mallId);
        setState(() {
          _combos = combos;
          _geofenceDetectedMallName = detected.name;
        });
      }
    } finally {
      if (mounted) setState(() => _isDetectingLocation = false);
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning!';
    if (hour < 17) return 'Good Afternoon!';
    if (hour < 21) return 'Good Evening!';
    return 'Good Night!';
  }

  String _getMealContext() {
    final hour = DateTime.now().hour;
    if (hour >= 7 && hour < 11) return 'Planning breakfast?';
    if (hour >= 12 && hour < 15) return 'Lunch time! Let\'s plan.';
    if (hour >= 15 && hour < 19) return 'Snack time vibes.';
    if (hour >= 19 && hour < 22) return 'Dinner crew, let\'s go!';
    return 'Late night munchies?';
  }

  void _selectMall() async {
    final mall = await showModalBottomSheet<Mall>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => MallSelectorSheet(isar: widget.isar),
    );
    if (mall != null && mounted) {
      HapticFeedback.lightImpact();
      context.read<PlannerProvider>().setMall(mall);
      final repo = LocalMenuRepository(widget.isar);
      final combos = await repo.getTrendingCombos(mall.mallId);
      setState(() {
        _combos = combos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlannerProvider>();
    final hasMall = provider.selectedMall != null;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          // Hero App Bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppTheme.primary,
            actions: [
              if (_isDetectingLocation)
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Center(
                    child: SizedBox(
                      width: 18, height: 18,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    ),
                  ),
                )
              else ...[
                IconButton(
                  icon: const Icon(Icons.history_rounded, color: Colors.white),
                  tooltip: 'Plan History',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HistoryScreen()),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.person_rounded, color: Colors.white),
                  tooltip: 'Profile',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  ),
                ),
              ],
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.heroGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.fastfood_rounded, color: Colors.white, size: 28),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Combo Planner',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _getGreeting(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getMealContext(),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 14,
                          ),
                        ),
                      ].animate(interval: 100.ms).fade(duration: 500.ms).slideY(begin: 0.2, curve: Curves.easeOutQuad),
                    ),
                  ),
                ),
              ),
              title: Text(
                hasMall ? provider.selectedMall!.name : 'Combo Planner',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              collapseMode: CollapseMode.pin,
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mall selector
                  _SectionLabel(label: '📍 Where are you eating?'),
                  const SizedBox(height: 10),
                  _MallSelectorCard(
                    selectedMallName: provider.selectedMall?.name,
                    selectedMallLocation: provider.selectedMall?.location,
                    onTap: _selectMall,
                  ),

                  // Geofence auto-detect banner
                  if (_geofenceDetectedMallName != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppTheme.vegGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.vegGreen.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.my_location_rounded, color: AppTheme.vegGreen, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '📍 Auto-detected: $_geofenceDetectedMallName',
                              style: const TextStyle(
                                color: AppTheme.vegGreen,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => _geofenceDetectedMallName = null),
                            child: const Icon(Icons.close_rounded, size: 16, color: AppTheme.vegGreen),
                          ),
                        ],
                      ),
                    ),

                  if (hasMall) ...[
                    const SizedBox(height: 16),
                    _SectionLabel(label: '🔥 Trending Now at ${provider.selectedMall!.name}'),
                    const SizedBox(height: 10),
                    if (_combos.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: const Column(
                          children: [
                            Text('🚀', style: TextStyle(fontSize: 32)),
                            SizedBox(height: 8),
                            Text(
                              'Be the first to plan here!',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Generate a combo and accept it to create trending data.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    else
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _combos.length,
                          padding: const EdgeInsets.only(right: 8),
                          itemBuilder: (context, i) => TrendingComboCard(combo: _combos[i]),
                        ),
                      ),

                    const SizedBox(height: 32),

                    // Info cards row
                    Row(
                      children: [
                        _InfoChip(icon: '🌿', label: 'Veg-friendly'),
                        const SizedBox(width: 8),
                        _InfoChip(icon: '📶', label: 'Works Offline'),
                        const SizedBox(width: 8),
                        _InfoChip(icon: '💸', label: 'GST Included'),
                      ],
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const InputScreen()));
                        },
                        icon: const Icon(Icons.bolt_rounded, size: 22),
                        label: const Text('Start Planning'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _MallSelectorCard extends StatelessWidget {
  final String? selectedMallName;
  final String? selectedMallLocation;
  final VoidCallback onTap;

  const _MallSelectorCard({
    this.selectedMallName,
    this.selectedMallLocation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasSelection = selectedMallName != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasSelection ? AppTheme.primary : Colors.grey.shade300,
            width: hasSelection ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: hasSelection ? AppTheme.primary.withValues(alpha: 0.1) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                hasSelection ? Icons.store_mall_directory_rounded : Icons.add_location_alt_outlined,
                color: hasSelection ? AppTheme.primary : Colors.grey,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasSelection ? selectedMallName! : 'Select your mall',
                    style: TextStyle(
                      color: hasSelection ? AppTheme.textDark : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  if (hasSelection && selectedMallLocation != null)
                    Text(
                      selectedMallLocation!,
                      style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                    )
                  else
                    const Text(
                      'Tap to pick from supported Chennai malls',
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: hasSelection ? AppTheme.primary : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
