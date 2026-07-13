import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:isar/isar.dart';
import '../../data/repositories/local_menu_repository.dart';
import '../../providers/planner_provider.dart';
import '../../theme/app_theme.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  final Isar isar;
  const SplashScreen({super.key, required this.isar});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _statusText = 'Starting up...';

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    try {
      // Check if DB is already seeded (SharedPreferences flag)
      final alreadySeeded = await PlannerProvider.isAlreadySeeded();

      if (!alreadySeeded) {
        if (mounted) setState(() => _statusText = 'Loading menu data...');
        await LocalMenuRepository(widget.isar).seedFromJson();
        await PlannerProvider.markSeeded();
      }
    } catch (e, stack) {
      debugPrint('Error during init: $e');
      debugPrint(stack.toString());
    }

    // Small delay so the splash animation completes
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(isar: widget.isar),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.heroGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.fastfood_rounded, size: 72, color: Colors.white),
              )
                  .animate()
                  .scale(duration: 500.ms, curve: Curves.elasticOut)
                  .fadeIn(duration: 400.ms),
              const SizedBox(height: 24),
              const Text(
                'Combo Planner',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.3, curve: Curves.easeOut),
              const SizedBox(height: 8),
              const Text(
                'Chennai Edition',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              )
                  .animate(delay: 400.ms)
                  .fadeIn(duration: 600.ms),
              const SizedBox(height: 48),
              Text(
                _statusText,
                style: const TextStyle(color: Colors.white60, fontSize: 13),
              ).animate(delay: 600.ms).fadeIn(duration: 400.ms),
              const SizedBox(height: 16),
              const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              ).animate(delay: 600.ms).fadeIn(duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}
