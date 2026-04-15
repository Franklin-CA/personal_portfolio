import 'package:flutter/material.dart';

import '../data/portfolio_content.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Certification card
// ──────────────────────────────────────────────────────────────────────────────

class CertificationCard extends StatefulWidget {
  const CertificationCard({
    super.key,
    required this.certification,
    required this.titleStyle,
    required this.mutedStyle,
  });

  final Certification certification;
  final TextStyle titleStyle;
  final TextStyle mutedStyle;

  @override
  State<CertificationCard> createState() => _CertificationCardState();
}

class _CertificationCardState extends State<CertificationCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final meta = [
      widget.certification.issuer,
      widget.certification.issuedDateLabel,
      widget.certification.location,
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: scheme.surface,
            border: Border.all(
              color: _hover
                  ? scheme.primary.withValues(alpha: 0.5)
                  : scheme.outline.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _hover
                    ? scheme.primary.withValues(alpha: 0.10)
                    : Colors.black.withValues(alpha: 0.04),
                blurRadius: _hover ? 24 : 8,
                offset: Offset(0, _hover ? 8 : 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.certification.title, style: widget.titleStyle),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.certification.credentialType,
                    style: widget.mutedStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: scheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(meta,
                    style: widget.mutedStyle.copyWith(fontSize: 13)),
                const SizedBox(height: 14),
                SelectableText(widget.certification.description,
                    style: widget.mutedStyle),
                if (widget.certification.imageAsset != null) ...[
                  const SizedBox(height: 18),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.certification.imageAsset!,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                      errorBuilder: (context, error, stackTrace) {
                        return ColoredBox(
                          color: scheme.outline.withValues(alpha: 0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Center(
                              child: Text(
                                'Certificate image',
                                style: widget.mutedStyle,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
