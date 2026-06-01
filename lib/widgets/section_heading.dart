import 'package:flutter/material.dart';
import '../theme/palette.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Section heading with cyber gradient underline
// ──────────────────────────────────────────────────────────────────────────────

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Semantics(
      header: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: t.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 56,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                colors: [
                  Palette.cyberPurple,
                  Palette.cyberCyan,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
