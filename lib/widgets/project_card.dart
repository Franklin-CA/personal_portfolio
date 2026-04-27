import 'package:flutter/material.dart';

import '../data/portfolio_content.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Project card -- with hover elevation and modern aesthetics
// ──────────────────────────────────────────────────────────────────────────────

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

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
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
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered
                    ? scheme.primary.withValues(alpha: 0.5)
                    : scheme.outline.withValues(alpha: 0.2),
                width: _isHovered ? 2 : 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: scheme.primary.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.project.title, style: widget.titleStyle),
                      if (widget.project.isFeatured) ...[
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.primary.withValues(alpha: 0.1),
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
                            color: scheme.primary.withValues(alpha: 0.1),
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
                            onPressed: () =>
                                widget.onOpen(widget.project.liveUrl!),
                            icon: const Icon(Icons.launch_rounded, size: 16),
                            label: const Text('Live site'),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      if (widget.project.repoUrl != null)
                        Tooltip(
                          message: 'View source code',
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                widget.onOpen(widget.project.repoUrl!),
                            icon: const Icon(Icons.code_rounded, size: 16),
                            label: const Text('Source'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
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
    );
  }
}
