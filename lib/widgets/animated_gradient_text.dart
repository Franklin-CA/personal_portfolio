import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/palette.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Animated gradient headline
// ──────────────────────────────────────────────────────────────────────────────

class AnimatedGradientText extends StatefulWidget {
  const AnimatedGradientText({
    super.key,
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle style;

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                scheme.primary,
                Palette.accentLight,
                scheme.primary,
              ],
              stops: [
                math.max(0, _ctrl.value - 0.3),
                _ctrl.value,
                math.min(1, _ctrl.value + 0.3),
              ],
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.style.copyWith(color: Colors.white),
          ),
        );
      },
    );
  }
}
