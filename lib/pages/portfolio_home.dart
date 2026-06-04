import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_content.dart';
import '../theme/app_theme.dart';
import '../widgets/background_glow_blobs.dart';
import '../widgets/certification_card.dart';
import '../widgets/fade_slide_in.dart';
import '../widgets/frosted_app_bar_bg.dart';
import '../widgets/gradient_divider.dart';
import '../widgets/hero_section.dart';
import '../widgets/infinite_skill_marquee.dart';
import '../widgets/nav_link.dart';
import '../widgets/project_card.dart';
import '../widgets/section_heading.dart';
import '../widgets/service_card.dart';
import '../widgets/skill_group_card.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Home page
// ──────────────────────────────────────────────────────────────────────────────

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.themeFlavor,
    required this.onToggleThemeFlavor,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final ThemeFlavor themeFlavor;
  final VoidCallback onToggleThemeFlavor;

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scroll = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _certificationsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  Future<void> _openUrl(String url) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      messenger?.showSnackBar(
        const SnackBar(
          content: Text(
            "Couldn't open that link. Try copying the URL instead.",
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
            "Couldn't open that link. Try again or use a different browser.",
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
    final wide = w >= 900;
    final pad = wide ? 80.0 : 22.0;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // ── Ambient Background Glow Blobs ──
          const Positioned.fill(
            child: BackgroundGlowBlobs(),
          ),

          // ── Scrollable Content ──
          Scrollbar(
            controller: _scroll,
            thumbVisibility: wide,
            interactive: true,
            child: CustomScrollView(
              controller: _scroll,
              slivers: [
                // ── App Bar ──
                SliverAppBar(
                  pinned: true,
                  toolbarHeight: 56,
                  flexibleSpace: ClipRect(
                    child: FrostedAppBarBg(isDark: widget.isDarkMode),
                  ),
                  title: Tooltip(
                    message: 'Back to top',
                    child: InkWell(
                      onTap: _scrollToTop,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 6,
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
                      color: scheme.outline.withValues(alpha: 0.35),
                    ),
                  ),
                  actions: [
                    if (wide) ...[
                      Tooltip(
                        message: 'Jump to About',
                        child: NavLink(
                          label: 'About',
                          onTap: () => _scrollTo(_aboutKey),
                        ),
                      ),
                      Tooltip(
                        message: 'Jump to Services',
                        child: NavLink(
                          label: 'Services',
                          onTap: () => _scrollTo(_servicesKey),
                        ),
                      ),
                      Tooltip(
                        message: 'Jump to Projects',
                        child: NavLink(
                          label: 'Projects',
                          onTap: () => _scrollTo(_projectsKey),
                        ),
                      ),
                      Tooltip(
                        message: 'Jump to Skills',
                        child: NavLink(
                          label: 'Skills',
                          onTap: () => _scrollTo(_skillsKey),
                        ),
                      ),
                      Tooltip(
                        message: 'Jump to Certifications',
                        child: NavLink(
                          label: 'Certifications',
                          onTap: () => _scrollTo(_certificationsKey),
                        ),
                      ),
                      Tooltip(
                        message: 'Jump to Contact',
                        child: NavLink(
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
                          if (v == 'services') _scrollTo(_servicesKey);
                          if (v == 'projects') _scrollTo(_projectsKey);
                          if (v == 'skills') _scrollTo(_skillsKey);
                          if (v == 'certifications') {
                            _scrollTo(_certificationsKey);
                          }
                          if (v == 'contact') _scrollTo(_contactKey);
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 'about', child: Text('About')),
                          PopupMenuItem(
                              value: 'services', child: Text('Services')),
                          PopupMenuItem(
                              value: 'projects', child: Text('Projects')),
                          PopupMenuItem(value: 'skills', child: Text('Skills')),
                          PopupMenuItem(
                            value: 'certifications',
                            child: Text('Certifications'),
                          ),
                          PopupMenuItem(
                              value: 'contact', child: Text('Contact')),
                        ],
                      ),
                    // Theme Flavor Switcher Button
                    Semantics(
                      label: 'Switch visual theme design style',
                      button: true,
                      child: IconButton(
                        tooltip: widget.themeFlavor == ThemeFlavor.cyberpunk
                            ? 'Switch to Jade Pebble theme'
                            : 'Switch to Cyberpunk theme',
                        onPressed: widget.onToggleThemeFlavor,
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, anim) => RotationTransition(
                            turns: Tween(begin: 0.75, end: 1.0).animate(anim),
                            child: FadeTransition(opacity: anim, child: child),
                          ),
                          child: Icon(
                            widget.themeFlavor == ThemeFlavor.cyberpunk
                                ? Icons.eco_rounded
                                : Icons.hub_rounded,
                            key: ValueKey(widget.themeFlavor),
                            color: scheme.primary,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: widget.isDarkMode
                          ? 'Switch to light mode'
                          : 'Switch to dark mode',
                      onPressed: widget.onToggleTheme,
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, anim) => RotationTransition(
                          turns: Tween(begin: 0.75, end: 1.0).animate(anim),
                          child: FadeTransition(opacity: anim, child: child),
                        ),
                        child: Icon(
                          widget.isDarkMode
                              ? Icons.light_mode_rounded
                              : Icons.dark_mode_rounded,
                          key: ValueKey(widget.isDarkMode),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),

                // ── Page Body ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      pad,
                      40,
                      pad,
                      64 + bottomInset,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            // ═════════════════════════════════════════════════
                            // HERO -- Profile Photo + Intro
                            // ═════════════════════════════════════════════════
                            FadeSlideIn(
                              direction: SlideDirection.up,
                              delay: const Duration(milliseconds: 100),
                              child: HeroSection(
                                wide: wide,
                                textTheme: t,
                                scheme: scheme,
                                onSeeProjects: () => _scrollTo(_projectsKey),
                                onHireMe: () => _scrollTo(_contactKey),
                                onOpenUrl: _openUrl,
                              ),
                            ),

                            const SizedBox(height: 56),

                            // ── Gradient divider ──
                            FadeSlideIn(
                              delay: const Duration(milliseconds: 250),
                              child: GradientDivider(scheme: scheme),
                            ),

                            const SizedBox(height: 48),

                            // ═════════════════════════════════════════════════
                            // ABOUT
                            // ═════════════════════════════════════════════════
                            FadeSlideIn(
                              direction: SlideDirection.left,
                              delay: const Duration(milliseconds: 100),
                              child: SectionHeading(
                                key: _aboutKey,
                                text: PortfolioContent.aboutTitle,
                              ),
                            ),
                            const SizedBox(height: 16),
                            FadeSlideIn(
                              direction: SlideDirection.up,
                              delay: const Duration(milliseconds: 200),
                              child: SelectableText(
                                PortfolioContent.aboutBody,
                                style: t.bodyLarge,
                              ),
                            ),

                            const SizedBox(height: 64),

                            // ═════════════════════════════════════════════════
                            // SERVICES
                            // ═════════════════════════════════════════════════
                            FadeSlideIn(
                              direction: SlideDirection.left,
                              delay: const Duration(milliseconds: 100),
                              child: SectionHeading(
                                key: _servicesKey,
                                text: PortfolioContent.servicesTitle,
                              ),
                            ),
                            const SizedBox(height: 24),
                            FadeSlideIn(
                              direction: SlideDirection.up,
                              delay: const Duration(milliseconds: 200),
                              child: wide
                                  ? IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: PortfolioContent.services
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          final isLast = entry.key ==
                                              PortfolioContent.services.length -
                                                  1;
                                          return Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: isLast ? 0 : 16),
                                              child: ServiceCard(
                                                service: entry.value,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  : Column(
                                      children: PortfolioContent.services
                                          .map((s) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 16),
                                                child: ServiceCard(service: s),
                                              ))
                                          .toList(),
                                    ),
                            ),

                            const SizedBox(height: 64),
                          ],
                    ),
                  ),
                ),
                // ═════════════════════════════════════════════════
                // CAROUSEL (Full Width, Modern Edge-to-Edge)
                // ═════════════════════════════════════════════════
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: FadeSlideIn(
                      direction: SlideDirection.up,
                      delay: const Duration(milliseconds: 300),
                      child: const InfiniteSkillsSection(),
                    ),
                  ),
                ),

                // ── Bottom Page Body ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      pad,
                      40,
                      pad,
                      64 + bottomInset,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            // ═════════════════════════════════════════════════
                            // PROJECTS
                            // ═════════════════════════════════════════════════
                            FadeSlideIn(
                              direction: SlideDirection.left,
                              delay: const Duration(milliseconds: 100),
                              child: SectionHeading(
                                key: _projectsKey,
                                text: PortfolioContent.projectsTitle,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ...PortfolioContent.projects
                                .asMap()
                                .entries
                                .map((entry) {
                              return FadeSlideIn(
                                direction: entry.key.isEven
                                    ? SlideDirection.left
                                    : SlideDirection.right,
                                delay: Duration(
                                    milliseconds: 100 + entry.key * 120),
                                child: ProjectCard(
                                  project: entry.value,
                                  onOpen: _openUrl,
                                  titleStyle: t.titleMedium!,
                                  mutedStyle: t.bodyMedium!,
                                ),
                              );
                            }),

                            const SizedBox(height: 56),

                            // ═════════════════════════════════════════════════
                            // SKILLS
                            // ═════════════════════════════════════════════════
                            FadeSlideIn(
                              direction: SlideDirection.left,
                              delay: const Duration(milliseconds: 100),
                              child: SectionHeading(
                                key: _skillsKey,
                                text: PortfolioContent.skillsTitle,
                              ),
                            ),
                            const SizedBox(height: 32),
                            ...PortfolioContent.skills
                                .asMap()
                                .entries
                                .map((entry) {
                              return FadeSlideIn(
                                direction: SlideDirection.up,
                                delay: Duration(
                                    milliseconds: 100 + entry.key * 100),
                                child: SkillGroupCard(skillGroup: entry.value),
                              );
                            }),

                            const SizedBox(height: 56),

                            // ═════════════════════════════════════════════════
                            // CERTIFICATIONS
                            // ═════════════════════════════════════════════════
                            FadeSlideIn(
                              direction: SlideDirection.left,
                              delay: const Duration(milliseconds: 100),
                              child: SectionHeading(
                                key: _certificationsKey,
                                text: PortfolioContent.certificationsTitle,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ...(() {
                              final certs = PortfolioContent.certifications;
                              if (wide) {
                                // 2-column grid on wide screens
                                final rows = <Widget>[];
                                for (int i = 0; i < certs.length; i += 2) {
                                  final left = certs[i];
                                  final right = i + 1 < certs.length ? certs[i + 1] : null;
                                  rows.add(
                                    FadeSlideIn(
                                      direction: SlideDirection.up,
                                      delay: Duration(milliseconds: 100 + (i ~/ 2) * 120),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: CertificationCard(
                                              certification: left,
                                              mutedStyle: t.bodyMedium!,
                                              titleStyle: t.titleSmall!,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: right != null
                                                ? CertificationCard(
                                                    certification: right,
                                                    mutedStyle: t.bodyMedium!,
                                                    titleStyle: t.titleSmall!,
                                                  )
                                                : const SizedBox.shrink(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return rows;
                              } else {
                                return certs.asMap().entries.map((entry) {
                                  return FadeSlideIn(
                                    direction: SlideDirection.up,
                                    delay: Duration(milliseconds: 100 + entry.key * 120),
                                    child: CertificationCard(
                                      certification: entry.value,
                                      mutedStyle: t.bodyMedium!,
                                      titleStyle: t.titleSmall!,
                                    ),
                                  );
                                }).toList();
                              }
                            })(),

                            const SizedBox(height: 56),

                            // ═════════════════════════════════════════════════
                            // CTA SECTION
                            // ═════════════════════════════════════════════════
                            FadeSlideIn(
                              direction: SlideDirection.up,
                              delay: const Duration(milliseconds: 100),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                                  child: Container(
                                    padding: const EdgeInsets.all(32),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          scheme.primary.withValues(alpha: 0.15),
                                          scheme.secondary.withValues(alpha: 0.03),
                                          scheme.tertiary.withValues(alpha: 0.15),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: scheme.primary.withValues(alpha: 0.25),
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: scheme.primary.withValues(alpha: 0.15),
                                          blurRadius: 20,
                                          offset: const Offset(-2, 2),
                                        ),
                                        BoxShadow(
                                          color: scheme.secondary.withValues(alpha: 0.15),
                                          blurRadius: 20,
                                          offset: const Offset(2, -2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ready to bring your app idea to life?',
                                          style: t.headlineSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            foreground: Paint()
                                              ..shader = LinearGradient(
                                                colors: [scheme.primary, scheme.secondary],
                                              ).createShader(
                                                const Rect.fromLTWH(0, 0, 300, 30),
                                              ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          'Let\'s work together to build something amazing with Flutter and Firebase.',
                                          style: t.bodyLarge?.copyWith(
                                            color: isDark ? Colors.white70 : Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [scheme.primary, scheme.secondary],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: scheme.primary.withValues(alpha: 0.3),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: FilledButton.icon(
                                            onPressed: () => _scrollTo(_contactKey),
                                            icon: const Icon(Icons.send_rounded, size: 18, color: Colors.white),
                                            label: const Text(
                                              'Hire me',
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                            style: FilledButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                              minimumSize: const Size(44, 48),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 64),

                            // ═════════════════════════════════════════════════
                            // CONTACT
                            // ═════════════════════════════════════════════════
                            FadeSlideIn(
                              direction: SlideDirection.left,
                              delay: const Duration(milliseconds: 100),
                              child: SectionHeading(
                                key: _contactKey,
                                text: PortfolioContent.contactTitle,
                              ),
                            ),
                            const SizedBox(height: 16),
                            FadeSlideIn(
                              direction: SlideDirection.up,
                              delay: const Duration(milliseconds: 200),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText(
                                    PortfolioContent.contactBlurb,
                                    style: t.bodyLarge,
                                  ),
                                  const SizedBox(height: 14),
                                  SelectableText(
                                    PortfolioContent.email,
                                    style: t.labelLarge?.copyWith(
                                      color: isDark ? scheme.secondary : scheme.primary,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationColor: (isDark ? scheme.secondary : scheme.primary)
                                          .withValues(alpha: 0.4),
                                    ),
                                  ),
                                  const SizedBox(height: 22),
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      // ── Email ──
                                      Tooltip(
                                        message: 'Open your mail app',
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [scheme.primary, scheme.secondary],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: scheme.primary.withValues(alpha: 0.25),
                                                blurRadius: 8,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: FilledButton.icon(
                                            onPressed: () => _openUrl(
                                              'mailto:${PortfolioContent.email}',
                                            ),
                                            icon: const Icon(Icons.mail_outline_rounded, size: 16, color: Colors.white),
                                            label: const Text(
                                              'Email',
                                              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 13),
                                            ),
                                            style: FilledButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // ── Copy email ──
                                      Tooltip(
                                        message: 'Copy address to clipboard',
                                        child: OutlinedButton.icon(
                                          onPressed: _copyEmail,
                                          icon: Icon(
                                            Icons.copy_rounded,
                                            size: 16,
                                            color: isDark ? Colors.white60 : Colors.black54,
                                          ),
                                          label: Text(
                                            'Copy email',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              color: isDark ? Colors.white70 : Colors.black87,
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                              color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.15),
                                              width: 1,
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ),
                                      // ── Phone ──
                                      Tooltip(
                                        message: 'Call or text',
                                        child: OutlinedButton.icon(
                                          onPressed: () => _openUrl('tel:${PortfolioContent.phone}'),
                                          icon: Icon(
                                            Icons.phone_rounded,
                                            size: 16,
                                            color: isDark ? Colors.white60 : Colors.black54,
                                          ),
                                          label: Text(
                                            PortfolioContent.phone,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              color: isDark ? Colors.white70 : Colors.black87,
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                              color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.15),
                                              width: 1,
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ),
                                      // ── GitHub ──
                                      Tooltip(
                                        message: 'View GitHub profile',
                                        child: OutlinedButton.icon(
                                          onPressed: () => _openUrl(PortfolioContent.githubUrl),
                                          icon: Icon(
                                            Icons.code_rounded,
                                            size: 16,
                                            color: isDark ? Colors.white60 : Colors.black54,
                                          ),
                                          label: Text(
                                            'GitHub',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              color: isDark ? Colors.white70 : Colors.black87,
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                              color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.15),
                                              width: 1,
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ),
                                      // ── LinkedIn ──
                                      Tooltip(
                                        message: 'Connect on LinkedIn',
                                        child: OutlinedButton.icon(
                                          onPressed: () => _openUrl(PortfolioContent.linkedInUrl),
                                          icon: Icon(
                                            Icons.work_outline_rounded,
                                            size: 16,
                                            color: isDark ? Colors.white60 : Colors.black54,
                                          ),
                                          label: Text(
                                            'LinkedIn',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              color: isDark ? Colors.white70 : Colors.black87,
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                              color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.15),
                                              width: 1,
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 64),

                            // ── Footer ──
                            FadeSlideIn(
                              direction: SlideDirection.up,
                              delay: const Duration(milliseconds: 100),
                              child: Center(
                                child: Text(
                                  '© ${DateTime.now().year} ${PortfolioContent.name}',
                                  style: t.bodyMedium?.copyWith(fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
