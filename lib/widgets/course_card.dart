import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String topic;
  final bool isLocked;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.topic,
    this.isLocked = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.backgroundWhite,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppTheme.primaryCyan.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppTheme.primaryCyan.withValues(alpha: 0.3),
                ),
              ),
              child: Icon(
                isLocked ? Icons.lock : Icons.book,
                color: AppTheme.primaryCyan,
              ),
            ),
            SizedBox(width: 16.w,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDarkNavy,
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  Text(
                    'Learn basics of $topic',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppTheme.textDarkNavy,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppTheme.primaryCyan.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
