import 'package:flutter/material.dart';

import '../data/portfolio_content.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Project card -- with hover elevation
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

class _ProjectCardState extends State<ProjectCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: scheme.surface,
            border: Border.all(
              color: _hover
                  ? scheme.primary.withValues(alpha: 0.5)
                  : scheme.outline.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _hover
                    ? scheme.primary.withValues(alpha: 0.10)
                    : Colors.black.withValues(alpha: 0.04),
                blurRadius: _hover ? 24 : 8,
                offset: Offset(0, _hover ? 8 : 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.project.title, style: widget.titleStyle),
                if (widget.project.tags.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: widget.project.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: scheme.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: scheme.primary.withValues(alpha: 0.15),
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
                const SizedBox(height: 14),
                SelectableText(widget.project.description,
                    style: widget.mutedStyle),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
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
                                horizontal: 18, vertical: 12),
                            minimumSize: const Size(44, 40),
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
                                horizontal: 18, vertical: 12),
                            minimumSize: const Size(44, 40),
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
    );
  }
}
