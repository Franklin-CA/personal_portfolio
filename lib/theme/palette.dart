import 'package:flutter/material.dart';

/// Central colour tokens used across the portfolio.
class Palette {
  Palette._();

  // Futuristic Core Accent Colors
  static const Color cyberPurple = Color(0xFF8B5CF6);
  static const Color cyberCyan = Color(0xFF00F2FE);
  static const Color cyberPink = Color(0xFFEC4899);

  // Light Theme (Holographic Light Mode)
  static const Color lightBg = Color(0xFFF1F5F9);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightInk = Color(0xFF0F172A);
  static const Color lightMuted = Color(0xFF64748B);
  static const Color lightRule = Color(0xFFE2E8F0);
  static const Color accent = cyberPurple;
  static const Color accentLight = Color(0xFFA78BFA);

  // Dark Theme (Obsidian Deep Space Cyberpunk)
  static const Color darkBg = Color(0xFF030308);
  static const Color darkSurface = Color(0xFF0B0B14);
  static const Color darkInk = Color(0xFFF1F5F9);
  static const Color darkMuted = Color(0xFF94A3B8);
  static const Color darkRule = Color(0xFF1E1E2F);
}
