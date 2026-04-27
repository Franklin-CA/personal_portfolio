import 'package:flutter/material.dart';
import 'data/portfolio_content.dart';
import 'pages/portfolio_home.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
        return;
      }
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
        return;
      }
      final isSystemDark =
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
      _themeMode = isSystemDark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSystemDark =
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
    final isDark =
        _themeMode == ThemeMode.dark ||
        (_themeMode == ThemeMode.system && isSystemDark);

    return MaterialApp(
      title: '${PortfolioContent.name} · ${PortfolioContent.headline}',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      home: PortfolioHome(isDarkMode: isDark, onToggleTheme: _toggleTheme),
    );
  }
}
