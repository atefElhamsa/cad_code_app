import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class EditProfileCameraBadge extends StatelessWidget {
  const EditProfileCameraBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryCyan,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.camera_alt_rounded,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
