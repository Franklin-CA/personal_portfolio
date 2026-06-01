import 'dart:ui';
import 'package:flutter/material.dart';
import '../data/portfolio_content.dart';
import '../theme/palette.dart';

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
              final isDark = Theme.of(context).brightness == Brightness.dark;

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
                      blurRadius: _isHovered ? 40 : 20,
                      spreadRadius: _isHovered ? 4 : -2,
                      offset: Offset(_isHovered ? -5 : -2, _isHovered ? 5 : 2),
                    ),
                    BoxShadow(
                      color: Palette.cyberCyan.withValues(
                        alpha: _glowAnimation.value * (isDark ? 0.35 : 0.18),
                      ),
                      blurRadius: _isHovered ? 40 : 20,
                      spreadRadius: _isHovered ? 4 : -2,
                      offset: Offset(_isHovered ? 5 : 2, _isHovered ? -5 : -2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.5),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: scheme.surface.withValues(alpha: isDark ? 0.65 : 0.78),
                          borderRadius: BorderRadius.circular(18.5),
                          border: Border.all(
                            color: Palette.cyberPurple.withValues(alpha: 0.15),
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
                                      Palette.cyberCyan.withValues(alpha: 0.22),
                                      Palette.cyberCyan.withValues(alpha: 0.04),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Palette.cyberCyan.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Icon(
                                  _getIcon(),
                                  size: 32,
                                  color: Palette.cyberCyan,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                widget.service.title,
                                style: t.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = const LinearGradient(
                                      colors: [
                                        Palette.cyberPurple,
                                        Palette.cyberCyan,
                                        Palette.cyberPink,
                                      ],
                                    ).createShader(
                                      const Rect.fromLTWH(0, 0, 160, 40),
                                    ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                widget.service.description,
                                style: t.bodyMedium?.copyWith(
                                  color: isDark ? Colors.white70 : Colors.black87,
                                  height: 1.5,
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
