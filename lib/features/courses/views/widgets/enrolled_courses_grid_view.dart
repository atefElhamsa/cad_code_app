import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../widgets/course_card_grid.dart';
import '../../../../widgets/empty_state_widget.dart';
import '../../../../core/theme/app_theme.dart';
import '../../presentation/viewmodels/enrolled_courses_cubit/enrolled_courses_cubit.dart';
import '../../presentation/viewmodels/enrolled_courses_cubit/enrolled_courses_state.dart';

class EnrolledCoursesGridView extends StatelessWidget {
  const EnrolledCoursesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 800
            ? 4
            : constraints.maxWidth > 600
            ? 3
            : 2;

        return BlocBuilder<EnrolledCoursesCubit, EnrolledCoursesState>(
          builder: (context, state) {
            if (state is EnrolledCoursesLoading ||
                state is EnrolledCoursesInitial) {
              return GridView.builder(
                padding: const EdgeInsets.all(20),
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
                          borderRadius: BorderRadius.circular(24),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(
                        duration: 1200.ms,
                        color: AppTheme.backgroundDarkNavy.withValues(
                          alpha: 0.15,
                        ),
                      );
                },
              );
            } else if (state is EnrolledCoursesError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is EnrolledCoursesLoaded) {
              final courses = state.courses;
              if (courses.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () => context
                      .read<EnrolledCoursesCubit>()
                      .fetchEnrolledCourses(),
                  color: AppTheme.primaryGoldDark,
                  backgroundColor: AppTheme.backgroundLight,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyStateWidget(
                          icon: Icons.lock_outline_rounded,
                          title: 'No Unlocked Courses',
                          subtitle: 'You have not unlocked any courses yet.\nUse an access code to unlock a course.',
                        ),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () =>
                    context.read<EnrolledCoursesCubit>().fetchEnrolledCourses(),
                color: AppTheme.primaryGoldDark,
                backgroundColor: AppTheme.backgroundLight,
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
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
