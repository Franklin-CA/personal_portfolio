import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../data/portfolio_content.dart';

class InfiniteSkillsSection extends StatelessWidget {
  const InfiniteSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (PortfolioContent.skills.isEmpty) return const SizedBox.shrink();

    // Flatten all skills into a single list and remove any redundancy/duplicates
    final Set<String> uniqueSkills = {};
    for (var group in PortfolioContent.skills) {
      uniqueSkills.addAll(group.skills);
    }
    
    final allSkills = uniqueSkills.toList();
    if (allSkills.isEmpty) return const SizedBox.shrink();
  
    // ShaderMask adds a premium fade-out effect on the left and right edges of the screen
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surface,
            Colors.transparent,
          ],
          stops: const [0.0, 0.05, 0.95, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: _MarqueeRow(
        skills: allSkills,
        // standard scrolling natively pulls content from the right to the left
        reverse: false,
      ),
    );
  }
}

class _MarqueeRow extends StatefulWidget {
  final List<String> skills;
  final bool reverse;

  const _MarqueeRow({required this.skills, required this.reverse});

  @override
  State<_MarqueeRow> createState() => _MarqueeRowState();
}

class _MarqueeRowState extends State<_MarqueeRow>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late Ticker _ticker;
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    // Start somewhere far so that "reverse" scrolling doesn't hit 0 immediately.
    final initialOffset = widget.reverse ? 100000.0 : 0.0;
    _scrollPosition = initialOffset;
    _scrollController = ScrollController(initialScrollOffset: initialOffset);

    _ticker = createTicker((elapsed) {
      if (!_scrollController.hasClients) {
        if (mounted) setState(() {});
        return;
      }
      
      const double speed = 1.2;
      _scrollPosition += widget.reverse ? -speed : speed;

      if (_scrollPosition <= 0 && widget.reverse) {
        _scrollPosition = 100000.0;
      }

      _scrollController.jumpTo(_scrollPosition);
    });
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_ticker.isActive) {
        _ticker.start();
      }
    });
  }

  @override
  void didUpdateWidget(_MarqueeRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_ticker.isActive) {
      _ticker.start();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final extendedSkills = [
      ...widget.skills,
      ...widget.skills,
      ...widget.skills,
      ...widget.skills,
    ];

    return SizedBox(
      height: 70,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final skillIndex = index % extendedSkills.length;
          final skill = extendedSkills[skillIndex];
          
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Center(
              child: _GlassSkillChip(skill: skill),
            ),
          );
        },
      ),
    );
  }
}

class _GlassSkillChip extends StatefulWidget {
  final String skill;

  const _GlassSkillChip({required this.skill});

  @override
  State<_GlassSkillChip> createState() => _GlassSkillChipState();
}

class _GlassSkillChipState extends State<_GlassSkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _isHovered
                  ? scheme.primary
                  : scheme.primary.withValues(alpha: 0.12),
              _isHovered
                  ? scheme.secondary
                  : scheme.secondary.withValues(alpha: 0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: _isHovered
                ? scheme.secondary
                : scheme.primary.withValues(alpha: 0.22),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: scheme.primary.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: textTheme.titleSmall!.copyWith(
            color: _isHovered
                ? Colors.white
                : (isDark ? scheme.secondary : scheme.primary),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          child: Text(widget.skill),
        ),
      ),
    );
  }
}
