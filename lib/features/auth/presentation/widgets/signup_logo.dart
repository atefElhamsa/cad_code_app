import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

class SignupLogo extends StatelessWidget {
  const SignupLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.primaryGoldLight,
                  width: 2.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGoldDark.withValues(alpha: 0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.goldGradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: const Text(
                    'C',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ShaderMask(
              shaderCallback: (bounds) => AppTheme.goldGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: const Text(
                'C&C Academy',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 800.ms)
        .slideY(begin: -0.2, end: 0, curve: Curves.easeOut);
  }
}
