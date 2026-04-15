import 'package:flutter/material.dart';

import '../theme/palette.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Frosted app-bar background
// ──────────────────────────────────────────────────────────────────────────────

class FrostedAppBarBg extends StatelessWidget {
  const FrostedAppBarBg({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (isDark ? Palette.darkBg : Palette.lightBg)
            .withValues(alpha: 0.82),
      ),
    );
  }
}
