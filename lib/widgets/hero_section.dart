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
    required this.onHireMe,
  });

  final bool wide;
  final TextTheme textTheme;
  final ColorScheme scheme;
  final VoidCallback onSeeProjects;
  final VoidCallback onHireMe;

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
        wide
            ? Row(
                children: [
                  Tooltip(
                    message: 'Scroll to the projects list',
                    child: FilledButton(
                      onPressed: onSeeProjects,
                      child: const Text('View projects'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Tooltip(
                    message: 'Get in touch',
                    child: OutlinedButton.icon(
                      onPressed: onHireMe,
                      icon: const Icon(Icons.person_add_rounded, size: 18),
                      label: const Text('Hire me'),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Tooltip(
                    message: 'Scroll to the projects list',
                    child: FilledButton(
                      onPressed: onSeeProjects,
                      child: const Text('View projects'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Tooltip(
                    message: 'Get in touch',
                    child: OutlinedButton.icon(
                      onPressed: onHireMe,
                      icon: const Icon(Icons.person_add_rounded, size: 18),
                      label: const Text('Hire me'),
                    ),
                  ),
                ],
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
