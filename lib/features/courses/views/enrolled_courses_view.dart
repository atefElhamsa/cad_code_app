import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../widgets/brand_header.dart';
import '../../../widgets/course_card_grid.dart';
import '../../../core/theme/app_theme.dart';

class EnrolledCoursesView extends StatelessWidget {
  const EnrolledCoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        children: [
          const BrandHeader(title: 'My Courses'),
          Expanded(child: _buildPopulatedState(context)),
        ],
      ),
    );
  }

  Widget _buildPopulatedState(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 800
            ? 4
            : constraints.maxWidth > 600
            ? 3
            : 2;
        return GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            CourseCardGrid(
                  title: 'Flutter Masterclass',
                  tag: 'Dart',
                  imageUrl: 'https://images.unsplash.com/photo-1526379095098-d400fd0bf935?w=400&q=80',
                  onTap: () => context.push('/workspace'),
                )
                .animate()
                .fade(duration: 400.ms)
                .scale(begin: const Offset(0.9, 0.9)),
            CourseCardGrid(
                  title: 'UI/UX Design',
                  tag: 'Design',
                  imageUrl: 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=400&q=80',
                  onTap: () => context.push('/workspace'),
                )
                .animate()
                .fade(duration: 400.ms, delay: 100.ms)
                .scale(begin: const Offset(0.9, 0.9)),
            CourseCardGrid(
                  title: 'Backend with Node',
                  tag: 'Node.js',
                  imageUrl: 'https://images.unsplash.com/photo-1555099962-4199c345e5dd?w=400&q=80',
                  onTap: () => context.push('/workspace'),
                )
                .animate()
                .fade(duration: 400.ms, delay: 200.ms)
                .scale(begin: const Offset(0.9, 0.9)),
            CourseCardGrid(
                  title: 'Python for AI',
                  tag: 'Python',
                  imageUrl: 'https://images.unsplash.com/photo-1515879218367-8466d910aaa4?w=400&q=80',
                  onTap: () => context.push('/workspace'),
                )
                .animate()
                .fade(duration: 400.ms, delay: 300.ms)
                .scale(begin: const Offset(0.9, 0.9)),
          ],
        );
      },
    );
  }
}
