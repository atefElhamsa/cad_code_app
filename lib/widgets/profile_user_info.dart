import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';

class ProfileUserInfo extends StatelessWidget {
  final String name;
  final String phone;
  final String? avatarUrl;

  const ProfileUserInfo({
    super.key,
    required this.name,
    required this.phone,
    this.avatarUrl,
  });

  /// ترقية رابط الصورة لجودة أعلى بناءً على المزود
  String _getHighQualityAvatarUrl(String url) {
    // Google User Content (صور جوجل) - ترقية من s96 لـ s400
    if (url.contains('googleusercontent.com')) {
      // استبدال أي حجم موجود بـ 400px
      final upgraded = url
          .replaceAll(RegExp(r'=s\d+-c'), '=s400-c')
          .replaceAll(RegExp(r'=s\d+'), '=s400-c');
      // لو مفيش size parameter أصلاً، نضيفه
      if (!upgraded.contains('=s')) {
        return '$upgraded=s400-c';
      }
      return upgraded;
    }

    // Gravatar - استبدال أو إضافة حجم كبير
    if (url.contains('gravatar.com')) {
      final uri = Uri.tryParse(url);
      if (uri != null) {
        final params = Map<String, String>.from(uri.queryParameters);
        params['s'] = '400';
        params['d'] = 'mp'; // fallback لو مفيش صورة
        return uri.replace(queryParameters: params).toString();
      }
    }

    // Facebook Graph API
    if (url.contains('graph.facebook.com')) {
      final uri = Uri.tryParse(url);
      if (uri != null) {
        final params = Map<String, String>.from(uri.queryParameters);
        params['width'] = '400';
        params['height'] = '400';
        return uri.replace(queryParameters: params).toString();
      }
    }

    // غير ذلك - إرجاع الرابط كما هو
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final highQualityUrl = avatarUrl != null && avatarUrl!.isNotEmpty
        ? _getHighQualityAvatarUrl(avatarUrl!)
        : null;

    return Column(
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryCyan.withValues(alpha: 0.1),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryCyan.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: highQualityUrl != null
                ? Image.network(
                    highQualityUrl,
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                    cacheWidth: 400,
                    cacheHeight: 400,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.person_rounded,
                      color: AppTheme.primaryCyan,
                      size: 72,
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                          color: AppTheme.primaryCyan,
                        ),
                      );
                    },
                  )
                : const Icon(
                    Icons.person_rounded,
                    color: AppTheme.primaryCyan,
                    size: 72,
                  ),
          ),
        ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
        const SizedBox(height: 24),
        Text(
          name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppTheme.textDarkNavy,
            fontFamily: 'Inter',
          ),
        ).animate().fade(delay: 200.ms).slideY(begin: 0.2),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.call_rounded, color: Colors.green, size: 18),
              const SizedBox(width: 8),
              Text(
                phone,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ).animate().fade(delay: 300.ms).slideY(begin: 0.2),
      ],
    );
  }
}
