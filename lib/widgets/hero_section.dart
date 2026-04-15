import 'package:flutter/material.dart';

import '../data/portfolio_content.dart';
import 'animated_gradient_text.dart';
import 'profile_photo.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Hero section with profile photo + intro text
// ──────────────────────────────────────────────────────────────────────────────

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.wide,
    required this.textTheme,
    required this.scheme,
    required this.onSeeProjects,
  });

  final bool wide;
  final TextTheme textTheme;
  final ColorScheme scheme;
  final VoidCallback onSeeProjects;

  @override
  Widget build(BuildContext context) {
    final photo = ProfilePhoto(scheme: scheme);
    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Hi \u2014 I'm ${PortfolioContent.name.split(' ').first}.",
          style: textTheme.headlineLarge,
        ),
        const SizedBox(height: 10),
        AnimatedGradientText(
          text: PortfolioContent.headline,
          style: textTheme.titleLarge!.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 20),
        SelectableText(
          PortfolioContent.tagline,
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 28),
        Tooltip(
          message: 'Scroll to the projects list',
          child: FilledButton(
            onPressed: onSeeProjects,
            child: const Text('See projects'),
          ),
        ),
      ],
    );

    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: intro),
          const SizedBox(width: 48),
          photo,
        ],
      );
    }

    // Mobile: photo on top, centered
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: photo),
        const SizedBox(height: 32),
        intro,
      ],
    );
  }
}
