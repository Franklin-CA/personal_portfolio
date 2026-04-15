import 'package:flutter/material.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Section heading with gradient underline
// ──────────────────────────────────────────────────────────────────────────────

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;
    return Semantics(
      header: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: t.titleLarge),
          const SizedBox(height: 10),
          Container(
            width: 48,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                colors: [
                  scheme.primary,
                  scheme.primary.withValues(alpha: 0.4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
