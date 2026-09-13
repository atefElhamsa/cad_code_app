import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final double progress;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 4,
                backgroundColor: AppTheme.primaryCyan.withValues(alpha: 0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppTheme.primaryCyan,
                ),
              ),
            ),
            CircleAvatar(
              radius: 42,
              backgroundColor: AppTheme.backgroundLight,
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: TextStyle(
                  fontSize: 32.sp,
                  color: AppTheme.textDarkNavy,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h,),
        Text(
          name,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.textDarkNavy,
          ),
        ),
        SizedBox(height: 4.h,),
        Text(email, style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
      ],
    );
  }
}
