import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SocialIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.primaryCyan, width: 1.5),
          color: AppTheme.backgroundWhite,
        ),
        child: Icon(icon, color: AppTheme.primaryCyan),
      ),
    );
  }
}



