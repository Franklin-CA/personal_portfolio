import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/portfolio_content.dart';

void main() {
  runApp(const PortfolioApp());
}

/// Restrained palette — reads closer to a hand-set personal site than a template.
class _Palette {
  _Palette._();

  static const Color lightBg = Color(0xFFF2F1EE);
  static const Color lightSurface = Color(0xFFFBFAF8);
  static const Color lightInk = Color(0xFF161615);
  static const Color lightMuted = Color(0xFF5E5C57);
  static const Color lightRule = Color(0xFFD4D1CA);
  static const Color accent = Color(0xFF2A4A6B);

  static const Color darkBg = Color(0xFF121211);
  static const Color darkSurface = Color(0xFF1C1C1A);
  static const Color darkInk = Color(0xFFECEBE7);
  static const Color darkMuted = Color(0xFFA8A6A0);
  static const Color darkRule = Color(0xFF3A3936);
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  static ThemeData _light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _Palette.lightBg,
      colorScheme: ColorScheme.light(
        surface: _Palette.lightSurface,
        onSurface: _Palette.lightInk,
        primary: _Palette.accent,
        onPrimary: Colors.white,
        onSurfaceVariant: _Palette.lightMuted,
        outline: _Palette.lightRule,
        outlineVariant: _Palette.lightRule,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: _Palette.lightBg,
        foregroundColor: _Palette.lightInk,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: _Palette.lightInk,
          letterSpacing: 0.15,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: _Palette.lightRule,
        thickness: 1,
        space: 1,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w600,
          height: 1.15,
          letterSpacing: -0.6,
          color: _Palette.lightInk,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.3,
          letterSpacing: -0.2,
          color: _Palette.lightInk,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          height: 1.35,
          letterSpacing: -0.15,
          color: _Palette.lightInk,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.55,
          letterSpacing: 0.01,
          color: _Palette.lightMuted,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.5,
          letterSpacing: 0.01,
          color: _Palette.lightMuted,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.02,
          color: _Palette.lightInk,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          minimumSize: const Size(48, 44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          minimumSize: const Size(48, 44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static ThemeData _dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _Palette.darkBg,
      colorScheme: ColorScheme.dark(
        surface: _Palette.darkSurface,
        onSurface: _Palette.darkInk,
        primary: const Color(0xFF8BA9C9),
        onPrimary: _Palette.darkBg,
        onSurfaceVariant: _Palette.darkMuted,
        outline: _Palette.darkRule,
        outlineVariant: _Palette.darkRule,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: _Palette.darkBg,
        foregroundColor: _Palette.darkInk,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: _Palette.darkInk,
          letterSpacing: 0.15,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: _Palette.darkRule,
        thickness: 1,
        space: 1,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w600,
          height: 1.15,
          letterSpacing: -0.6,
          color: _Palette.darkInk,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.3,
          letterSpacing: -0.2,
          color: _Palette.darkInk,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          height: 1.35,
          letterSpacing: -0.15,
          color: _Palette.darkInk,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.55,
          letterSpacing: 0.01,
          color: _Palette.darkMuted,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.5,
          letterSpacing: 0.01,
          color: _Palette.darkMuted,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.02,
          color: _Palette.darkInk,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          minimumSize: const Size(48, 44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          minimumSize: const Size(48, 44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${PortfolioContent.name} · ${PortfolioContent.headline}',
      debugShowCheckedModeBanner: false,
      theme: _light(),
      darkTheme: _dark(),
      themeMode: ThemeMode.system,
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scroll = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _certificationsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  Future<void> _openUrl(String url) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      messenger?.showSnackBar(
        const SnackBar(
          content: Text(
            'Couldn’t open that link. Try copying the URL instead.',
          ),
        ),
      );
      return;
    }
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      messenger?.showSnackBar(
        const SnackBar(
          content: Text(
            'Couldn’t open that link. Try again or use a different browser.',
          ),
        ),
      );
    }
  }

  Future<void> _copyEmail() async {
    await Clipboard.setData(ClipboardData(text: PortfolioContent.email));
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Email copied to clipboard')));
  }

  void _scrollToTop() {
    if (!_scroll.hasClients) return;
    _scroll.animateTo(
      0,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final wide = w >= 880;
    const maxW = 680.0;
    final pad = wide ? 40.0 : 22.0;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      body: Scrollbar(
        controller: _scroll,
        thumbVisibility: wide,
        interactive: true,
        child: CustomScrollView(
          controller: _scroll,
          slivers: [
            SliverAppBar(
              pinned: true,
              toolbarHeight: 52,
              title: Tooltip(
                message: 'Back to top',
                child: InkWell(
                  onTap: _scrollToTop,
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    child: Text(
                      PortfolioContent.name,
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Divider(
                  height: 1,
                  color: scheme.outline.withValues(alpha: 0.55),
                ),
              ),
              actions: [
                if (wide) ...[
                  Tooltip(
                    message: 'Jump to About',
                    child: _SimpleNavLink(
                      label: 'About',
                      onTap: () => _scrollTo(_aboutKey),
                    ),
                  ),
                  Tooltip(
                    message: 'Jump to Projects',
                    child: _SimpleNavLink(
                      label: 'Projects',
                      onTap: () => _scrollTo(_projectsKey),
                    ),
                  ),
                  Tooltip(
                    message: 'Jump to Certifications',
                    child: _SimpleNavLink(
                      label: 'Certifications',
                      onTap: () => _scrollTo(_certificationsKey),
                    ),
                  ),
                  Tooltip(
                    message: 'Jump to Contact',
                    child: _SimpleNavLink(
                      label: 'Contact',
                      onTap: () => _scrollTo(_contactKey),
                    ),
                  ),
                  const SizedBox(width: 12),
                ] else
                  PopupMenuButton<String>(
                    tooltip: 'Sections',
                    onSelected: (v) {
                      if (v == 'about') _scrollTo(_aboutKey);
                      if (v == 'projects') _scrollTo(_projectsKey);
                      if (v == 'certifications') {
                        _scrollTo(_certificationsKey);
                      }
                      if (v == 'contact') _scrollTo(_contactKey);
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'about', child: Text('About')),
                      PopupMenuItem(value: 'projects', child: Text('Projects')),
                      PopupMenuItem(
                        value: 'certifications',
                        child: Text('Certifications'),
                      ),
                      PopupMenuItem(value: 'contact', child: Text('Contact')),
                    ],
                  ),
              ],
            ),
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxW),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      pad,
                      36,
                      pad,
                      64 + bottomInset,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi — I’m ${PortfolioContent.name.split(' ').first}.',
                          style: t.headlineMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          PortfolioContent.headline,
                          style: t.titleLarge?.copyWith(color: scheme.primary),
                        ),
                        const SizedBox(height: 20),
                        SelectableText(
                          PortfolioContent.tagline,
                          style: t.bodyLarge,
                        ),
                        const SizedBox(height: 28),
                        Tooltip(
                          message: 'Scroll to the projects list',
                          child: FilledButton(
                            onPressed: () => _scrollTo(_projectsKey),
                            child: const Text('See projects'),
                          ),
                        ),
                        const SizedBox(height: 48),
                        Divider(color: scheme.outline.withValues(alpha: 0.45)),
                        const SizedBox(height: 40),
                        _SectionHeading(
                          key: _aboutKey,
                          text: PortfolioContent.aboutTitle,
                        ),
                        const SizedBox(height: 14),
                        SelectableText(
                          PortfolioContent.aboutBody,
                          style: t.bodyLarge,
                        ),
                        const SizedBox(height: 44),
                        _SectionHeading(
                          key: _projectsKey,
                          text: PortfolioContent.projectsTitle,
                        ),
                        const SizedBox(height: 20),
                        ...PortfolioContent.projects.map(
                          (p) => _ProjectBlock(
                            project: p,
                            onOpen: _openUrl,
                            mutedStyle: t.bodyMedium!,
                            titleStyle: t.titleMedium!,
                          ),
                        ),
                        const SizedBox(height: 44),
                        _SectionHeading(
                          key: _certificationsKey,
                          text: PortfolioContent.certificationsTitle,
                        ),
                        const SizedBox(height: 20),
                        ...PortfolioContent.certifications.map(
                          (c) => _CertificationBlock(
                            certification: c,
                            mutedStyle: t.bodyMedium!,
                            titleStyle: t.titleMedium!,
                          ),
                        ),
                        const SizedBox(height: 44),
                        _SectionHeading(
                          key: _contactKey,
                          text: PortfolioContent.contactTitle,
                        ),
                        const SizedBox(height: 14),
                        SelectableText(
                          PortfolioContent.contactBlurb,
                          style: t.bodyLarge,
                        ),
                        const SizedBox(height: 12),
                        SelectableText(
                          PortfolioContent.email,
                          style: t.labelLarge?.copyWith(
                            color: scheme.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: scheme.primary.withValues(
                              alpha: 0.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Tooltip(
                              message: 'Open your mail app',
                              child: FilledButton.icon(
                                onPressed: () => _openUrl(
                                  'mailto:${PortfolioContent.email}',
                                ),
                                icon: const Icon(Icons.mail_outline, size: 18),
                                label: const Text('Email'),
                              ),
                            ),
                            Tooltip(
                              message: 'Copy address to clipboard',
                              child: OutlinedButton.icon(
                                onPressed: _copyEmail,
                                icon: const Icon(Icons.copy_rounded, size: 18),
                                label: const Text('Copy email'),
                              ),
                            ),
                            if (PortfolioContent.githubUrl != null)
                              OutlinedButton(
                                onPressed: () =>
                                    _openUrl(PortfolioContent.githubUrl!),
                                child: const Text('GitHub'),
                              ),
                            if (PortfolioContent.linkedInUrl != null)
                              OutlinedButton(
                                onPressed: () =>
                                    _openUrl(PortfolioContent.linkedInUrl!),
                                child: const Text('LinkedIn'),
                              ),
                          ],
                        ),
                        const SizedBox(height: 56),
                        Text(
                          '© ${DateTime.now().year} ${PortfolioContent.name}',
                          style: t.bodyMedium?.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimpleNavLink extends StatefulWidget {
  const _SimpleNavLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_SimpleNavLink> createState() => _SimpleNavLinkState();
}

class _SimpleNavLinkState extends State<_SimpleNavLink> {
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            minimumSize: const Size(44, 44),
            tapTargetSize: MaterialTapTargetSize.padded,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decoration: _hover
                  ? TextDecoration.underline
                  : TextDecoration.none,
              decorationThickness: 1.2,
              decorationColor: scheme.onSurface.withValues(alpha: 0.45),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;
    return Semantics(
      header: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: t.titleLarge),
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 2,
            color: scheme.primary.withValues(alpha: 0.85),
          ),
        ],
      ),
    );
  }
}

class _CertificationBlock extends StatelessWidget {
  const _CertificationBlock({
    required this.certification,
    required this.titleStyle,
    required this.mutedStyle,
  });

  final Certification certification;
  final TextStyle titleStyle;
  final TextStyle mutedStyle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final meta = [
      certification.issuer,
      certification.issuedDateLabel,
      certification.location,
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border.all(color: scheme.outline.withValues(alpha: 0.65)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(certification.title, style: titleStyle),
              const SizedBox(height: 6),
              Text(
                certification.credentialType,
                style: mutedStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(meta, style: mutedStyle.copyWith(fontSize: 13)),
              const SizedBox(height: 12),
              SelectableText(certification.description, style: mutedStyle),
              if (certification.imageAsset != null) ...[
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    certification.imageAsset!,
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
                              style: mutedStyle,
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
    );
  }
}

class _ProjectBlock extends StatelessWidget {
  const _ProjectBlock({
    required this.project,
    required this.onOpen,
    required this.titleStyle,
    required this.mutedStyle,
  });

  final Project project;
  final Future<void> Function(String url) onOpen;
  final TextStyle titleStyle;
  final TextStyle mutedStyle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tagLine = project.tags.join(' · ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border.all(color: scheme.outline.withValues(alpha: 0.65)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(project.title, style: titleStyle),
              if (tagLine.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(tagLine, style: mutedStyle.copyWith(fontSize: 13)),
              ],
              const SizedBox(height: 12),
              SelectableText(project.description, style: mutedStyle),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  if (project.liveUrl != null)
                    Tooltip(
                      message: 'Opens in your browser',
                      child: TextButton(
                        onPressed: () => onOpen(project.liveUrl!),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          minimumSize: const Size(48, 44),
                          tapTargetSize: MaterialTapTargetSize.padded,
                          foregroundColor: scheme.primary,
                        ),
                        child: const Text('Live site →'),
                      ),
                    ),
                  if (project.repoUrl != null)
                    Tooltip(
                      message: 'View source code',
                      child: TextButton(
                        onPressed: () => onOpen(project.repoUrl!),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          minimumSize: const Size(48, 44),
                          tapTargetSize: MaterialTapTargetSize.padded,
                        ),
                        child: const Text('Source'),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
