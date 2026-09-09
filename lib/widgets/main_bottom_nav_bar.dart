import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';
import 'bottom_nav_item.dart';

class MainBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainBottomNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppTheme.backgroundWhite,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: AppTheme.primaryGoldLight.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final tabWidth = constraints.maxWidth / 3;
                final currentIndex = navigationShell.currentIndex;
                double alignX = 0.0;
                if (currentIndex == 2) {
                  alignX = -1.0;
                } else if (currentIndex == 1) {
                  alignX = 0.0;
                } else if (currentIndex == 0) {
                  alignX = 1.0;
                }

                return SizedBox(
                  height: 60,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeOutCubic,
                        alignment: Alignment(alignX, 0),
                        child: SizedBox(
                          width: tabWidth,
                          height: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGoldLight.withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: AppTheme.primaryGoldLight.withValues(
                                  alpha: 0.4,
                                ),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          BottomNavItem(
                            navigationShell: navigationShell,
                            icon: Icons.settings_rounded,
                            label: 'Settings',
                            targetIndex: 2,
                          ),
                          BottomNavItem(
                            navigationShell: navigationShell,
                            icon: Icons.laptop_mac_rounded,
                            label: 'Courses',
                            targetIndex: 1,
                          ),
                          BottomNavItem(
                            navigationShell: navigationShell,
                            icon: Icons.home_rounded,
                            label: 'Home',
                            targetIndex: 0,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
