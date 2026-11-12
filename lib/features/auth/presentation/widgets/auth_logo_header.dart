import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_theme.dart';

class AuthLogoHeader extends StatelessWidget {
  final double? logoSize;

  const AuthLogoHeader({
    super.key,
    this.logoSize,
  });

  @override
  Widget build(BuildContext context) {
    final shortest = context.shortestSide;
    final effectiveLogoSize = logoSize ?? (shortest * 0.14).clamp(64.0, 110.0);
    final borderWidth = (effectiveLogoSize * 0.038).clamp(2.5, 4.0);
    final borderRadius = effectiveLogoSize * 0.2;
    final titleFontSize = (effectiveLogoSize * 0.26).clamp(18.0, 26.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: effectiveLogoSize,
          height: effectiveLogoSize,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: AppTheme.primaryGoldLight,
                  width: borderWidth,
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
                child: Padding(
                  padding: EdgeInsets.all(effectiveLogoSize * 0.1),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          AppTheme.goldGradient.createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      child: const Text(
                        'C',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontFamily: 'Inter',
                          height: 1.0,
                        ),
                        textHeightBehavior: TextHeightBehavior(
                          applyHeightToFirstAscent: false,
                          applyHeightToLastDescent: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: (effectiveLogoSize * 0.18).clamp(12.0, 16.0)),
        ShaderMask(
          shaderCallback: (bounds) => AppTheme.goldGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            'C&C Academy',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1.8,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    ).animate().slideY(
          begin: -0.2,
          end: 0,
          duration: 800.ms,
          curve: Curves.easeOut,
        );
  }
}
