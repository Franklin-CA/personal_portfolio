import 'package:flutter/material.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Nav link (top-bar navigation item)
// ──────────────────────────────────────────────────────────────────────────────

class NavLink extends StatefulWidget {
  const NavLink({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        cursor: SystemMouseCursors.click,
        child: TextButton(
          onPressed: widget.onTap,
          style: TextButton.styleFrom(
            foregroundColor: scheme.onSurface,
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            minimumSize: const Size(44, 44),
            tapTargetSize: MaterialTapTargetSize.padded,
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 14,
              fontWeight: _hover ? FontWeight.w700 : FontWeight.w500,
              color: _hover ? scheme.primary : scheme.onSurface,
              decoration:
                  _hover ? TextDecoration.underline : TextDecoration.none,
              decorationThickness: 2,
              decorationColor: scheme.primary.withValues(alpha: 0.6),
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
