import 'package:flutter/material.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Gradient divider
// ──────────────────────────────────────────────────────────────────────────────

class GradientDivider extends StatelessWidget {
  const GradientDivider({super.key, required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
        gradient: LinearGradient(
          colors: [
            scheme.primary.withValues(alpha: 0.0),
            scheme.primary.withValues(alpha: 0.7),
            scheme.primary.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}
