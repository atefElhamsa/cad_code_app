import 'package:cad_code_academy/core/theme/app_theme.dart';
import 'package:cad_code_academy/features/courses/domain/entities/course_entity.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/courses_cubit/courses_cubit.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/enrolled_courses_cubit/enrolled_courses_cubit.dart';
import 'package:cad_code_academy/widgets/course_card_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotEmptyCoursesHome extends StatelessWidget {
  const NotEmptyCoursesHome({
    super.key,
    required this.courses,
    required this.crossAxisCount,
  });

  final List<CourseEntity> courses;
  final int crossAxisCount;

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
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: 120),
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 8,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return CourseCardGrid(
                title: course.title,
                tag: course.tag,
                imageUrl: course.imageUrl,
                onTap: () => context.push(
                  '/course-detail',
                  extra: {
                    'id': course.id,
                    'title': course.title,
                    'imageUrl': course.imageUrl,
                  },
                ),
              )
              .animate()
              .fadeIn(delay: Duration(milliseconds: 400 + (index * 100)))
              .scale(begin: const Offset(0.9, 0.9));
        },
      ),
    );
  }
}
