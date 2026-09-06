import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CourseWorkspaceAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String topic;

  const CourseWorkspaceAppBar({super.key, required this.title, required this.topic});

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.backgroundDarkNavy,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppTheme.primaryGoldLight),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.primaryGoldLight),
        onPressed: () => Navigator.of(context).pop(),
      ),
      toolbarHeight: 90,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        side: BorderSide(color: Color(0xFFD4AF37), width: 1.5),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppTheme.primaryGoldLight,
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontFamily: 'Inter',
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Learn basics of $topic',
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.primaryGoldLight.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
