import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/responsive/responsive.dart';
import '../core/theme/app_theme.dart';

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
    if (url.contains('googleusercontent.com')) {
      final upgraded = url
          .replaceAll(RegExp(r'=s\d+-c'), '=s400-c')
          .replaceAll(RegExp(r'=s\d+'), '=s400-c');
      if (!upgraded.contains('=s')) {
        return '$upgraded=s400-c';
      }
      return upgraded;
    }

    if (url.contains('gravatar.com')) {
      final uri = Uri.tryParse(url);
      if (uri != null) {
        final params = Map<String, String>.from(uri.queryParameters);
        params['s'] = '400';
        params['d'] = 'mp';
        return uri.replace(queryParameters: params).toString();
      }
    }

    if (url.contains('graph.facebook.com')) {
      final uri = Uri.tryParse(url);
      if (uri != null) {
        final params = Map<String, String>.from(uri.queryParameters);
        params['width'] = '400';
        params['height'] = '400';
        return uri.replace(queryParameters: params).toString();
      }
    }

    return url;
  }

  @override
  Widget build(BuildContext context) {
    final avatarSize = (context.shortestSide * 0.22).clamp(96.0, 180.0);
    final highQualityUrl = avatarUrl != null && avatarUrl!.isNotEmpty
        ? _getHighQualityAvatarUrl(avatarUrl!)
        : null;

    final titleFontSize = ResponsiveUtils.fontSize(
      context,
      26,
      minScale: 1.0,
      maxScale: 1.2,
    );
    final phoneFontSize = ResponsiveUtils.fontSize(
      context,
      14,
      minScale: 1.0,
      maxScale: 1.15,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryCyan.withValues(alpha: 0.1),
            border: Border.all(
              color: AppTheme.primaryCyan.withValues(alpha: 0.4),
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryCyan.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: SizedBox(
              width: avatarSize,
              height: avatarSize,
              child: highQualityUrl != null
                  ? Image.network(
                      highQualityUrl,
                      width: avatarSize,
                      height: avatarSize,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      isAntiAlias: true,
                      cacheWidth: 400,
                      cacheHeight: 400,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.person_rounded,
                        color: AppTheme.primaryCyan,
                        size: avatarSize * 0.5,
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
                  : Icon(
                      Icons.person_rounded,
                      color: AppTheme.primaryCyan,
                      size: avatarSize * 0.5,
                    ),
            ),
          ),
        ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
        SizedBox(height: ResponsiveUtils.spaceLg(context)),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w900,
            color: AppTheme.textDarkNavy,
            fontFamily: 'Inter',
          ),
        ).animate().fade(delay: 200.ms).slideY(begin: 0.2),
        SizedBox(height: ResponsiveUtils.spaceSm(context)),
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
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  fontSize: phoneFontSize,
                ),
              ),
            ],
          ),
        ).animate().fade(delay: 300.ms).slideY(begin: 0.2),
      ],
    );
  }
}
