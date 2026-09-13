import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'profile_progress_row.dart';
import '../core/theme/app_theme.dart';

class ProfileStatsCard extends StatelessWidget {
  final Map<String, dynamic> course;

  const ProfileStatsCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final stats = course['stats'] as Map<String, double>;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.backgroundDarkNavyLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileProgressRow(
            label: 'Session',
            percentage: stats['Session']!,
            color: AppTheme.primaryCyan,
          ),
          ProfileProgressRow(
            label: 'Behavior',
            percentage: stats['Behavior']!,
            color: Colors.blueGrey,
          ),
          ProfileProgressRow(
            label: 'Sharing',
            percentage: stats['Sharing']!,
            color: Colors.blue,
          ),
          ProfileProgressRow(
            label: 'Assignment',
            percentage: stats['Assignment']!,
            color: Colors.orange,
          ),
          ProfileProgressRow(
            label: 'Focus',
            percentage: stats['Focus']!,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
