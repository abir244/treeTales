import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';


class SplashViewModel {
  void goToOnboarding(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
  }
}
