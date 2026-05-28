import 'package:flutter/material.dart';

class AppTheme {
  // tsugi. brand seed color
  static const _seed = Color(0xFF10B981);

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    ).copyWith(
      primary: const Color(0xFF10B981),
      onPrimary: const Color(0xFF022C22),
      primaryContainer: const Color(0xFF065F46),
      onPrimaryContainer: const Color(0xFFA7F3D0),
      secondary: const Color(0xFF5B8DEE),
      tertiary: const Color(0xFFA78BFA),
      surface: const Color(0xFF0B1910),
      surfaceContainerHighest: const Color(0xFF0F2418),
      error: const Color(0xFFEF4444),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF0B1910),

      // typography
      fontFamily: 'Inter',
      textTheme: _buildTextTheme(scheme),

      // app bar
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF0B1910),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(color: scheme.onSurface),
      ),

      // navigation bar (bottom nav)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF0B1910),
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: scheme.primary,
            );
          }
          return TextStyle(
            fontSize: 11,
            color: scheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: scheme.primary, size: 22);
          }
          return IconThemeData(color: scheme.onSurfaceVariant, size: 22);
        }),
      ),

      // card
      cardTheme: CardThemeData(
        color: const Color(0xFF0F2418),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.07),
            width: 0.5,
          ),
        ),
      ),

      // chips
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white.withValues(alpha: 0.06),
        selectedColor: scheme.primaryContainer,
        labelStyle: const TextStyle(fontSize: 12),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.12), width: 0.5),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      ),

      // input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.07),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: scheme.onSurfaceVariant),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),

      // list tile
      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        iconColor: scheme.onSurfaceVariant,
        titleTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: scheme.onSurface,
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 12,
          color: scheme.onSurfaceVariant,
        ),
      ),

      // divider
      dividerTheme: DividerThemeData(
        color: Colors.white.withValues(alpha: 0.07),
        thickness: 0.5,
        space: 0,
      ),

      // snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF1E3A2A),
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'Inter',
    );
  }

  static TextTheme _buildTextTheme(ColorScheme scheme) {
    return TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: scheme.onSurface, letterSpacing: -1),
      displayMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: scheme.onSurface, letterSpacing: -.5),
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: scheme.onSurface, letterSpacing: -.3),
      headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: scheme.onSurface),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: scheme.onSurface),
      titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: scheme.onSurface),
      titleSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: scheme.onSurface),
      bodyLarge: TextStyle(fontSize: 15, color: scheme.onSurface),
      bodyMedium: TextStyle(fontSize: 14, color: scheme.onSurface),
      bodySmall: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
      labelLarge: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: scheme.onSurface),
      labelSmall: TextStyle(fontSize: 10, color: scheme.onSurfaceVariant),
    );
  }
}

// convenient extension
extension TsugiColors on ColorScheme {
  Color get updateGreen => const Color(0xFF10B981);
  Color get gapAmber => const Color(0xFFFBBF24);
  Color get rawPurple => const Color(0xFFA78BFA);
  Color get surfaceCard => const Color(0xFF0F2418);
  Color get dividerColor => Colors.white.withValues(alpha: 0.07);
}
