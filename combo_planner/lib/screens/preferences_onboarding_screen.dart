import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart'; // Or wherever we navigate after onboarding

class PreferencesOnboardingScreen extends StatefulWidget {
  const PreferencesOnboardingScreen({super.key});

  @override
  State<PreferencesOnboardingScreen> createState() => _PreferencesOnboardingScreenState();
}

class _PreferencesOnboardingScreenState extends State<PreferencesOnboardingScreen> {
  String _dietaryPreference = 'both';
  final Set<String> _likedTags = {};
  final Set<String> _dislikedTags = {};
  bool _isLoading = false;

  final List<String> _availableTags = [
    'Spicy', 'Sweet', 'Biryani', 'Fast Food', 'South Indian',
    'North Indian', 'Chinese', 'Healthy', 'Beverage', 'Dessert'
  ];

  Future<void> _savePreferences() async {
    setState(() => _isLoading = true);
    final userProvider = context.read<UserProvider>();
    final user = Supabase.instance.client.auth.currentUser;

    try {
      if (user != null) {
        // Update user_profiles (dietary_preference)
        await Supabase.instance.client.from('user_profiles').upsert({
          'id': user.id,
          'dietary_preference': _dietaryPreference,
          'display_name': userProvider.displayName ?? 'Foodie',
        });

        // Update user_preferences
        await Supabase.instance.client.from('user_preferences').upsert({
          'user_id': user.id,
          'liked_tags': _likedTags.toList(),
          'disliked_tags': _dislikedTags.toList(),
        });
      }

      // Update provider locally
      userProvider.dietaryPreference = _dietaryPreference;
      userProvider.likedTags = _likedTags;
      userProvider.dislikedTags = _dislikedTags;
      
      // Notify provider to update PlannerProvider if needed
      userProvider.refreshState();

      if (mounted) {
        Navigator.of(context).pop(); // Or navigate to Home if this is first login
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save preferences: $e'), backgroundColor: AppTheme.error),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _toggleTag(String tag, bool isLike) {
    setState(() {
      if (isLike) {
        if (_likedTags.contains(tag)) {
          _likedTags.remove(tag);
        } else {
          _likedTags.add(tag);
          _dislikedTags.remove(tag); // Cannot be both
        }
      } else {
        if (_dislikedTags.contains(tag)) {
          _dislikedTags.remove(tag);
        } else {
          _dislikedTags.add(tag);
          _likedTags.remove(tag);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Your Preferences', style: TextStyle(color: AppTheme.accent)),
        backgroundColor: AppTheme.primary,
        iconTheme: const IconThemeData(color: AppTheme.accent),
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator(color: AppTheme.accent))
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text('Dietary Preference', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 16),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'both', label: Text('Anything')),
                    ButtonSegment(value: 'veg', label: Text('Veg Only')),
                    ButtonSegment(value: 'nonveg', label: Text('Non-Veg Only')),
                  ],
                  selected: {_dietaryPreference},
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      _dietaryPreference = newSelection.first;
                    });
                  },
                ),
                
                const SizedBox(height: 32),
                
                Text('Food Tags', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                const Text('Tap once to Like (Green), tap twice to Dislike (Red).', style: TextStyle(color: AppTheme.textHint)),
                const SizedBox(height: 16),
                
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _availableTags.map((tag) {
                    final isLiked = _likedTags.contains(tag);
                    final isDisliked = _dislikedTags.contains(tag);
                    
                    Color chipColor = AppTheme.surface;
                    Color textColor = AppTheme.textPrimary;
                    
                    if (isLiked) {
                      chipColor = Colors.green.shade800;
                      textColor = Colors.white;
                    } else if (isDisliked) {
                      chipColor = Colors.red.shade800;
                      textColor = Colors.white;
                    }

                    return ChoiceChip(
                      label: Text(tag, style: TextStyle(color: textColor)),
                      selected: isLiked || isDisliked,
                      selectedColor: chipColor,
                      backgroundColor: AppTheme.surface,
                      onSelected: (_) {
                        if (!isLiked && !isDisliked) {
                          _toggleTag(tag, true);
                        } else if (isLiked) {
                          _toggleTag(tag, false);
                        } else {
                          setState(() {
                            _dislikedTags.remove(tag);
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 48),
                
                ElevatedButton(
                  onPressed: _savePreferences,
                  child: const Text('Save Preferences'),
                ),
              ],
            ),
    );
  }
}
