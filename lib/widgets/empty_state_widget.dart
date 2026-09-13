import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with glowing pulsating background
            Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppTheme.primaryGoldLight.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGoldDark.withValues(alpha: 0.15),
                    blurRadius: 30,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 64,
                color: AppTheme.primaryGoldDark,
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 2.seconds, color: Colors.white.withValues(alpha: 0.5)),
            )
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scaleXY(
              begin: 1.0,
              end: 1.08,
              duration: 1.seconds,
              curve: Curves.easeInOutSine,
            ),

            SizedBox(height: 32.h,),
            
            // Title text with bouncy slide up
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.backgroundDarkNavy,
                fontSize: 22.sp,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.5, end: 0, duration: 600.ms, curve: Curves.easeOutBack),

            SizedBox(height: 12.h,),
            
            // Subtitle text with bouncy slide up
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textGray,
                fontSize: 15.sp,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: 150.ms)
            .slideY(begin: 0.5, end: 0, duration: 600.ms, curve: Curves.easeOutBack),
          ],
        ),
      ),
    );
  }
}
