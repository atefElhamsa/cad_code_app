import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class CourseSelectorPill extends StatelessWidget {
  final Map<String, dynamic> course;
  final bool isSelected;
  final VoidCallback onTap;

  const CourseSelectorPill({
    super.key,
    required this.course,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        margin: EdgeInsets.only(right: 12),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryGoldLight
              : AppTheme.backgroundDarkNavyLight,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.white.withValues(alpha: 0.1),
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              course['icon'],
              color: isSelected ? AppTheme.textDarkNavy : course['color'],
              size: 20,
            ),
            SizedBox(width: 8.w,),
            Text(
              course['name'],
              style: TextStyle(
                color: isSelected ? AppTheme.textDarkNavy : Colors.white,
                fontWeight: FontWeight.w700,
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
