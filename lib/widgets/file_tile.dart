import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class FileTile extends StatelessWidget {
  final String name;
  final String type; // pdf, zip, doc
  final VoidCallback onDownload;

  const FileTile({
    super.key,
    required this.name,
    required this.type,
    required this.onDownload,
  });

  Color _getIconColor() {
    switch (type.toLowerCase()) {
      case 'pdf':
        return const Color(0xFFE53935); // Red
      case 'zip':
        return const Color(0xFFF57C00); // Orange/Gold
      case 'doc':
        return const Color(0xFF1E88E5); // Blue
      default:
        return AppTheme.primaryCyan;
    }
  }

  IconData _getIcon() {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'zip':
        return Icons.folder_zip_rounded;
      case 'doc':
        return Icons.description_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // File Icon Box
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _getIconColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(_getIcon(), color: _getIconColor(), size: 28),
          ),
          const SizedBox(width: 16),
          // File Name
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                color: AppTheme.textDarkNavy,
                fontFamily: 'Inter',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          // Download Button
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primaryGoldLight.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cloud_download_rounded,
                color: AppTheme.primaryGoldDark,
                size: 22,
              ),
            ),
            onPressed: onDownload,
            splashRadius: 24,
          ),
        ],
      ),
    );
  }
}
