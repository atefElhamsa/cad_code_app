import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class EditProfileSourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const EditProfileSourceOption({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppTheme.primaryCyan.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppTheme.primaryCyan.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryCyan, size: 32),
            SizedBox(height: 8.h,),
            Text(
              label,
              style: TextStyle(
                color: AppTheme.textDarkNavy,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
