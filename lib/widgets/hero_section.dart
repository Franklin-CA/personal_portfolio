import 'package:flutter/material.dart';

import '../data/portfolio_content.dart';
import '../theme/palette.dart';
import 'animated_gradient_text.dart';
import 'profile_photo.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Hero section with profile photo + intro text + pulsing tech-badge
// ──────────────────────────────────────────────────────────────────────────────

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.wide,
    required this.textTheme,
    required this.scheme,
    required this.onSeeProjects,
    required this.onHireMe,
    required this.onOpenUrl,
  });

  final bool wide;
  final TextTheme textTheme;
  final ColorScheme scheme;
  final VoidCallback onSeeProjects;
  final VoidCallback onHireMe;
  final Future<void> Function(String) onOpenUrl;

  @override
  Widget build(BuildContext context) {
    final photo = ProfilePhoto(scheme: scheme);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = (isDark ? Colors.white : Colors.black).withValues(alpha: 0.15);
    final iconColor = isDark ? Colors.white60 : Colors.black54;

    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const _PulseBadge(),
        const SizedBox(height: 24),
        Text(
          "Hi \u2014 I'm ${PortfolioContent.name.split(' ').first}.",
          style: textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 10),
        AnimatedGradientText(
          text: PortfolioContent.headline,
          style: textTheme.titleLarge!.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        SelectableText(
          PortfolioContent.tagline,
          style: textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        const SizedBox(height: 32),
        // CTA buttons + social icons
        wide
            ? Row(
                children: [
                  // View projects
                  Tooltip(
                    message: 'Scroll to the projects list',
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Palette.cyberPurple, Palette.cyberCyan],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Palette.cyberPurple.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: FilledButton(
                        onPressed: onSeeProjects,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text(
                          'View projects',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Hire me
                  Tooltip(
                    message: 'Get in touch',
                    child: OutlinedButton.icon(
                      onPressed: onHireMe,
                      icon: Icon(Icons.person_add_rounded, size: 16, color: iconColor),
                      label: Text(
                        'Hire me',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: isDark ? Colors.white70 : Colors.black87),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: borderColor, width: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Divider
                  Container(width: 1, height: 28, color: borderColor),
                  const SizedBox(width: 16),
                  // GitHub
                  Tooltip(
                    message: 'GitHub',
                    child: InkWell(
                      onTap: () => onOpenUrl(PortfolioContent.githubUrl),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.code_rounded, size: 18, color: iconColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // LinkedIn
                  Tooltip(
                    message: 'LinkedIn',
                    child: InkWell(
                      onTap: () => onOpenUrl(PortfolioContent.linkedInUrl),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.work_outline_rounded, size: 18, color: iconColor),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // View projects
                  Tooltip(
                    message: 'Scroll to the projects list',
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Palette.cyberPurple, Palette.cyberCyan],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Palette.cyberPurple.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: FilledButton(
                        onPressed: onSeeProjects,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text(
                          'View projects',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Hire me
                  Tooltip(
                    message: 'Get in touch',
                    child: OutlinedButton.icon(
                      onPressed: onHireMe,
                      icon: Icon(Icons.person_add_rounded, size: 16, color: iconColor),
                      label: Text(
                        'Hire me',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: isDark ? Colors.white70 : Colors.black87),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: borderColor, width: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Social icons row
                  Row(
                    children: [
                      Tooltip(
                        message: 'GitHub',
                        child: InkWell(
                          onTap: () => onOpenUrl(PortfolioContent.githubUrl),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.code_rounded, size: 18, color: iconColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Tooltip(
                        message: 'LinkedIn',
                        child: InkWell(
                          onTap: () => onOpenUrl(PortfolioContent.linkedInUrl),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.work_outline_rounded, size: 18, color: iconColor),
                          ),
                        ),
                      ),
                    ],
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
        const SizedBox(height: 40),
        intro,
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Stateful, animated pulsing cyber badge
// ──────────────────────────────────────────────────────────────────────────────

class _PulseBadge extends StatefulWidget {
  const _PulseBadge();

  @override
  State<_PulseBadge> createState() => _PulseBadgeState();
}

class _PulseBadgeState extends State<_PulseBadge> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final scale = 1.0 + _pulseController.value * 0.25;
        final opacity = 0.5 + _pulseController.value * 0.5;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Palette.cyberCyan.withValues(alpha: isDark ? 0.08 : 0.04),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Palette.cyberCyan.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: scale,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.cyberCyan,
                    boxShadow: [
                      BoxShadow(
                        color: Palette.cyberCyan.withValues(alpha: opacity * 0.6),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'AVAILABLE FOR COLLABORATION',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: isDark ? Palette.cyberCyan : Palette.cyberPurple,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
