import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../widgets/brand_header.dart';
import '../../../widgets/course_card_grid.dart';
import '../../../core/theme/app_theme.dart';

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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Courses Title & Tag in a beautifully aligned Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                            'Courses',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDarkNavy,
                              fontFamily: 'Inter',
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 200.ms, duration: 400.ms)
                          .slideX(begin: -0.2),
                      const Spacer(), // Pushes the container to the far right
                      Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGoldLight.withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppTheme.primaryGoldLight.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            child: const Text(
                              'معاك خطوة بخطوة',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryGoldDark,
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 300.ms, duration: 400.ms)
                          .slideX(begin: 0.2),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Course Cards
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.only(bottom: 24),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio:
                          0.85, // Makes the card taller than it is wide!
                      children: [
                        CourseCardGrid(
                              title: 'HTML & CSS',
                              tag: 'Front End',
                              imageUrl: 'https://images.unsplash.com/photo-1618477388954-7f113337eb13?w=400&q=80',
                              onTap: () => context.push('/course-detail'),
                            )
                            .animate()
                            .fadeIn(delay: 400.ms)
                            .scale(begin: const Offset(0.9, 0.9)),
                        CourseCardGrid(
                              title: 'Python',
                              tag: 'AI',
                              imageUrl: 'https://images.unsplash.com/photo-1526379095098-d400fd0bf935?w=400&q=80',
                              onTap: () => context.push('/course-detail'),
                            )
                            .animate()
                            .fadeIn(delay: 600.ms)
                            .scale(begin: const Offset(0.9, 0.9)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
