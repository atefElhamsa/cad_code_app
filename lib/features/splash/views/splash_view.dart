import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/splash_orbs.dart';
import '../widgets/splash_logo.dart';
import '../widgets/animated_splash_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) context.go('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w900,
      fontFamily: 'Inter',
    );
    return Scaffold(
      backgroundColor: AppTheme.backgroundDarkNavy,
      body: Stack(
        children: [
          const SplashOrbs(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SplashLogo(),
                const SizedBox(height: 30),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    AnimatedSplashText(
                      text: 'C&C',
                      style: textStyle,
                      delayOffset: 800,
                    ),
                    SizedBox(width: 8),
                    AnimatedSplashText(
                      text: 'Academy',
                      style: textStyle,
                      delayOffset: 1010,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
