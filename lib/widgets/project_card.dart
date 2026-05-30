import 'dart:ui';
import 'package:flutter/material.dart';
import '../data/portfolio_content.dart';

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
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      scheme.primary.withValues(alpha: _glowAnimation.value * 0.4),
                      scheme.primary.withValues(alpha: _glowAnimation.value * 0.1),
                      scheme.primary.withValues(alpha: _glowAnimation.value * 0.4),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: scheme.primary.withValues(alpha: _glowAnimation.value * 0.3),
                      blurRadius: _isHovered ? 40 : 20,
                      spreadRadius: _isHovered ? 6 : 0,
                      offset: Offset(0, _isHovered ? 10 : 5),
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
                          color: scheme.surface.withValues(alpha: 0.55),
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
                              Row(
                                children: [
                                  Text(widget.project.title, style: widget.titleStyle.copyWith(
                                    foreground: Paint()
                                      ..shader = LinearGradient(
                                        colors: [
                                          scheme.primary,
                                          scheme.primary.withValues(alpha: 0.6),
                                          scheme.primary,
                                        ],
                                      ).createShader(
                                        const Rect.fromLTWH(0, 0, 200, 40),
                                      ),
                                  )),
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
                                            scheme.primary.withValues(alpha: 0.25),
                                            scheme.primary.withValues(alpha: 0.08),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: scheme.primary.withValues(alpha: 0.3),
                                        ),
                                      ),
                                      child: Text(
                                        'Featured',
                                        style: widget.mutedStyle.copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: scheme.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              if (widget.project.tags.isNotEmpty) ...[
                                const SizedBox(height: 12),
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
                                            scheme.primary.withValues(alpha: 0.2),
                                            scheme.primary.withValues(alpha: 0.08),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: scheme.primary.withValues(alpha: 0.2),
                                        ),
                                      ),
                                      child: Text(
                                        tag,
                                        style: widget.mutedStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: scheme.primary,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                              const SizedBox(height: 16),
                              SelectableText(
                                widget.project.description,
                                style: widget.mutedStyle.copyWith(height: 1.5),
                              ),
                              const SizedBox(height: 24),
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  if (widget.project.liveUrl != null)
                                    Tooltip(
                                      message: 'Opens in your browser',
                                      child: FilledButton.icon(
                                        onPressed: () => widget.onOpen(widget.project.liveUrl!),
                                        icon: const Icon(Icons.launch_rounded, size: 16),
                                        label: const Text('Live site'),
                                        style: FilledButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        ),
                                      ),
                                    ),
                                  if (widget.project.apkUrl != null)
                                    Tooltip(
                                      message: 'Download APK',
                                      child: FilledButton.icon(
                                        onPressed: () => widget.onOpen(widget.project.apkUrl!),
                                        icon: const Icon(Icons.download_rounded, size: 16),
                                        label: const Text('Download APK'),
                                        style: FilledButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
