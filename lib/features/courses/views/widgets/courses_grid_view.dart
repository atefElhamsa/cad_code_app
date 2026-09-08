import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:cad_code_academy/core/theme/app_theme.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/courses_cubit/courses_cubit.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/courses_cubit/courses_state.dart';
import 'package:cad_code_academy/widgets/course_card_grid.dart';

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
                padding: const EdgeInsets.only(bottom: 24),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundDarkNavy.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(16),
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
                return const Center(child: Text('No courses available.'));
              }
              return RefreshIndicator(
                onRefresh: () => context.read<CoursesCubit>().fetchCourses(),
                color: AppTheme.primaryGoldDark,
                backgroundColor: AppTheme.backgroundLight,
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 24),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
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
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
