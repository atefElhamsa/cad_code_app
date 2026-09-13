import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String status; // Pending, Submitted, Reviewed
  final VoidCallback onUpload;

  const TaskTile({
    super.key,
    required this.title,
    required this.status,
    required this.onUpload,
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'submitted':
        return Colors.blue;
      case 'reviewed':
        return const Color(0xFF4CAF50); // Green
      case 'pending':
        return const Color(0xFFF57C00); // Orange
      default:
        return AppTheme.primaryCyan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Box
          Container(
            width: 52.w,
            height: 52.h,
            decoration: BoxDecoration(
              color: Color(0xFFFDF7E6),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.assignment_rounded,
                color: Color(0xFFB8860B),
                size: 24,
              ),
            ),
          ),
          SizedBox(width: 16.w,),
          // Texts and Badge
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16.sp,
                    color: AppTheme.textDarkNavy,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 8.h,),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: _getStatusColor(),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w,),
                      Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Action Button or Status Icon
          if (status.toLowerCase() == 'pending')
            IconButton(
              icon: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryCyan.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.cloud_upload_rounded,
                  color: AppTheme.primaryCyan,
                  size: 22,
                ),
              ),
              onPressed: onUpload,
              splashRadius: 24,
            )
          else if (status.toLowerCase() == 'reviewed')
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF4CAF50),
                size: 28,
              ),
            )
          else if (status.toLowerCase() == 'submitted')
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.hourglass_bottom_rounded,
                color: Colors.blue,
                size: 28,
              ),
            ),
        ],
      ),
    );
  }
}
