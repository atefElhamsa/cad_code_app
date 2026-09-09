import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../widgets/main_bottom_nav_bar.dart';

class MainLayoutView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainLayoutView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: MainBottomNavBar(navigationShell: navigationShell),
    );
  }
}
