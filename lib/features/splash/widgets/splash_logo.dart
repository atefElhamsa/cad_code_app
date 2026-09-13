import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppTheme.primaryGoldLight, width: 4.w,),
          ),
          child: Center(
            child: ShaderMask(
              shaderCallback: (bounds) => AppTheme.goldGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                'C',
                style: TextStyle(
                  fontSize: 60.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        )
        .animate()
        .slideY(begin: -1.0, end: 0, duration: 800.ms, curve: Curves.bounceOut)
        .fadeIn(duration: 800.ms)
        .shimmer(delay: 1000.ms, duration: 1500.ms, color: Colors.white);
  }
}
