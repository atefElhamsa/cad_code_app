import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../widgets/brand_header.dart';
import '../../../widgets/access_code_dialog.dart';
import '../../../core/theme/app_theme.dart';

class CourseDetailView extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  const CourseDetailView({
    super.key,
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
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top: Course Image
                    Image.network(
                      imageUrl,
                      height: 220,
                      fit: BoxFit.cover,
                    ).animate().fadeIn(duration: 400.ms),

                    // Bottom: Content and Button
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'تعلم اساسيات البرمجة باستخدام سكراتش',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDarkNavy,
                              fontFamily: 'Inter',
                            ),
                            textAlign: TextAlign.right,
                          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textDarkNavy.withValues(
                                alpha: 0.6,
                              ),
                            ),
                            textAlign: TextAlign.right,
                          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                          const SizedBox(height: 24),
                          Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 140,
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const AccessCodeDialog(),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.primaryCyan,
                                      shape: const StadiumBorder(),
                                      elevation: 4,
                                      shadowColor: AppTheme.primaryCyan
                                          .withValues(alpha: 0.4),
                                    ),
                                    child: const Text(
                                      'Access',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .animate()
                              .fadeIn(delay: 400.ms)
                              .scale(begin: const Offset(0.9, 0.9)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
