import '../../presentation/community/view/community_view.dart';
import '../../presentation/onboarding/onboarding_view.dart';
import '../../presentation/splash/view/splash_view.dart';
import '../../presentation/home/view/home_view.dart';
import '../../shared/widgets/HomeWrapper.dart';

class AppRoutes {
  // Route names
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const navbar = '/navbar';
  static const community = '/community'; // new route

  // Route mapping
  static final routes = {
    splash: (context) => const SplashView(),
    onboarding: (context) => const OnboardingView(),
    home: (context) => const EcologyHomeView(),
    navbar: (context) => const HomeWrapper(),
    community: (context) => const CommunityScreen(), // new screen
  };
}
