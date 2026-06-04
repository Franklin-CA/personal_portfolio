import 'package:flutter/material.dart';

import 'palette.dart';

/// The two main aesthetic design flavors of the portfolio.
enum ThemeFlavor {
  cyberpunk,
  jadePebble,
}

/// Builds the light and dark [ThemeData] for the portfolio.
class AppTheme {
  AppTheme._();

  static ThemeData light({ThemeFlavor flavor = ThemeFlavor.cyberpunk}) {
    final isJade = flavor == ThemeFlavor.jadePebble;
    final bg = isJade ? Palette.jadeLightBg : Palette.lightBg;
    final surface = isJade ? Palette.jadeLightSurface : Palette.lightSurface;
    final ink = isJade ? Palette.jadeLightInk : Palette.lightInk;
    final muted = isJade ? Palette.jadeLightMuted : Palette.lightMuted;
    final rule = isJade ? Palette.jadeLightRule : Palette.lightRule;
    final primary = isJade ? Palette.jadePrimary : Palette.cyberPurple;
    final secondary = isJade ? Palette.jadeSlate : Palette.cyberCyan;
    final tertiary = isJade ? Palette.jadeSage : Palette.cyberPink;
    final onPrimary = isJade ? Palette.jadeLightBg : Colors.white;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.light(
        surface: surface,
        onSurface: ink,
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        onPrimary: onPrimary,
        onSurfaceVariant: muted,
        outline: rule,
        outlineVariant: rule.withValues(alpha: 0.5),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: ink,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: ink,
          letterSpacing: 0.15,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: rule,
        thickness: 1,
        space: 1,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 44,
          fontWeight: FontWeight.w700,
          height: 1.1,
          letterSpacing: -1.2,
          color: ink,
        ),
        headlineMedium: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w600,
          height: 1.15,
          letterSpacing: -0.6,
          color: ink,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          height: 1.3,
          letterSpacing: -0.3,
          color: ink,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          height: 1.35,
          letterSpacing: -0.15,
          color: ink,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
          letterSpacing: 0.01,
          color: muted,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.55,
          letterSpacing: 0.01,
          color: muted,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.02,
          color: ink,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          minimumSize: const Size(48, 48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          minimumSize: const Size(48, 48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static ThemeData dark({ThemeFlavor flavor = ThemeFlavor.cyberpunk}) {
    final isJade = flavor == ThemeFlavor.jadePebble;
    final bg = isJade ? Palette.jadeDarkBg : Palette.darkBg;
    final surface = isJade ? Palette.jadeDarkSurface : Palette.darkSurface;
    final ink = isJade ? Palette.jadeDarkInk : Palette.darkInk;
    final muted = isJade ? Palette.jadeDarkMuted : Palette.darkMuted;
    final rule = isJade ? Palette.jadeDarkRule : Palette.darkRule;
    final primary = isJade ? Palette.jadePrimary : Palette.cyberPurple;
    final secondary = isJade ? Palette.jadeSlate : Palette.cyberCyan;
    final tertiary = isJade ? Palette.jadeSage : Palette.cyberPink;
    final onPrimary = isJade ? Palette.jadeDarkBg : Palette.darkBg;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.dark(
        surface: surface,
        onSurface: ink,
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        onPrimary: onPrimary,
        onSurfaceVariant: muted,
        outline: rule,
        outlineVariant: rule.withValues(alpha: 0.5),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: ink,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: ink,
          letterSpacing: 0.15,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: rule,
        thickness: 1,
        space: 1,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 44,
          fontWeight: FontWeight.w700,
          height: 1.1,
          letterSpacing: -1.2,
          color: ink,
        ),
        headlineMedium: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w600,
          height: 1.15,
          letterSpacing: -0.6,
          color: ink,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          height: 1.3,
          letterSpacing: -0.3,
          color: ink,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          height: 1.35,
          letterSpacing: -0.15,
          color: ink,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
          letterSpacing: 0.01,
          color: muted,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.55,
          letterSpacing: 0.01,
          color: muted,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.02,
          color: ink,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          minimumSize: const Size(48, 48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          minimumSize: const Size(48, 48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
