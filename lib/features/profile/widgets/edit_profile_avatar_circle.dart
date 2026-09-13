import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'edit_profile_person_icon.dart';

class EditProfileAvatarCircle extends StatelessWidget {
  final String? avatarUrl;
  final String? localImagePath;
  final bool isLoading;

  const EditProfileAvatarCircle({
    super.key,
    this.avatarUrl,
    this.localImagePath,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 110.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.primaryCyan.withValues(alpha: 0.1),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryCyan.withValues(alpha: 0.25),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipOval(child: _buildChild()),
    );
  }

  Widget _buildChild() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppTheme.primaryCyan,
        ),
      );
    }

    // أولوية 1: صورة محلية مختارة (preview قبل الرفع)
    if (localImagePath != null && localImagePath!.isNotEmpty) {
      return Image.file(
        File(localImagePath!),
        width: 110.w,
        height: 110.h,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        cacheWidth: 330,
        cacheHeight: 330,
        errorBuilder: (_, _, e) => const EditProfilePersonIcon(),
      );
    }

    // أولوية 2: صورة من Supabase Storage
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return Image.network(
        avatarUrl!,
        width: 110.w,
        height: 110.h,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        isAntiAlias: true,
        cacheWidth: 330,
        cacheHeight: 330,
        errorBuilder: (_, _, e) => const EditProfilePersonIcon(),
      );
    }

    // أولوية 3: أيقونة افتراضية
    return const EditProfilePersonIcon();
  }
}
