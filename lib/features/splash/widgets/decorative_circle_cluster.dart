import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_theme.dart';

class DecorativeCircleCluster extends StatelessWidget {
  final bool isTopLeft;

  const DecorativeCircleCluster({
    super.key,
    required this.isTopLeft,
  });

  @override
  Widget build(BuildContext context) {
    final scale = (context.shortestSide / 400.0).clamp(0.85, 1.55);
    const designSize = 220.0;
    const bigDiameter = 148.0;
    const smallDiameter = 22.0;
    const dotOffset = 128.0;

    final big = Container(
      width: bigDiameter,
      height: bigDiameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.25, -0.3),
          colors: isTopLeft
              ? const [
                  Color(0xFFE8C96A),
                  AppTheme.primaryGoldLight,
                  AppTheme.primaryGoldDark,
                ]
              : const [
                  AppTheme.primaryGoldLight,
                  AppTheme.primaryGoldDark,
                  Color(0xFF7A5A08),
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGoldLight.withValues(alpha: 0.38),
            blurRadius: 28,
            spreadRadius: 2,
          ),
        ],
      ),
    )
        .animate()
        .scale(duration: 900.ms, curve: Curves.easeOutCubic);

    final dot = Container(
      width: smallDiameter,
      height: smallDiameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: isTopLeft
              ? const [AppTheme.primaryGoldLight, AppTheme.primaryGoldDark]
              : const [Color(0xFFE8C96A), AppTheme.primaryGoldLight],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGoldDark.withValues(alpha: 0.45),
            blurRadius: 10,
          ),
        ],
      ),
    ).animate().scale(
          delay: isTopLeft ? 350.ms : 450.ms,
          duration: 550.ms,
          curve: Curves.easeOutBack,
        );

    return Transform.scale(
      scale: scale,
      alignment: isTopLeft ? Alignment.topLeft : Alignment.bottomRight,
      child: SizedBox(
        width: designSize,
        height: designSize,
        child: Stack(
          children: [
            if (isTopLeft) ...[
              Positioned(top: 0, left: 0, child: big),
              Positioned(top: dotOffset, left: dotOffset, child: dot),
            ] else ...[
              Positioned(bottom: 0, right: 0, child: big),
              Positioned(bottom: dotOffset, right: dotOffset, child: dot),
            ],
          ],
        ),
      ),
    );
  }
}
