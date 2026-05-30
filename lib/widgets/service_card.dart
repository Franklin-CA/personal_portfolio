import 'dart:ui';
import 'package:flutter/material.dart';
import '../data/portfolio_content.dart';

class ServiceCard extends StatefulWidget {
  const ServiceCard({super.key, required this.service});

  final Service service;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _glowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.2, end: 0.5).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  IconData _getIcon() {
    switch (widget.service.icon) {
      case 'smartphone':
        return Icons.smartphone_rounded;
      case 'cloud':
        return Icons.cloud_rounded;
      case 'dashboard':
        return Icons.dashboard_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    scheme.primary.withValues(
                      alpha: _glowAnimation.value * 0.4,
                    ),
                    scheme.primary.withValues(
                      alpha: _glowAnimation.value * 0.1,
                    ),
                    scheme.primary.withValues(
                      alpha: _glowAnimation.value * 0.4,
                    ),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: scheme.primary.withValues(
                      alpha: _glowAnimation.value * 0.3,
                    ),
                    blurRadius: _isHovered ? 40 : 20,
                    spreadRadius: _isHovered ? 6 : 0,
                    offset: Offset(0, _isHovered ? 10 : 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: scheme.surface.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(18),
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
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    scheme.primary.withValues(alpha: 0.25),
                                    scheme.primary.withValues(alpha: 0.08),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: scheme.primary.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Icon(
                                _getIcon(),
                                size: 32,
                                color: scheme.primary,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              widget.service.title,
                              style: t.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                foreground: Paint()
                                  ..shader =
                                      LinearGradient(
                                        colors: [
                                          scheme.primary,
                                          scheme.primary.withValues(alpha: 0.6),
                                          scheme.primary,
                                        ],
                                      ).createShader(
                                        const Rect.fromLTWH(0, 0, 150, 40),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.service.description,
                              style: t.bodyMedium?.copyWith(
                                color: scheme.onSurface.withValues(alpha: 0.8),
                              ),
                            ),
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
