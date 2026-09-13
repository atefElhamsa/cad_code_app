import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class EditProfilePersonIcon extends StatelessWidget {
  const EditProfilePersonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person_rounded,
      color: AppTheme.primaryCyan,
      size: 60,
    );
  }
}
