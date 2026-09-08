import 'package:flutter/material.dart';
import 'package:cad_code_academy/features/courses/views/widgets/course_folders_list.dart';

import '../../../widgets/brand_header.dart';
import '../../../core/theme/app_theme.dart';

class CourseDetailView extends StatelessWidget {
  final int? courseId;
  final String title;
  final String imageUrl;
  final String description;

  const CourseDetailView({
    super.key,
    this.courseId,
    this.title = 'Scratch courses',
    this.imageUrl = 'https://images.unsplash.com/photo-1526379095098-d400fd0bf935?w=400&q=80', // Default placeholder
    this.description = 'تعلم اساسيات البرمجة بشكل سهل و ممتع باستخدام سكراتش',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        children: [
          BrandHeader(title: title, showBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 24.0,
                top: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (courseId != null) CourseFoldersList(courseId: courseId!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
