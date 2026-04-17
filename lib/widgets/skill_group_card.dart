import 'package:flutter/material.dart';

import '../data/portfolio_content.dart';

class SkillGroupCard extends StatefulWidget {
  const SkillGroupCard({
    super.key,
    required this.skillGroup,
  });

  final SkillGroup skillGroup;

  @override
  State<SkillGroupCard> createState() => _SkillGroupCardState();
}

class _SkillGroupCardState extends State<SkillGroupCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? scheme.primary.withValues(alpha: 0.4)
                  : scheme.outline.withValues(alpha: 0.15),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? scheme.primary.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.02),
                blurRadius: _isHovered ? 20 : 8,
                offset: Offset(0, _isHovered ? 6 : 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Heading
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 18,
                    decoration: BoxDecoration(
                      color: scheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _isHovered ? scheme.primary : scheme.onSurface,
                      letterSpacing: 0.3,
                    ),
                    child: Text(widget.skillGroup.category),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Skills Wrap
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.skillGroup.skills.map((skill) {
                  return _SkillChip(skill: skill);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  const _SkillChip({required this.skill});
  final String skill;

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered
              ? scheme.primary
              : scheme.primary.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? scheme.primary
                : scheme.primary.withValues(alpha: 0.15),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: scheme.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: textTheme.bodySmall!.copyWith(
            color: _isHovered ? scheme.onPrimary : scheme.primary,
            fontWeight: FontWeight.w600,
          ),
          child: Text(widget.skill),
        ),
      ),
    );
  }
}
