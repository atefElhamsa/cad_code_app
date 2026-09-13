import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class CourseBanner extends StatelessWidget {
  final String title;
  final List<String> outcomes;
  final double progress;
  final String level;

  const CourseBanner({
    super.key,
    required this.title,
    required this.outcomes,
    this.progress = 0.0,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppTheme.primaryCyan,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppTheme.primaryCyan),
                ),
                child: Text(
                  level,
                  style: TextStyle(
                    color: AppTheme.primaryCyan,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h,),
          ...outcomes.map(
            (o) => Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppTheme.primaryCyan,
                    size: 16,
                  ),
                  SizedBox(width: 8.w,),
                  Text(o, style: TextStyle(color: AppTheme.textDarkNavy)),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h,),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppTheme.backgroundLight,
            valueColor: const AlwaysStoppedAnimation(AppTheme.primaryCyan),
          ),
        ],
      ),
    );
  }
}
