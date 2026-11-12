import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_theme.dart';

class CourseDetailHeroBanner extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String? tag;

  const CourseDetailHeroBanner({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    this.tag,
  });

  IconData _getCourseIcon(String title) {
    final lower = title.toLowerCase();
    if (lower.contains('c++') || lower.contains('cpp') || lower.contains('cplusplus')) {
      return Icons.terminal_rounded;
    }
    if (lower.contains('scratch') || title.contains('سكراتش')) {
      return Icons.extension_rounded;
    }
    if (lower.contains('python') || title.contains('بايثون')) {
      return Icons.data_object_rounded;
    }
    if (lower.contains('flutter') || lower.contains('dart') || title.contains('فلاتر')) {
      return Icons.phone_android_rounded;
    }
    if (lower.contains('web') || lower.contains('html') || lower.contains('css')) {
      return Icons.language_rounded;
    }
    return Icons.code_rounded;
  }

  String _getCategoryTag(String title) {
    if (tag != null && tag!.isNotEmpty && tag != 'C&C Academy') {
      return tag!;
    }
    final lower = title.toLowerCase();
    if (lower.contains('c++') || lower.contains('cpp')) {
      return 'لغة C++';
    }
    if (lower.contains('scratch') || title.contains('سكراتش')) {
      return 'برمجة المرئيات والكتل';
    }
    if (lower.contains('python') || title.contains('بايثون')) {
      return 'لغة بايثون';
    }
    if (lower.contains('flutter') || title.contains('فلاتر')) {
      return 'تطوير التطبيقات';
    }
    return 'أساسيات البرمجة';
  }

  String _getCourseDescription(String title, String? rawDescription) {
    if (rawDescription != null &&
        rawDescription.trim().isNotEmpty &&
        rawDescription != 'تعلم اساسيات البرمجة بشكل سهل و ممتع باحترافية عالية') {
      final trimmed = rawDescription.trim();
      if (trimmed.startsWith('C++') || trimmed.startsWith('c++')) {
        final rest = trimmed.substring(3).trim();
        return '$rest C++';
      }
      return trimmed;
    }

    final lower = title.toLowerCase();
    if (lower.contains('c++') || lower.contains('cpp')) {
      return 'تعلم البرمجة الهيكلية وإدارة الذاكرة والأنماط المتقدمة بلغة C++';
    }
    if (lower.contains('scratch') || title.contains('سكراتش')) {
      return 'تعلم أساسيات البرمجة المرئية وإنشاء الألعاب والتطبيقات باستخدام Scratch';
    }
    if (lower.contains('python') || title.contains('بايثون')) {
      return 'تعلم تطوير الخوارزميات وتحليل البيانات وبناء المشاريع بلغة Python';
    }
    if (lower.contains('flutter') || lower.contains('dart') || title.contains('فلاتر')) {
      return 'دورة متكاملة لتطوير تطبيقات الهواتف الذكية بنظامي Android و iOS مع Flutter';
    }
    if (lower.contains('web') || lower.contains('html') || lower.contains('css')) {
      return 'تعلم تصميم وبناء مواقع وتطبيقات الويب الحديثة باستخدام HTML و CSS';
    }
    return 'دورة تعليمية شاملة مع شروحات تفاعلية وتدريبات عملية لتطوير مهاراتك البرمجية';
  }

  @override
  Widget build(BuildContext context) {
    final titleFontSize = ResponsiveUtils.fontSize(
      context,
      22,
      minScale: 1.0,
      maxScale: 1.15,
    );
    final descFontSize = ResponsiveUtils.fontSize(
      context,
      15,
      minScale: 1.0,
      maxScale: 1.15,
    );

    final courseIcon = _getCourseIcon(title);
    final categoryTag = _getCategoryTag(title);
    final effectiveDescription = _getCourseDescription(title, description);

    final bool hasValidNetworkImage = imageUrl.isNotEmpty &&
        !imageUrl.contains('unsplash') &&
        (imageUrl.startsWith('http://') || imageUrl.startsWith('https://'));

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0F172A),
              Color(0xFF1E293B),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppTheme.primaryGoldLight.withValues(alpha: 0.4),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryGoldDark.withValues(alpha: 0.22),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Premium Artwork Container
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryGoldDark.withValues(alpha: 0.35),
                        AppTheme.backgroundDarkNavy,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.primaryGoldLight,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryGoldDark.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: hasValidNetworkImage
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              cacheWidth: 350,
                              cacheHeight: 350,
                              errorBuilder: (context, error, stackTrace) => Center(
                                child: Icon(
                                  courseIcon,
                                  color: AppTheme.primaryGoldLight,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: ShaderMask(
                            shaderCallback: (bounds) =>
                                AppTheme.goldGradient.createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            ),
                            child: Icon(
                              courseIcon,
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGoldLight.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppTheme.primaryGoldLight.withValues(alpha: 0.4),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              categoryTag.fixBidi,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: AppTheme.primaryGoldLight,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title.fixBidi,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontFamily: 'Inter',
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              effectiveDescription.fixBidi,
              textAlign: TextAlign.right,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: descFontSize,
                color: Colors.white.withValues(alpha: 0.9),
                fontFamily: 'Inter',
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 14),

            Divider(
              color: Colors.white.withValues(alpha: 0.12),
              height: 1,
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBadge(Icons.laptop_mac_rounded, 'شروحات وتمارين', AppTheme.primaryCyan),
                _buildBadge(Icons.workspace_premium_rounded, 'تطبيق عملي', AppTheme.primaryGoldLight),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 5),
        Text(
          label.fixBidi,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.95),
            fontSize: 11.5,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
