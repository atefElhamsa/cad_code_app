import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../widgets/brand_header.dart';
import '../../../widgets/profile_user_info.dart';
import '../../../widgets/course_selector_pill.dart';
import '../../../widgets/profile_stats_card.dart';
import '../../../core/theme/app_theme.dart';
import '../data/profile_mock_data.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _selectedCourseIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedCourse = enrolledCoursesMock[_selectedCourseIndex];

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        children: [
          BrandHeader(
            title: 'Profile',
            showBack: true,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 32,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  const ProfileUserInfo(name: 'Atef', phone: '01012345678'),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Course Progress',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDarkNavy,
                        fontFamily: 'Inter',
                      ),
                    ).animate().fade(delay: 400.ms).slideX(begin: -0.1),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 54,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: enrolledCoursesMock.length,
                      itemBuilder: (context, index) {
                        return CourseSelectorPill(
                              course: enrolledCoursesMock[index],
                              isSelected: index == _selectedCourseIndex,
                              onTap: () =>
                                  setState(() => _selectedCourseIndex = index),
                            )
                            .animate()
                            .fade(delay: (400 + (index * 100)).ms)
                            .slideX(begin: 0.2);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  ProfileStatsCard(course: selectedCourse),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
