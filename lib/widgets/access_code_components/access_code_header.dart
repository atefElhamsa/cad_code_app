import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AccessCodeHeader extends StatelessWidget {
  const AccessCodeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Premium Lock Icon
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.backgroundDarkNavy,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.lock_outline_rounded,
            color: AppTheme.primaryGoldLight,
            size: 36,
          ),
        ),
        SizedBox(height: 24.h,),

        // Title
        Text(
          'Enter Access Code',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
            color: AppTheme.textDarkNavy,
            fontFamily: 'Inter',
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 12.h,),

        // Subtitle
        Text(
          "If you've enrolled offline at our course center,\nplease enter the access code you were given.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.textDarkNavy.withValues(alpha: 0.6),
            fontSize: 14.sp,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
