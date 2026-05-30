import 'dart:ui';
import 'package:flutter/material.dart';
import '../data/portfolio_content.dart';

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

class _CertificationCardState extends State<CertificationCard>
    with TickerProviderStateMixin {
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
      padding: const EdgeInsets.only(bottom: 24),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    scheme.primary.withValues(
                      alpha: _glowAnimation.value * 0.5,
                    ),
                    scheme.primary.withValues(
                      alpha: _glowAnimation.value * 0.1,
                    ),
                    scheme.primary.withValues(
                      alpha: _glowAnimation.value * 0.5,
                    ),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: scheme.primary.withValues(
                      alpha: _glowAnimation.value * 0.4,
                    ),
                    blurRadius: _hover ? 50 : 25,
                    spreadRadius: _hover ? 8 : 0,
                    offset: Offset(0, _hover ? 12 : 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: scheme.surface.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: scheme.primary.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              child: Text(
                                widget.certification.title,
                                style: widget.titleStyle.copyWith(
                                  foreground: Paint()
                                    ..shader =
                                        LinearGradient(
                                          colors: [
                                            scheme.primary,
                                            scheme.primary.withValues(
                                              alpha: 0.6,
                                            ),
                                            scheme.primary,
                                          ],
                                        ).createShader(
                                          const Rect.fromLTWH(0, 0, 200, 40),
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    scheme.primary.withValues(alpha: 0.25),
                                    scheme.primary.withValues(alpha: 0.08),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(
                                  color: scheme.primary.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                widget.certification.credentialType,
                                style: widget.mutedStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: scheme.primary,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              meta,
                              style: widget.mutedStyle.copyWith(fontSize: 13),
                            ),
                            const SizedBox(height: 16),
                            SelectableText(
                              widget.certification.description,
                              style: widget.mutedStyle,
                            ),
                            if (widget.certification.imageAsset != null) ...[
                              const SizedBox(height: 20),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: scheme.primary.withValues(
                                          alpha: 0.3,
                                        ),
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
                                        color: scheme.outline.withValues(
                                          alpha: 0.2,
                                        ),
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
