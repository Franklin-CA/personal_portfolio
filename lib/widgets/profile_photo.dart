import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../data/portfolio_content.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Profile photo with animated glow ring
// ──────────────────────────────────────────────────────────────────────────────

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({super.key, required this.scheme});

  final ColorScheme scheme;

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto>
    with TickerProviderStateMixin {
  late final AnimationController _glowController;
  late final AnimationController _gsapController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotationAnimation;

  bool _isRedEyes = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _gsapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.2)
              .chain(CurveTween(curve: Curves.easeOutCubic)),
          weight: 5), // Pop out fast (250ms)
      TweenSequenceItem(
          tween: Tween(begin: 1.2, end: 1.35)
              .chain(CurveTween(curve: Curves.easeInOutSine)),
          weight: 90), // Slow eerie zoom into the viewer's eyes (4500ms)
      TweenSequenceItem(
          tween: Tween(begin: 1.35, end: 1.0)
              .chain(CurveTween(curve: Curves.elasticOut)),
          weight: 5), // Snap back fast (250ms)
    ]).animate(_gsapController);
  }

  @override
  void dispose() {
    _glowController.dispose();
    _gsapController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _handleTap() async {
    if (_isRedEyes) return;

    setState(() {
      _isRedEyes = true;
    });

    try {
      if (_audioPlayer.state == PlayerState.playing) {
        await _audioPlayer.stop();
      }
      await _audioPlayer.play(AssetSource('mangekyou_sharingan.mp3'));
    } catch (e) {
      debugPrint('Error playing sharingan sound: $e');
    }

    _gsapController.forward(from: 0.0).then((_) {
      if (mounted && _isRedEyes) {
        setState(() {
          _isRedEyes = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedBuilder(
          animation: Listenable.merge([_glowController, _gsapController]),
          builder: (context, child) {
            final glowOpacity = 0.25 + _glowController.value * 0.35;
            final primaryColor = widget.scheme.primary;
            final glowColor = _isRedEyes ? Colors.red : primaryColor;

            // Genjutsu distortions (only active when _gsapController is running and red eyes are on)
            final double genjutsuShake = _isRedEyes 
                ? math.sin(_gsapController.value * math.pi * 60) * 0.03 
                : 0.0;
            
            final double genjutsuPulse = _isRedEyes
                ? math.sin(_gsapController.value * math.pi * 10).abs()
                : 0.0;

            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: genjutsuShake,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withValues(alpha: glowOpacity),
                        blurRadius: 28 + _glowController.value * 12,
                        spreadRadius: 2,
                      ),
                      if (_isRedEyes)
                        BoxShadow(
                          color: Colors.red.withValues(alpha: 0.6 + (0.3 * genjutsuPulse)),
                          blurRadius: 50 + (20 * genjutsuPulse),
                          spreadRadius: 10 + (20 * genjutsuPulse),
                        ),
                    ],
                  ),
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _isRedEyes
                            ? Colors.red
                            : primaryColor.withValues(alpha: 0.6),
                        width: _isRedEyes ? 5 : 3,
                      ),
                    ),
                    child: ClipOval(
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 200),
                        crossFadeState: _isRedEyes
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        firstChild: Image.asset(
                          PortfolioContent.profileImageAsset,
                          width: 174,
                          height: 174,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Icon(
                            Icons.person,
                            size: 80,
                            color: widget.scheme.onSurfaceVariant,
                          ),
                        ),
                        secondChild: Image.asset(
                          PortfolioContent.profileImageRedEyesAsset,
                          width: 174,
                          height: 174,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.red,
                          ),
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
    );
  }
}
