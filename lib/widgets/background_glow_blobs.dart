import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/palette.dart';

/// A premium, performance-optimized background widget that slowly animates 
/// floating, glowing colored blobs behind a deep glass blur.
class BackgroundGlowBlobs extends StatefulWidget {
  const BackgroundGlowBlobs({super.key});

  @override
  State<BackgroundGlowBlobs> createState() => _BackgroundGlowBlobsState();
}

class _BackgroundGlowBlobsState extends State<BackgroundGlowBlobs>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value * 2 * math.pi;

        // Path of blob 1 (Purple - Top Left region)
        final x1 = size.width * 0.2 + math.sin(t) * 80;
        final y1 = size.height * 0.25 + math.cos(t) * 90;

        // Path of blob 2 (Cyan - Bottom Right region)
        final x2 = size.width * 0.8 + math.cos(t + math.pi / 2) * 120;
        final y2 = size.height * 0.65 + math.sin(t + math.pi / 2) * 80;

        // Path of blob 3 (Pink - Lower Center region)
        final x3 = size.width * 0.45 + math.sin(t * 1.5) * 60;
        final y3 = size.height * 0.85 + math.cos(t * 1.5) * 60;

        return Stack(
          children: [
            // Blob 1: Cyber Purple
            Positioned(
              left: x1 - 180,
              top: y1 - 180,
              child: Container(
                width: 360,
                height: 360,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.cyberPurple.withValues(
                    alpha: isDark ? 0.12 : 0.08,
                  ),
                ),
              ),
            ),
            // Blob 2: Cyber Cyan
            Positioned(
              left: x2 - 200,
              top: y2 - 200,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.cyberCyan.withValues(
                    alpha: isDark ? 0.10 : 0.06,
                  ),
                ),
              ),
            ),
            // Blob 3: Cyber Pink
            Positioned(
              left: x3 - 160,
              top: y3 - 160,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.cyberPink.withValues(
                    alpha: isDark ? 0.10 : 0.06,
                  ),
                ),
              ),
            ),
            // Glass backdrop blur filter to paint beautiful ambient light fields
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 110, sigmaY: 110),
                child: const SizedBox.shrink(),
              ),
            ),
          ],
        );
      },
    );
  }
}
