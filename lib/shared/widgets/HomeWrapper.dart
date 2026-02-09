import 'package:flutter/material.dart';
import '../../presentation/home/view/home_view.dart';
import '../../presentation/community/view/community_view.dart';
import '../../presentation/encyclopedia/view/encyclopedia_view.dart';
import '../../presentation/settings/view/settings_view.dart';
import 'common_navbar.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int _currentIndex = 0;

  // Pages for the bottom nav
  final List<Widget> _pages = [
    const EcologyHomeView(),           // Home
    const CommunityScreen(),             // Community
    // const EncyclopediaView(),          // Encyclopedia / Explore
    // const SettingsView(),              // Profile / Settings
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Show the current page
      body: _pages[_currentIndex],

      // Bottom navigation
      bottomNavigationBar: CommonNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
