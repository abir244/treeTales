import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../shared/widgets/animated_text_box.dart';
import '../../../shared/widgets/animation.dart';
import '../viewmodel/splash_viewmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashViewModel vm = SplashViewModel();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => vm.goToOnboarding(context),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.splash, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.3),
                    Colors.black.withOpacity(0.3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          '#TreeTales',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            letterSpacing: 2,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(flex: 2),

                    /// Animated Text Box
                    const AnimatedTextBox(texts: ['DISCOVER', 'NATURE', 'MAGIC']),

                    const Spacer(flex: 3),

                    /// Animated Title Blocks
                    Column(
                      children: const [
                        AnimatedTitle(text: 'TREE'),
                        SizedBox(height: 8),
                        AnimatedTitle(text: 'STORIES'),
                        SizedBox(height: 8),
                        AnimatedTitle(text: 'AWAIT'),
                      ],
                    ),

                    const Spacer(flex: 2),

                    /// Footer tagline
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'www.treetales.app',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(Icons.nature, color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
