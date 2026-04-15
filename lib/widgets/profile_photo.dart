import 'package:flutter/material.dart';

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
    with SingleTickerProviderStateMixin {
  late final AnimationController _glow;

  @override
  void initState() {
    super.initState();
    _glow = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (context, child) {
        final glowOpacity = 0.25 + _glow.value * 0.35;
        return Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.scheme.primary.withValues(alpha: glowOpacity),
                blurRadius: 28 + _glow.value * 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.scheme.primary.withValues(alpha: 0.6),
            width: 3,
          ),
        ),
        child: ClipOval(
          child: Image.asset(
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
        ),
      ),
    );
  }
}
