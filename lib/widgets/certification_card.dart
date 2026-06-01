import 'dart:ui';
import 'package:flutter/material.dart';
import '../data/portfolio_content.dart';
import '../theme/palette.dart';

class CertificationCard extends StatefulWidget {
  const CertificationCard({
    super.key,
    required this.certification,
    required this.titleStyle,
    required this.mutedStyle,
  });

  final Certification certification;
  final TextStyle titleStyle;
  final TextStyle mutedStyle;

  @override
  State<CertificationCard> createState() => _CertificationCardState();
}

class _CertificationCardState extends State<CertificationCard> with TickerProviderStateMixin {
  bool _hover = false;
  late AnimationController _animationController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.2, end: 0.6).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final meta = [
      widget.certification.issuer,
      widget.certification.issuedDateLabel,
      widget.certification.location,
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
              final isDark = Theme.of(context).brightness == Brightness.dark;

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      Palette.cyberPurple.withValues(alpha: _glowAnimation.value * 0.5),
                      Palette.cyberCyan.withValues(alpha: _glowAnimation.value * 0.1),
                      Palette.cyberPink.withValues(alpha: _glowAnimation.value * 0.5),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Palette.cyberPurple.withValues(
                        alpha: _glowAnimation.value * (isDark ? 0.35 : 0.18),
                      ),
                      blurRadius: _hover ? 50 : 25,
                      spreadRadius: _hover ? 4 : -2,
                      offset: Offset(_hover ? -6 : -2, _hover ? 6 : 2),
                    ),
                    BoxShadow(
                      color: Palette.cyberCyan.withValues(
                        alpha: _glowAnimation.value * (isDark ? 0.35 : 0.18),
                      ),
                      blurRadius: _hover ? 50 : 25,
                      spreadRadius: _hover ? 4 : -2,
                      offset: Offset(_hover ? 6 : 2, _hover ? -6 : -2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22.5),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: scheme.surface.withValues(alpha: isDark ? 0.65 : 0.78),
                          borderRadius: BorderRadius.circular(22.5),
                          border: Border.all(
                            color: Palette.cyberPurple.withValues(alpha: 0.15),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                child: Text(
                                  widget.certification.title,
                                  style: widget.titleStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = const LinearGradient(
                                        colors: [
                                          Palette.cyberPurple,
                                          Palette.cyberCyan,
                                          Palette.cyberPink,
                                        ],
                                      ).createShader(
                                        const Rect.fromLTWH(0, 0, 240, 40),
                                      ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Palette.cyberPurple.withValues(alpha: 0.22),
                                      Palette.cyberPurple.withValues(alpha: 0.04),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(
                                    color: Palette.cyberPurple.withValues(alpha: 0.35),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  widget.certification.credentialType,
                                  style: widget.mutedStyle.copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? Palette.cyberCyan : Palette.cyberPurple,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                meta,
                                style: widget.mutedStyle.copyWith(
                                  fontSize: 13,
                                  color: isDark ? Colors.white70 : Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SelectableText(
                                widget.certification.description,
                                style: widget.mutedStyle.copyWith(
                                  fontSize: 12,
                                  height: 1.5,
                                  color: isDark ? Colors.white60 : Colors.black54,
                                ),
                              ),
                              if (widget.certification.imageAsset != null) ...[
                                const SizedBox(height: 12),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Palette.cyberCyan.withValues(alpha: 0.25),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Palette.cyberCyan.withValues(alpha: 0.15),
                                          blurRadius: 25,
                                          spreadRadius: 3,
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      widget.certification.imageAsset!,
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.topCenter,
                                      errorBuilder: (context, error, stackTrace) {
                                        return ColoredBox(
                                          color: scheme.outline.withValues(alpha: 0.2),
                                          child: Padding(
                                            padding: const EdgeInsets.all(24),
                                            child: Center(
                                              child: Text(
                                                'Certificate image',
                                                style: widget.mutedStyle,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}
