import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:cad_code_academy/core/theme/app_theme.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/courses_cubit/courses_cubit.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/enrolled_courses_cubit/enrolled_courses_cubit.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/courses_cubit/courses_state.dart';
import 'package:cad_code_academy/widgets/course_card_grid.dart';
import 'package:cad_code_academy/widgets/empty_state_widget.dart';

class CoursesGridView extends StatelessWidget {
  const CoursesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 800
            ? 4
            : constraints.maxWidth > 600
            ? 3
            : 2;
        return BlocBuilder<CoursesCubit, CoursesState>(
          builder: (context, state) {
            if (state is CoursesLoading) {
              return GridView.builder(
                padding: EdgeInsets.only(bottom: 120),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundDarkNavy.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppTheme.backgroundDarkNavy.withValues(
                              alpha: 0.05,
                            ),
                          ),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(
                        duration: 1200.ms,
                        color: AppTheme.backgroundDarkNavy.withValues(
                          alpha: 0.15,
                        ),
                        angle: 0.5,
                      );
                },
              );
            } else if (state is CoursesError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is CoursesLoaded) {
              final courses = state.courses;
              if (courses.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await context.read<CoursesCubit>().fetchCourses();
                    if (context.mounted) {
                      context
                          .read<EnrolledCoursesCubit>()
                          .fetchEnrolledCourses();
                    }
                  },
                  color: AppTheme.primaryGoldDark,
                  backgroundColor: AppTheme.backgroundLight,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    slivers: [
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyStateWidget(
                          icon: Icons.search_off_rounded,
                          title: 'No Courses Found',
                          subtitle: 'We are currently adding new courses.\n Please check back later.',
                        ),
                      ),
                    ],
                  ),
                );
              }
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
                        .fadeIn(
                          delay: Duration(milliseconds: 400 + (index * 100)),
                        )
                        .scale(begin: const Offset(0.9, 0.9));
                  },
                ),
              );
            }
            return SizedBox.shrink();
          },
        );
      },
    );
  }
}
