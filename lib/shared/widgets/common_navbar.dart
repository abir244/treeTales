import 'dart:ui';
import 'package:flutter/material.dart';

class CommonNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CommonNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double navHeight = size.height * 0.09; // 9% of screen height
    final double sideMargin = size.width * 0.06; // 6% of screen width
    final double bottomMargin = size.height * 0.03; // 3% bottom

    return Container(
      margin: EdgeInsets.fromLTRB(sideMargin, 0, sideMargin, bottomMargin),
      height: navHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(navHeight / 2), // rounded based on height
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(navHeight / 2),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  index: 0,
                  isActive: currentIndex == 0,
                  onTap: onTap,
                  navHeight: navHeight,
                ),
                _NavItem(
                  icon: Icons.nature_rounded,
                  label: 'Trees',
                  index: 1,
                  isActive: currentIndex == 1,
                  onTap: onTap,
                  navHeight: navHeight,
                ),
                _NavItem(
                  icon: Icons.explore_rounded,
                  label: 'Explore',
                  index: 2,
                  isActive: currentIndex == 2,
                  onTap: onTap,
                  navHeight: navHeight,
                ),
                _NavItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  index: 3,
                  isActive: currentIndex == 3,
                  onTap: onTap,
                  navHeight: navHeight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isActive;
  final Function(int) onTap;
  final double navHeight;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.isActive,
    required this.onTap,
    required this.navHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize = navHeight * 0.35; // icon scales with nav height
    final double paddingHorizontal = navHeight * 0.25;
    final double paddingVertical = navHeight * 0.2;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(navHeight / 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.greenAccent : Colors.white.withOpacity(0.5),
              size: iconSize,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isActive
                  ? Padding(
                padding: EdgeInsets.only(left: paddingHorizontal * 0.5),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: navHeight * 0.25, // text scales with nav height
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
