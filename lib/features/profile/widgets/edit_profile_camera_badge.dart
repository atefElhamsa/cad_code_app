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
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppTheme.primaryCyan,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.camera_alt_rounded,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
