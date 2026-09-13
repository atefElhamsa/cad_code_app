import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          top: -40.h,
          left: -40.w,
          child:
              Container(
                    width: 140.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryGoldLight,
                    ),
                  )
                  .animate()
                  .scale(duration: 1000.ms, curve: Curves.easeOut)
                  .fadeIn(duration: 1000.ms),
        ),
        Positioned(
          top: 100.h,
          left: 50.w,
          child:
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryGoldDark,
                ),
              ).animate().scale(
                delay: 400.ms,
                duration: 600.ms,
                curve: Curves.easeOutBack,
              ),
        ),
        Positioned(
          bottom: -50.h,
          right: -30.w,
          child:
              Container(
                    width: 160.w,
                    height: 160.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryGoldDark,
                    ),
                  )
                  .animate()
                  .scale(duration: 1000.ms, curve: Curves.easeOut)
                  .fadeIn(duration: 1000.ms),
        ),
        Positioned(
          bottom: 120.h,
          right: 80.w,
          child:
              Container(
                width: 25.w,
                height: 25.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryGoldLight,
                ),
              ).animate().scale(
                delay: 500.ms,
                duration: 600.ms,
                curve: Curves.easeOutBack,
              ),
        ),
      ],
    );
  }
}
