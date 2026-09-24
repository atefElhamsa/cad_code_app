import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../widgets/brand_header.dart';
import '../../../core/theme/app_theme.dart';
import 'widgets/courses_header.dart';
import 'widgets/courses_grid_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        children: [
          const BrandHeader(title: 'C&C Academy'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CoursesHeader(),
                  SizedBox(height: 12.h),
                  const Expanded(child: CoursesGridView()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
