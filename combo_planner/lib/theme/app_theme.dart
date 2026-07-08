import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
/// App color system — Phase 3 redesign
/// Primary: Near-black  #1F1F1F
/// Accent:  Antique Gold #D4AF37
/// Background: Off-white #FAFAFA
class AppTheme {
  // ── Core Palette ──────────────────────────────────────────────────────────
  static const Color primary        = Color(0xFF1F1F1F); // Near-black
  static const Color primaryDark    = Color(0xFF121212); // Deeper black
  static const Color primaryLight   = Color(0xFF2D2D2D); // Charcoal
  static const Color accent         = Color(0xFFD4AF37); // Antique gold
  static const Color accentLight    = Color(0xFFE8CA6A); // Light gold
  static const Color accentDark     = Color(0xFFB8941F); // Deep gold

  // ── Surfaces ──────────────────────────────────────────────────────────────
  static const Color background     = Color(0xFFFAFAFA); // Off-white
  static const Color surface        = Color(0xFFFFFFFF); // Card white
  static const Color surfaceVariant = Color(0xFFF5F5F5); // Light grey surface

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color textPrimary    = Color(0xFF212121);
  static const Color textSecondary  = Color(0xFF757575);
  static const Color textHint       = Color(0xFFBDBDBD);
  static const Color textOnDark     = Color(0xFFFFFFFF);
  static const Color textOnAccent   = Color(0xFF1F1F1F); // Dark text on gold

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color vegGreen       = Color(0xFF388E3C);
  static const Color vegGreenLight  = Color(0xFFE8F5E9);
  static const Color nonVegRed      = Color(0xFFC62828);
  static const Color nonVegRedLight = Color(0xFFFFEBEE);
  static const Color success        = Color(0xFF2E7D32);
  static const Color error          = Color(0xFFB71C1C);
  static const Color warning        = Color(0xFFF57F17);
  static const Color divider        = Color(0xFFE0E0E0);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1F1F1F), Color(0xFF2D2D2D)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD4AF37), Color(0xFFB8941F)],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1F1F1F), Color(0xFF121212)],
  );

  // ── Card Shadows ──────────────────────────────────────────────────────────
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 12,
      offset: const Offset(0, 3),
    ),
  ];

  static List<BoxShadow> get accentShadow => [
    BoxShadow(
      color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  // ── ThemeData ─────────────────────────────────────────────────────────────
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    fontFamily: 'Outfit',
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: accent,
      surface: surface,
      onPrimary: textOnDark,
      onSecondary: textOnAccent,
      onSurface: textPrimary,
      error: error,
    ),

    // ── AppBar ──────────────────────────────────────────────────────────────
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: textOnDark,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Outfit',
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: textOnDark,
      ),
      iconTheme: IconThemeData(color: textOnDark),
    ),

    // ── ElevatedButton (gold CTA) ────────────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accent,
        foregroundColor: textOnAccent,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // ── OutlinedButton ──────────────────────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // ── TextButton ──────────────────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accent,
        textStyle: const TextStyle(
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // ── Input / TextField ───────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accent, width: 2),
      ),
      labelStyle: const TextStyle(color: textSecondary),
      hintStyle: const TextStyle(color: textHint),
    ),

    // ── Card ────────────────────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: divider, width: 0.5),
      ),
    ),

    // ── Chip ─────────────────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: surfaceVariant,
      labelStyle: GoogleFonts.outfit(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide.none,
    ),

    // ── Slider ──────────────────────────────────────────────────────────
    sliderTheme: const SliderThemeData(
      activeTrackColor: accent,
      inactiveTrackColor: Color(0xFFE0D5B0),
      thumbColor: accent,
      overlayColor: Color(0x33D4AF37),
      trackHeight: 4,
    ),

    // ── SnackBar ─────────────────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primary,
      contentTextStyle: GoogleFonts.outfit(
        color: textOnDark,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
    ),

    // ── Text Theme ───────────────────────────────────────────────────────
    textTheme: GoogleFonts.outfitTextTheme(const TextTheme(
      displayLarge:  TextStyle(fontWeight: FontWeight.w900, color: textPrimary),
      displayMedium: TextStyle(fontWeight: FontWeight.w800, color: textPrimary),
      headlineLarge: TextStyle(fontWeight: FontWeight.w800, color: textPrimary),
      headlineMedium:TextStyle(fontWeight: FontWeight.w700, color: textPrimary),
      headlineSmall: TextStyle(fontWeight: FontWeight.w700, color: textPrimary),
      titleLarge:    TextStyle(fontWeight: FontWeight.w700, color: textPrimary),
      titleMedium:   TextStyle(fontWeight: FontWeight.w600, color: textPrimary),
      titleSmall:    TextStyle(fontWeight: FontWeight.w600, color: textSecondary),
      bodyLarge:     TextStyle(fontWeight: FontWeight.w400, color: textPrimary),
      bodyMedium:    TextStyle(fontWeight: FontWeight.w400, color: textPrimary),
      bodySmall:     TextStyle(fontWeight: FontWeight.w400, color: textSecondary),
      labelLarge:    TextStyle(fontWeight: FontWeight.w600, color: textPrimary),
      labelMedium:   TextStyle(fontWeight: FontWeight.w500, color: textSecondary),
      labelSmall:    TextStyle(fontWeight: FontWeight.w500, color: textHint),
    )),

    // ── Bottom Sheet ─────────────────────────────────────────────────────
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),

    // ── Dialog ───────────────────────────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: GoogleFonts.outfit(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: textPrimary,
      ),
    ),

    // ── Divider ──────────────────────────────────────────────────────────
    dividerTheme: const DividerThemeData(color: divider, thickness: 0.5),
  );
  // ── Backward-compat aliases (referenced by existing screens) ─────────────
  /// Alias for theme getter (was AppTheme.lightTheme)
  static ThemeData get lightTheme => theme;

  /// Alias for textOnDark (was AppTheme.textDark)
  static const Color textDark = textOnDark;

  /// Card gradient (replaces old cardGradient)
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surface, surfaceVariant],
  );

  /// Dismiss background for swipeable items
  static const Color dismissRed = Color(0xFFC62828);

  /// GST badge color (reuse accent)
  static const Color gstBadge = accent;
}
