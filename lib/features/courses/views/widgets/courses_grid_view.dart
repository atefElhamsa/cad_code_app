import 'package:cad_code_academy/features/courses/views/widgets/course_grid_view_loading.dart';
import 'package:cad_code_academy/features/courses/views/widgets/empty_courses_home.dart';
import 'package:cad_code_academy/features/courses/views/widgets/not_empty_courses_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/courses_cubit/courses_cubit.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/courses_cubit/courses_state.dart';

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
              return CourseGridViewLoading(crossAxisCount: crossAxisCount);
            } else if (state is CoursesError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is CoursesLoaded) {
              final courses = state.courses;
              if (courses.isEmpty) {
                return const EmptyCoursesHome(
                  title: 'No Courses Found',
                  subtitle: 'We are currently adding new courses.\nPlease check back later.',
                  icon: Icons.search_off_rounded,
                );
              }
              return NotEmptyCoursesHome(
                courses: courses,
                crossAxisCount: crossAxisCount,
              );
            }
            return SizedBox.shrink();
          },
        );
      },
    );
  }
}
