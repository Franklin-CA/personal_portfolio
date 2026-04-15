import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_content.dart';
import '../widgets/certification_card.dart';
import '../widgets/fade_slide_in.dart';
import '../widgets/frosted_app_bar_bg.dart';
import '../widgets/gradient_divider.dart';
import '../widgets/hero_section.dart';
import '../widgets/nav_link.dart';
import '../widgets/project_card.dart';
import '../widgets/section_heading.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Home page
// ──────────────────────────────────────────────────────────────────────────────

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;

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
    final wide = w >= 880;
    const maxW = 760.0;
    final pad = wide ? 48.0 : 22.0;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
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
                        message: 'Jump to Projects',
                        child: NavLink(
                          label: 'Projects',
                          onTap: () => _scrollTo(_projectsKey),
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
                          if (v == 'projects') _scrollTo(_projectsKey);
                          if (v == 'certifications') {
                            _scrollTo(_certificationsKey);
                          }
                          if (v == 'contact') _scrollTo(_contactKey);
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 'about', child: Text('About')),
                          PopupMenuItem(
                              value: 'projects', child: Text('Projects')),
                          PopupMenuItem(
                            value: 'certifications',
                            child: Text('Certifications'),
                          ),
                          PopupMenuItem(
                              value: 'contact', child: Text('Contact')),
                        ],
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
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: maxW),
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

                            const SizedBox(height: 56),

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
                            ...PortfolioContent.certifications
                                .asMap()
                                .entries
                                .map((entry) {
                              return FadeSlideIn(
                                direction: SlideDirection.up,
                                delay: Duration(
                                    milliseconds: 100 + entry.key * 120),
                                child: CertificationCard(
                                  certification: entry.value,
                                  mutedStyle: t.bodyMedium!,
                                  titleStyle: t.titleMedium!,
                                ),
                              );
                            }),

                            const SizedBox(height: 56),

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
                                      color: scheme.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          scheme.primary.withValues(alpha: 0.4),
                                    ),
                                  ),
                                  const SizedBox(height: 22),
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Tooltip(
                                        message: 'Open your mail app',
                                        child: FilledButton.icon(
                                          onPressed: () => _openUrl(
                                            'mailto:${PortfolioContent.email}',
                                          ),
                                          icon: const Icon(Icons.mail_outline,
                                              size: 18),
                                          label: const Text('Email'),
                                        ),
                                      ),
                                      Tooltip(
                                        message: 'Copy address to clipboard',
                                        child: OutlinedButton.icon(
                                          onPressed: _copyEmail,
                                          icon: const Icon(
                                              Icons.copy_rounded,
                                              size: 18),
                                          label: const Text('Copy email'),
                                        ),
                                      ),
                                      if (PortfolioContent.githubUrl != null)
                                        OutlinedButton(
                                          onPressed: () => _openUrl(
                                              PortfolioContent.githubUrl!),
                                          child: const Text('GitHub'),
                                        ),
                                      if (PortfolioContent.linkedInUrl != null)
                                        OutlinedButton(
                                          onPressed: () => _openUrl(
                                              PortfolioContent.linkedInUrl!),
                                          child: const Text('LinkedIn'),
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
