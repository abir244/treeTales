import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingViewModel extends ChangeNotifier {
  int currentIndex = 0;

  final pages = [
    OnboardingPage(
      image: 'assets/images/image1.png',
      title: 'Welcome',
      description: 'Discover the magic of nature',
    ),
    OnboardingPage(
      image: 'assets/images/image2.png',
      title: 'Explore',
      description: 'Learn about trees and forests',
    ),
    OnboardingPage(
      image: 'assets/images/image3.png',
      title: 'Join Us',
      description: 'Start your tree adventure today',
    ),
  ];

  void updatePage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      currentIndex++;
      notifyListeners();
    }
  }

  bool get isLastPage => currentIndex == pages.length - 1;
}

class OnboardingPage {
  final String image;
  final String title;
  final String description;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });
}

// Riverpod provider
final onboardingViewModelProvider =
ChangeNotifierProvider<OnboardingViewModel>((ref) {
  return OnboardingViewModel();
});
