import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widgets/brand_header.dart';
import 'widgets/course_detail_hero_banner.dart';
import 'widgets/course_folders_list.dart';

class CourseDetailView extends StatelessWidget {
  final int? courseId;
  final String title;
  final String imageUrl;
  final String description;

  const CourseDetailView({
    super.key,
    this.courseId,
    this.title = 'Scratch courses',
    this.imageUrl = 'https://images.unsplash.com/photo-1526379095098-d400fd0bf935?w=400&q=80',
    this.description = 'تعلم اساسيات البرمجة بشكل سهل و ممتع باحترافية عالية',
  });

  @override
  Widget build(BuildContext context) {
    final showTwoPanes = context.screenWidth > 900;

    final sectionTitle = Padding(
      padding: const EdgeInsets.only(bottom: 6.0, top: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'محتوى الكورس',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: ResponsiveUtils.fontSize(context, 18),
              fontWeight: FontWeight.w900,
              color: AppTheme.textDarkNavy,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryGoldLight.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.folder_open_rounded,
              color: AppTheme.primaryGoldDark,
              size: 20,
            ),
          ),
        ],
      ),
    );

    final compactHeroBanner = CourseDetailHeroBanner(
      title: title,
      imageUrl: imageUrl,
      description: description,
      tag: 'C&C Academy',
    );

    Widget bodyContent;

    if (showTwoPanes) {
      bodyContent = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 45,
            child: compactHeroBanner,
          ),
          const SizedBox(width: 28),

          Expanded(
            flex: 55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                sectionTitle,
                if (courseId != null)
                  CourseFoldersList(
                    courseId: courseId!,
                    isLandscapeTablet: false,
                  ),
              ],
            ),
          ),
        ],
      );
    } else {
      bodyContent = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          compactHeroBanner,
          const SizedBox(height: 20),
          sectionTitle,
          if (courseId != null)
            CourseFoldersList(
              courseId: courseId!,
              isLandscapeTablet: false,
            ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        children: [
          BrandHeader(title: title, showBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: ResponsiveConstraint(
                tabletMaxWidth: showTwoPanes ? 1080 : 680,
                child: bodyContent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
