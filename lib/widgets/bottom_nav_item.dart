import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';
import '../features/courses/presentation/viewmodels/courses_cubit/courses_cubit.dart';
import '../features/courses/presentation/viewmodels/enrolled_courses_cubit/enrolled_courses_cubit.dart';

class BottomNavItem extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final IconData icon;
  final String label;
  final int targetIndex;

  const BottomNavItem({
    super.key,
    required this.navigationShell,
    required this.icon,
    required this.label,
    required this.targetIndex,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = navigationShell.currentIndex == targetIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (targetIndex != -1) {
            navigationShell.goBranch(
              targetIndex,
              initialLocation: targetIndex == navigationShell.currentIndex,
            );
            if (context.mounted) {
              context.read<CoursesCubit>().fetchCourses();
              context.read<EnrolledCoursesCubit>().fetchEnrolledCourses();
            }
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: isActive ? 28 : 26,
                  color: isActive
                      ? AppTheme.primaryGoldDark
                      : Colors.grey.shade400,
                ),
                if (isActive) ...[
                  SizedBox(width: 6.w,),
                  Text(
                    label,
                    style: TextStyle(
                      color: AppTheme.primaryGoldDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      letterSpacing: 0.3,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
