import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';
import 'preferences_onboarding_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final isGuest = userProvider.isGuest;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: AppTheme.accent)),
        backgroundColor: AppTheme.primary,
        iconTheme: const IconThemeData(color: AppTheme.accent),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: AppTheme.primary,
            child: Icon(
              isGuest ? Icons.person_outline : Icons.person,
              size: 50,
              color: AppTheme.accent,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isGuest ? 'Guest User' : (userProvider.displayName ?? 'Foodie'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (!isGuest && userProvider.currentUser?.email != null)
            Text(
              userProvider.currentUser!.email!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppTheme.textHint),
            ),
          
          const SizedBox(height: 48),
          
          ListTile(
            leading: const Icon(Icons.settings, color: AppTheme.primary),
            title: const Text('Food Preferences'),
            subtitle: const Text('Dietary choices and favorite tags'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PreferencesOnboardingScreen()),
              );
            },
          ),
          
          const Divider(),
          
          if (isGuest)
            ListTile(
              leading: const Icon(Icons.login, color: AppTheme.primary),
              title: const Text('Sign In / Create Account'),
              subtitle: const Text('Save history and sync preferences'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                userProvider.signOut(); // Triggers AuthGate to show AuthScreen
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.logout, color: AppTheme.error),
              title: const Text('Sign Out', style: TextStyle(color: AppTheme.error)),
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Sign Out'),
                    content: const Text('Are you sure you want to sign out?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true), 
                        child: const Text('Sign Out', style: TextStyle(color: AppTheme.error)),
                      ),
                    ],
                  ),
                );
                
                if (confirm == true) {
                  userProvider.signOut();
                }
              },
            ),
        ],
      ),
    );
  }
}
