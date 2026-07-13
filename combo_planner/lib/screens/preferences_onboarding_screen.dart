import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';

class PreferencesOnboardingScreen extends StatefulWidget {
  const PreferencesOnboardingScreen({super.key});

  @override
  State<PreferencesOnboardingScreen> createState() => _PreferencesOnboardingScreenState();
}

class _PreferencesOnboardingScreenState extends State<PreferencesOnboardingScreen> {
  final List<String> _tags = [
    'Spicy', 'Sweet', 'Biryani', 'Fast Food', 'South Indian',
    'North Indian', 'Chinese', 'Healthy', 'Beverage', 'Dessert'
  ];
  int _currentIndex = 0;
  final Set<String> _likedTags = {};
  final Set<String> _dislikedTags = {};
  bool _isLoading = false;

  void _onSwipe(bool isRight) {
    if (_currentIndex >= _tags.length) return;
    
    HapticFeedback.selectionClick();
    final tag = _tags[_currentIndex];
    if (isRight) {
      _likedTags.add(tag);
    } else {
      _dislikedTags.add(tag);
    }
    
    setState(() {
      _currentIndex++;
    });

    if (_currentIndex >= _tags.length) {
      _finishOnboarding();
    }
  }

  Future<void> _finishOnboarding() async {
    setState(() => _isLoading = true);
    final userProvider = context.read<UserProvider>();
    try {
      await userProvider.savePreferences(_likedTags, _dislikedTags);

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Food Preferences'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.primary))
          : SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text('Food Tinder', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.primaryDark)),
                        SizedBox(height: 8),
                        Text('Swipe Right to Like\nSwipe Left to Dislike', 
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme.textSecondary)
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_currentIndex >= _tags.length)
                          const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle_rounded, color: AppTheme.vegGreen, size: 64),
                                SizedBox(height: 16),
                                Text("All done! Saving...", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        else
                          ...List.generate(_tags.length - _currentIndex, (i) {
                            final idx = _tags.length - 1 - i;
                            final tag = _tags[idx];
                            final isTop = idx == _currentIndex;
                            
                            return isTop 
                                ? _TinderCard(
                                    key: ValueKey(tag),
                                    tag: tag,
                                    onSwipeRight: () => _onSwipe(true),
                                    onSwipeLeft: () => _onSwipe(false),
                                  )
                                : Positioned(
                                    top: 10.0 * (_tags.length - 1 - i - _currentIndex),
                                    child: Transform.scale(
                                      scale: max(0.8, 1.0 - 0.05 * (idx - _currentIndex)),
                                      child: _CardView(tag: tag),
                                    ),
                                  );
                          }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }
}

class _TinderCard extends StatefulWidget {
  final String tag;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;

  const _TinderCard({super.key, required this.tag, required this.onSwipeRight, required this.onSwipeLeft});

  @override
  State<_TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<_TinderCard> {
  Offset _position = Offset.zero;
  double _angle = 0;
  bool _isDragging = false;

  void _onPanStart(DragStartDetails details) {
    setState(() { _isDragging = true; });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _position += details.delta;
      _angle = 45 * (_position.dx / MediaQuery.of(context).size.width) * (pi / 180);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() { _isDragging = false; });
    if (_position.dx > 100) {
      widget.onSwipeRight();
    } else if (_position.dx < -100) {
      widget.onSwipeLeft();
    } else {
      setState(() {
        _position = Offset.zero;
        _angle = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Swipeable card for ${widget.tag}',
      hint: 'Swipe right to like, left to dislike',
      child: AnimatedContainer(
        duration: _isDragging ? Duration.zero : const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        transform: Matrix4.translationValues(_position.dx, _position.dy, 0)..rotateZ(_angle),
        transformAlignment: FractionalOffset.center,
        child: GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: _CardView(
            tag: widget.tag,
            likeOpacity: (_position.dx / 100).clamp(0.0, 1.0),
            dislikeOpacity: (-_position.dx / 100).clamp(0.0, 1.0),
          ),
        ),
      ),
    );
  }
}

class _CardView extends StatelessWidget {
  final String tag;
  final double likeOpacity;
  final double dislikeOpacity;

  const _CardView({
    required this.tag,
    this.likeOpacity = 0.0,
    this.dislikeOpacity = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(24),
      shadowColor: Colors.black26,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                tag,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: Colors.white, shadows: [
                  Shadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 8),
                ]),
              ),
            ),
            if (likeOpacity > 0)
              Positioned(
                top: 30,
                left: 30,
                child: Opacity(
                  opacity: likeOpacity,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('LIKE', style: TextStyle(color: Colors.green, fontSize: 32, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            if (dislikeOpacity > 0)
              Positioned(
                top: 30,
                right: 30,
                child: Opacity(
                  opacity: dislikeOpacity,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('NOPE', style: TextStyle(color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
