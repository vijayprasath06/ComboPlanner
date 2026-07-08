import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
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
        likedTags = Set<String>.from(prefsRes['liked_tags'] as List<dynamic>? ?? []);
        dislikedTags = Set<String>.from(prefsRes['disliked_tags'] as List<dynamic>? ?? []);
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
