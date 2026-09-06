import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class CourseSelectorPill extends StatelessWidget {
  final Map<String, dynamic> course;
  final bool isSelected;
  final VoidCallback onTap;

  const CourseSelectorPill({
    super.key,
    required this.course,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.textDarkNavy : Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              course['icon'],
              color: isSelected ? AppTheme.primaryGoldLight : course['color'],
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              course['name'],
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.textDarkNavy,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
