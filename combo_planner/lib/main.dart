import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'domain/models/mall.dart';
import 'domain/models/menu_item.dart';
import 'domain/models/stall.dart';
import 'domain/models/trending_combo.dart';
import 'domain/models/plan_history.dart';
import 'data/repositories/local_menu_repository.dart';
import 'providers/planner_provider.dart';
import 'theme/app_theme.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/user_provider.dart';
import 'screens/auth_gate.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    publishableKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [MallSchema, MenuItemSchema, StallSchema, TrendingComboSchema, PlanHistorySchema],
    directory: dir.path,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PlannerProvider(LocalMenuRepository(isar), isar)),
      ],
      child: MyApp(isar: isar),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Isar isar;
  const MyApp({super.key, required this.isar});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Combo Planner',
      theme: AppTheme.lightTheme,
      home: AuthGate(isar: isar),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
    );
  }
}
