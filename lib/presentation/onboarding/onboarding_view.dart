import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'onboarding_viewmodel.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _contentController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeIn),
    );

    _contentController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _animateContent() {
    _contentController.reset();
    _contentController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(onboardingViewModelProvider);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        children: [
          /// Background pages
          PageView.builder(
            controller: _pageController,
            itemCount: vm.pages.length,
            onPageChanged: (index) {
              vm.updatePage(index);
              _animateContent();
            },
            itemBuilder: (context, index) {
              final page = vm.pages[index];

              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(page.image, fit: BoxFit.cover),

                  /// Stronger readability overlay:
                  /// - a tiny top dark veil
                  /// - a stronger bottom veil for text contrast
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.25),
                          Colors.transparent,
                          Colors.black.withOpacity(0.68),
                        ],
                        stops: const [0.0, 0.45, 1.0],
                      ),
                    ),
                  ),

                  /// Content + glass panel
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                      child: Column(
                        children: [
                          /// Top label row (optional)
                          Row(
                            children: [
                              _GlassChip(
                                text: 'TREE TALES',
                                icon: Icons.eco_outlined,
                              ),
                              const Spacer(),
                              _SkipButton(
                                onTap: () => Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          /// Animated Glass Content
                          SlideTransition(
                            position: _slideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: _GlassCard(
                                width: double.infinity,
                                blur: 18,
                                opacity: 0.20,
                                borderOpacity: 0.28,
                                padding: const EdgeInsets.all(18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Page indicator (inside card, clean)
                                    Row(
                                      children: List.generate(
                                        vm.pages.length,
                                            (i) => AnimatedContainer(
                                          duration:
                                          const Duration(milliseconds: 250),
                                          margin:
                                          const EdgeInsets.only(right: 6),
                                          width: vm.currentIndex == i ? 18 : 7,
                                          height: 7,
                                          decoration: BoxDecoration(
                                            color: vm.currentIndex == i
                                                ? Colors.white.withOpacity(0.95)
                                                : Colors.white.withOpacity(0.35),
                                            borderRadius:
                                            BorderRadius.circular(99),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 14),

                                    /// Title (more visible + shadow)
                                    Text(
                                      page.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        height: 1.1,
                                        fontWeight: FontWeight.w800,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10,
                                            color: Colors.black54,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    /// Description (brighter)
                                    Text(
                                      page.description,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.90),
                                        fontSize: 16,
                                        height: 1.55,
                                        fontWeight: FontWeight.w500,
                                        shadows: const [
                                          Shadow(
                                            blurRadius: 8,
                                            color: Colors.black45,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    /// Facts in smaller glass row
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _MiniGlassFact(
                                            emoji: "🌳",
                                            text:
                                            "Trees absorb CO₂ and protect biodiversity.",
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: _MiniGlassFact(
                                            emoji: "🍃",
                                            text:
                                            "Forests stabilize climate & support ecosystems.",
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 18),

                                    /// CTA row
                                    Row(
                                      children: [
                                        /// Back (optional)
                                        if (vm.currentIndex > 0)
                                          _GhostGlassButton(
                                            onTap: () => _pageController.previousPage(
                                              duration: const Duration(milliseconds: 350),
                                              curve: Curves.easeInOut,
                                            ),
                                            text: "Back",
                                            icon: Icons.chevron_left,
                                          )
                                        else
                                          const SizedBox.shrink(),

                                        const Spacer(),

                                        /// Next / Get Started
                                        _PrimaryGlassButton(
                                          onTap: () {
                                            if (vm.isLastPage) {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                '/home',
                                              );
                                            } else {
                                              _pageController.nextPage(
                                                duration:
                                                const Duration(milliseconds: 400),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          },
                                          text: vm.isLastPage
                                              ? "Get Started"
                                              : "Continue",
                                          icon: vm.isLastPage
                                              ? Icons.check_circle_outline
                                              : Icons.chevron_right,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: size.height * 0.03),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// ----------------------------
/// Glass Building Blocks
/// ----------------------------

class _GlassCard extends StatelessWidget {
  final Widget child;
  final double width;
  final EdgeInsets padding;
  final double blur;
  final double opacity;
  final double borderOpacity;
  final BorderRadius borderRadius;

  const _GlassCard({
    required this.child,
    required this.width,
    required this.padding,
    this.blur = 18,
    this.opacity = 0.18,
    this.borderOpacity = 0.26,
    this.borderRadius = const BorderRadius.all(Radius.circular(22)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: borderRadius,
            border: Border.all(
              color: Colors.white.withOpacity(borderOpacity),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _GlassChip extends StatelessWidget {
  final String text;
  final IconData icon;

  const _GlassChip({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      width: 0,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      blur: 14,
      opacity: 0.16,
      borderOpacity: 0.22,
      borderRadius: BorderRadius.circular(99),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white.withOpacity(0.9)),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.92),
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              shadows: const [
                Shadow(
                  blurRadius: 6,
                  color: Colors.black38,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniGlassFact extends StatelessWidget {
  final String emoji;
  final String text;

  const _MiniGlassFact({required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      blur: 16,
      opacity: 0.14,
      borderOpacity: 0.18,
      borderRadius: BorderRadius.circular(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 13,
                height: 1.35,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PrimaryGlassButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData icon;

  const _PrimaryGlassButton({
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: _GlassCard(
        width: 0,
        blur: 16,
        opacity: 0.22,
        borderOpacity: 0.30,
        borderRadius: BorderRadius.circular(999),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(
                    blurRadius: 8,
                    color: Colors.black45,
                    offset: Offset(0, 2),
                  )
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(icon, size: 18, color: Colors.white.withOpacity(0.95)),
          ],
        ),
      ),
    );
  }
}

class _GhostGlassButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData icon;

  const _GhostGlassButton({
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: _GlassCard(
        width: 0,
        blur: 14,
        opacity: 0.12,
        borderOpacity: 0.18,
        borderRadius: BorderRadius.circular(999),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.white.withOpacity(0.85)),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(0.88),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SkipButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Text(
          "Skip",
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            shadows: const [
              Shadow(
                blurRadius: 8,
                color: Colors.black45,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}