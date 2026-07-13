import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/supabase_service.dart';

class UserProvider with ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  bool _isGuest = false;
  
  // Profile data
  String? displayName;
  String? preferredMallId;
  String dietaryPreference = 'both';
  
  // Food preferences
  Set<String> likedTags = {};
  Set<String> dislikedTags = {};
  
  UserProvider() {
    _loadLocalPreferences();
    _supabase.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn) {
        _isGuest = false;
        _loadUserData();
      } else if (data.event == AuthChangeEvent.signedOut) {
        _clearUserData();
      }
    });
  }
  
  bool get isAuthenticated => _supabase.auth.currentUser != null;
  bool get isGuest => _isGuest;
  User? get currentUser => _supabase.auth.currentUser;

  Future<void> loginAsGuest() async {
    _isGuest = true;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    _isGuest = false;
    notifyListeners();
  }
  
  void refreshState() {
    notifyListeners();
  }

  Future<void> _loadLocalPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      likedTags = (prefs.getStringList('likedTags') ?? []).toSet();
      dislikedTags = (prefs.getStringList('dislikedTags') ?? []).toSet();
      notifyListeners();
    } catch (_) {}
  }

  Future<void> savePreferences(Set<String> newLiked, Set<String> newDisliked) async {
    likedTags = newLiked;
    dislikedTags = newDisliked;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('likedTags', likedTags.toList());
      await prefs.setStringList('dislikedTags', dislikedTags.toList());
      
      if (isAuthenticated && currentUser != null) {
        await _supabase.from('user_preferences').upsert({
          'user_id': currentUser!.id,
          'liked_tags': likedTags.toList(),
          'disliked_tags': dislikedTags.toList(),
          'updated_at': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      debugPrint('Error saving preferences: $e');
    }
  }
  
  Future<void> _loadUserData() async {
    final user = currentUser;
    if (user == null) return;
    
    try {
      final profileRes = await _supabase
          .from('user_profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();
          
      if (profileRes != null) {
        displayName = profileRes['display_name'] as String?;
        preferredMallId = profileRes['preferred_mall_id'] as String?;
        dietaryPreference = profileRes['dietary_preference'] as String? ?? 'both';
      }
      
      final prefsRes = await _supabase
          .from('user_preferences')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();
          
      if (prefsRes != null) {
        final cloudLiked = Set<String>.from(prefsRes['liked_tags'] as List<dynamic>? ?? []);
        final cloudDisliked = Set<String>.from(prefsRes['disliked_tags'] as List<dynamic>? ?? []);
        
        // Merge strategy: Local swipe actions taken while guest > Cloud data
        if (likedTags.isNotEmpty || dislikedTags.isNotEmpty) {
          final mergedLiked = cloudLiked.union(likedTags);
          final mergedDisliked = cloudDisliked.union(dislikedTags);
          await savePreferences(mergedLiked, mergedDisliked); // upload merged back to cloud
        } else {
          likedTags = cloudLiked;
          dislikedTags = cloudDisliked;
          
          final prefs = await SharedPreferences.getInstance();
          await prefs.setStringList('likedTags', likedTags.toList());
          await prefs.setStringList('dislikedTags', dislikedTags.toList());
        }
      } else {
        // First login, push local guest tags up
        if (likedTags.isNotEmpty || dislikedTags.isNotEmpty) {
          await savePreferences(likedTags, dislikedTags);
        }
      }
      
      notifyListeners();
      
      // Trigger migration in background
      try {
        final isar = Isar.getInstance();
        if (isar != null) {
          final supabaseService = SupabaseService();
          await supabaseService.migrateLocalHistoryToCloud(isar);
        }
      } catch (e) {
        debugPrint('Migration error: $e');
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  void _clearUserData() {
    displayName = null;
    preferredMallId = null;
    dietaryPreference = 'both';
    likedTags = {};
    dislikedTags = {};
    notifyListeners();
  }
}
