import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/brand_header.dart';
import '../../../widgets/download_course_card.dart';

class DownloadsView extends StatelessWidget {
  const DownloadsView({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = ['120 MB', '340 MB', '80 MB', '210 MB'];
    final topics = [
      'Intro to Flutter',
      'State Management',
      'Responsive UI',
      'Firebase',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: Column(
        children: [
          BrandHeader(
            title: 'Downloads',
            showBack: true,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 4,
              itemBuilder: (context, index) {
                return DownloadCourseCard(
                  topic: topics[index],
                  size: sizes[index],
                  videoCount: index + 2,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
