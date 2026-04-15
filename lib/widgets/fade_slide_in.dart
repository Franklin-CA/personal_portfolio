import 'package:flutter/material.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Slide direction for the fade-in animation
// ──────────────────────────────────────────────────────────────────────────────

enum SlideDirection { left, right, up }

// ──────────────────────────────────────────────────────────────────────────────
// Scroll-triggered fade + slide animation widget
// ──────────────────────────────────────────────────────────────────────────────

class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.direction = SlideDirection.up,
  });

  final Widget child;
  final Duration delay;
  final SlideDirection direction;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);

    Offset begin;
    const slideOffset = 40.0;
    switch (widget.direction) {
      case SlideDirection.left:
        begin = Offset(-slideOffset, 0);
        break;
      case SlideDirection.right:
        begin = Offset(slideOffset, 0);
        break;
      case SlideDirection.up:
        begin = Offset(0, slideOffset);
        break;
    }
    _offset = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _maybeAnimate() {
    if (_triggered) return;
    _triggered = true;
    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _VisibilityDetector(
      onVisible: _maybeAnimate,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          return Opacity(
            opacity: _opacity.value,
            child: Transform.translate(
              offset: _offset.value,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Visibility detector (uses scroll position to trigger animations)
// ──────────────────────────────────────────────────────────────────────────────

/// Uses the scroll notification and position to detect when a widget
/// becomes visible on screen.
class _VisibilityDetector extends StatefulWidget {
  const _VisibilityDetector({required this.onVisible, required this.child});

  final VoidCallback onVisible;
  final Widget child;

  @override
  State<_VisibilityDetector> createState() => _VisibilityDetectorState();
}

class _VisibilityDetectorState extends State<_VisibilityDetector> {
  final GlobalKey _key = GlobalKey();
  bool _didTrigger = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_didTrigger) return;
    final ctx = _key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;
    final pos = box.localToGlobal(Offset.zero);
    final screenH = MediaQuery.sizeOf(context).height;
    // Trigger when the top of the widget is within 88% of screen height
    if (pos.dy < screenH * 0.88) {
      _didTrigger = true;
      widget.onVisible();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (_) {
        _check();
        return false;
      },
      child: KeyedSubtree(key: _key, child: widget.child),
    );
  }
}
