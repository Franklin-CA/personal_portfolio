import 'dart:ui';
import 'package:flutter/material.dart';
import '../data/portfolio_content.dart';
import '../theme/palette.dart';

class SkillGroupCard extends StatefulWidget {
  const SkillGroupCard({
    super.key,
    required this.skillGroup,
  });

  final SkillGroup skillGroup;

  @override
  State<SkillGroupCard> createState() => _SkillGroupCardState();
}

class _SkillGroupCardState extends State<SkillGroupCard> with TickerProviderStateMixin {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                    blurRadius: _isHovered ? 35 : 18,
                    spreadRadius: _isHovered ? 4 : -2,
                    offset: Offset(_isHovered ? -5 : -2, _isHovered ? 5 : 2),
                  ),
                  BoxShadow(
                    color: Palette.cyberCyan.withValues(
                      alpha: _glowAnimation.value * (isDark ? 0.35 : 0.18),
                    ),
                    blurRadius: _isHovered ? 35 : 18,
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
                                  gradient: const LinearGradient(
                                    colors: [Palette.cyberPurple, Palette.cyberCyan],
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
                                    ..shader = const LinearGradient(
                                      colors: [
                                        Palette.cyberPurple,
                                        Palette.cyberCyan,
                                        Palette.cyberPink,
                                      ],
                                    ).createShader(
                                      const Rect.fromLTWH(0, 0, 200, 30),
                                    ),
                                  letterSpacing: 0.5,
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
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -2.5 : 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _isHovered
                  ? Palette.cyberPurple
                  : Palette.cyberPurple.withValues(alpha: 0.15),
              _isHovered
                  ? Palette.cyberCyan
                  : Palette.cyberCyan.withValues(alpha: 0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? Palette.cyberCyan
                : Palette.cyberPurple.withValues(alpha: 0.25),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Palette.cyberPurple.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: textTheme.bodySmall!.copyWith(
            color: _isHovered
                ? Colors.white
                : (isDark ? Palette.cyberCyan : Palette.cyberPurple),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
          child: Text(widget.skill),
        ),
      ),
    );
  }
}
