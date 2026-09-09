import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/brand_header.dart';
import '../../../core/theme/app_theme.dart';
import '../presentation/viewmodels/enrolled_courses_cubit/enrolled_courses_cubit.dart';
import 'widgets/enrolled_courses_grid_view.dart';

class EnrolledCoursesView extends StatefulWidget {
  const EnrolledCoursesView({super.key});

  @override
  State<EnrolledCoursesView> createState() => _EnrolledCoursesViewState();
}

class _EnrolledCoursesViewState extends State<EnrolledCoursesView> {
  @override
  void initState() {
    super.initState();
    context.read<EnrolledCoursesCubit>().fetchEnrolledCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        children: [
          const BrandHeader(title: 'My Courses'),
          const Expanded(child: EnrolledCoursesGridView()),
        ],
      ),
    );
  }
}
