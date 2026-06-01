import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/palette.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Frosted app-bar background with premium glassmorphic blur
// ──────────────────────────────────────────────────────────────────────────────

class FrostedAppBarBg extends StatelessWidget {
  const FrostedAppBarBg({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: (isDark ? Palette.darkBg : Palette.lightBg)
                .withValues(alpha: 0.72),
            border: Border(
              bottom: BorderSide(
                color: scheme.primary.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
