import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ProfileMenuDivider extends StatelessWidget {
  const ProfileMenuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppTheme.backgroundLight,
      indent: 60,
    );
  }
}
