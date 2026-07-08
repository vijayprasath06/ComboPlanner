import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:isar/isar.dart';
import '../providers/user_provider.dart';
import 'auth_screen.dart';
import 'splash_screen.dart';

class AuthGate extends StatelessWidget {
  final Isar isar;
  
  const AuthGate({super.key, required this.isar});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    
    // If user is authenticated or chose guest mode, show the splash screen (which loads DB and navigates to home)
    if (userProvider.isAuthenticated || userProvider.isGuest) {
      return SplashScreen(isar: isar);
    }
    
    // Otherwise show auth screen
    return const AuthScreen();
  }
}
