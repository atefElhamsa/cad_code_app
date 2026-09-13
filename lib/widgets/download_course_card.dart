import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/theme/app_theme.dart';

class DownloadCourseCard extends StatelessWidget {
  final String topic;
  final String size;
  final int videoCount;
  final int index;

  const DownloadCourseCard({
    super.key,
    required this.topic,
    required this.size,
    required this.videoCount,
    required this.index,
  });

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
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildThumbnail(),
          SizedBox(width: 16.w,),
          _buildInfo(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete_outline_rounded,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    ).animate().fade(delay: (100 * index).ms).slideY(begin: 0.1);
  }

  Widget _buildThumbnail() {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: AppTheme.primaryCyan.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Icon(
          Icons.play_circle_fill_rounded,
          color: AppTheme.primaryCyan,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topic,
            style: TextStyle(
              color: AppTheme.textDarkNavy,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 8.h,),
          Text(
            '$size • $videoCount Videos',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.sp,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
