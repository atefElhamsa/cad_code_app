import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';

class SplashOrbs extends StatelessWidget {
  const SplashOrbs({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -40, left: -40,
          child: Container(
            width: 140, height: 140,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryGoldLight),
          ).animate().scale(duration: 1000.ms, curve: Curves.easeOut).fadeIn(duration: 1000.ms),
        ),
        Positioned(
          top: 100, left: 50,
          child: Container(
            width: 20, height: 20,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryGoldDark),
          ).animate().scale(delay: 400.ms, duration: 600.ms, curve: Curves.easeOutBack),
        ),
        Positioned(
          bottom: -50, right: -30,
          child: Container(
            width: 160, height: 160,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryGoldDark),
          ).animate().scale(duration: 1000.ms, curve: Curves.easeOut).fadeIn(duration: 1000.ms),
        ),
        Positioned(
          bottom: 120, right: 80,
          child: Container(
            width: 25, height: 25,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryGoldLight),
          ).animate().scale(delay: 500.ms, duration: 600.ms, curve: Curves.easeOutBack),
        ),
      ],
    );
  }
}
