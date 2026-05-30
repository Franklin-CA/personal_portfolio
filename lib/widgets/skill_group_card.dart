import 'dart:ui';
import 'package:flutter/material.dart';
import '../data/portfolio_content.dart';

class SkillGroupCard extends StatefulWidget {
  const SkillGroupCard({super.key, required this.skillGroup});

  final SkillGroup skillGroup;

  @override
  State<SkillGroupCard> createState() => _SkillGroupCardState();
}

class _SkillGroupCardState extends State<SkillGroupCard>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
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
    _glowController.dispose();
    super.dispose();
  }

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
                    blurRadius: _isHovered ? 35 : 18,
                    spreadRadius: _isHovered ? 5 : 0,
                    offset: Offset(0, _isHovered ? 8 : 4),
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
                      padding: const EdgeInsets.all(20),
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
                                  gradient: LinearGradient(
                                    colors: [
                                      scheme.primary,
                                      scheme.primary.withValues(alpha: 0.6),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 12),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 200),
                                style: textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
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
                                          const Rect.fromLTWH(0, 0, 150, 30),
                                        ),
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
                ),
              ),
            );
          },
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
          gradient: LinearGradient(
            colors: [
              _isHovered
                  ? scheme.primary
                  : scheme.primary.withValues(alpha: 0.2),
              _isHovered
                  ? scheme.primary.withValues(alpha: 0.8)
                  : scheme.primary.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? scheme.primary
                : scheme.primary.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: scheme.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
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
