import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_theme.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final shortestSide = context.shortestSide;
    final logoSize = (shortestSide * 0.26).clamp(112.0, 176.0);
    final borderRadius = logoSize * 0.22;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: logoSize * 0.9,
          height: logoSize * 0.9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryGoldLight.withValues(alpha: 0.4),
                blurRadius: 48,
                spreadRadius: 4,
              ),
            ],
          ),
        )
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(
              begin: const Offset(0.92, 0.92),
              end: const Offset(1.08, 1.08),
              duration: 1600.ms,
              curve: Curves.easeInOut,
            ),
        Container(
          width: logoSize,
          height: logoSize,
          padding: EdgeInsets.all((logoSize * 0.02).clamp(2.2, 3.5)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: AppTheme.goldGradient,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryGoldDark.withValues(alpha: 0.4),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius - 3),
              color: AppTheme.backgroundDarkNavy,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(logoSize * 0.1),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'C',
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.primaryGoldLight,
                      fontFamily: 'Inter',
                      height: 1.0,
                    ),
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    )
        .animate()
        .scale(
          begin: const Offset(0.88, 0.88),
          end: const Offset(1, 1),
          duration: 800.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
