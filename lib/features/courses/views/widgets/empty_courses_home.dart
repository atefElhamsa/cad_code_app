import 'package:cad_code_academy/core/theme/app_theme.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/courses_cubit/courses_cubit.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/enrolled_courses_cubit/enrolled_courses_cubit.dart';
import 'package:cad_code_academy/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyCoursesHome extends StatelessWidget {
  const EmptyCoursesHome({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<CoursesCubit>().fetchCourses();
        if (context.mounted) {
          context.read<EnrolledCoursesCubit>().fetchEnrolledCourses();
        }
      },
      color: AppTheme.primaryGoldDark,
      backgroundColor: AppTheme.backgroundLight,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyStateWidget(
              icon: icon,
              title: title,
              subtitle: subtitle,
            ),
          ),
        ],
      ),
    );
  }
}
