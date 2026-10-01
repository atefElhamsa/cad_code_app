import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppTheme.primaryGoldLight, width: 3.w,),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGoldDark.withValues(alpha: 0.3),
                    blurRadius: 20,
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
                  child: Text(
                    'C',
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h,),
            ShaderMask(
              shaderCallback: (bounds) => AppTheme.goldGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                'C&C Academy',
                style: TextStyle(
                  fontSize: 24.sp,
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
