import 'dart:ui';
import 'package:flutter/material.dart';
import '../data/portfolio_content.dart';
import '../theme/palette.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.onOpen,
    required this.titleStyle,
    required this.mutedStyle,
  });

  final Project project;
  final Future<void> Function(String url) onOpen;
  final TextStyle titleStyle;
  final TextStyle mutedStyle;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with TickerProviderStateMixin {
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
      end: 1.02,
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

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: MouseRegion(
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
                      blurRadius: _isHovered ? 40 : 20,
                      spreadRadius: _isHovered ? 4 : -2,
                      offset: Offset(_isHovered ? -6 : -2, _isHovered ? 6 : 2),
                    ),
                    BoxShadow(
                      color: Palette.cyberCyan.withValues(
                        alpha: _glowAnimation.value * (isDark ? 0.35 : 0.18),
                      ),
                      blurRadius: _isHovered ? 40 : 20,
                      spreadRadius: _isHovered ? 4 : -2,
                      offset: Offset(_isHovered ? 6 : 2, _isHovered ? -6 : -2),
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
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.project.title,
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
                                  if (widget.project.isFeatured) ...[
                                    const SizedBox(width: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Palette.cyberPink.withValues(alpha: 0.22),
                                            Palette.cyberPink.withValues(alpha: 0.05),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Palette.cyberPink.withValues(alpha: 0.35),
                                        ),
                                      ),
                                      child: Text(
                                        'Featured',
                                        style: widget.mutedStyle.copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Palette.cyberPink,
                                          letterSpacing: 0.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              if (widget.project.tags.isNotEmpty) ...[
                                const SizedBox(height: 14),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: widget.project.tags.map((tag) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Palette.cyberCyan.withValues(alpha: 0.15),
                                            Palette.cyberCyan.withValues(alpha: 0.04),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Palette.cyberCyan.withValues(alpha: 0.25),
                                        ),
                                      ),
                                      child: Text(
                                        tag,
                                        style: widget.mutedStyle.copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: isDark ? Palette.cyberCyan : Palette.cyberPurple,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                              const SizedBox(height: 18),
                              SelectableText(
                                widget.project.description,
                                style: widget.mutedStyle.copyWith(
                                  height: 1.6,
                                  color: isDark ? Colors.white70 : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  if (widget.project.liveUrl != null)
                                    Tooltip(
                                      message: 'Opens in your browser',
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [Palette.cyberPurple, Palette.cyberCyan],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Palette.cyberPurple.withValues(alpha: 0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: FilledButton.icon(
                                          onPressed: () => widget.onOpen(widget.project.liveUrl!),
                                          icon: const Icon(Icons.launch_rounded, size: 16),
                                          label: const Text(
                                            'Live site',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          style: FilledButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (widget.project.apkUrl != null)
                                    Tooltip(
                                      message: 'Download APK',
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [Palette.cyberPink, Palette.cyberPurple],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Palette.cyberPink.withValues(alpha: 0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: FilledButton.icon(
                                          onPressed: () => widget.onOpen(widget.project.apkUrl!),
                                          icon: const Icon(Icons.download_rounded, size: 16),
                                          label: const Text(
                                            'Download APK',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          style: FilledButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
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
      ),
    );
  }
}
