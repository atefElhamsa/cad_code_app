import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/responsive/responsive.dart';
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
    final labelFontSize = ResponsiveUtils.fontSize(
      context,
      14,
      minScale: 1.0,
      maxScale: 1.15,
    );

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
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: TextStyle(
                      color: AppTheme.primaryGoldDark,
                      fontWeight: FontWeight.bold,
                      fontSize: labelFontSize,
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
