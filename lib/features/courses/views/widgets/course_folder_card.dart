import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../widgets/access_code_dialog.dart';
import '../../domain/entities/course_folder_entity.dart';
import '../../data/datasources/access_code_remote_data_source.dart';
import '../../data/repositories/access_code_repository_impl.dart';
import '../../presentation/viewmodels/course_folders_cubit/course_folders_cubit.dart';
import '../../presentation/viewmodels/access_code_cubit/access_code_cubit.dart';

class CourseFolderCard extends StatelessWidget {
  final CourseFolderEntity folder;
  final bool isUnlocked;
  final int index;

  const CourseFolderCard({
    super.key,
    required this.folder,
    required this.isUnlocked,
    this.index = 0,
  });

  void _onTap(BuildContext context) {
    if (isUnlocked) {
      context.push(
        '/workspace',
        extra: {
          'folderId': folder.id,
          'title': folder.title,
          'topic': folder.title,
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => BlocProvider(
          create: (_) => AccessCodeCubit(
            AccessCodeRepositoryImpl(
              SupabaseAccessCodeRemoteDataSourceImpl(Supabase.instance.client),
            ),
          ),
          child: AccessCodeDialog(
            folderId: folder.id,
            onSuccess: () {
              context.read<CourseFoldersCubit>().addUnlockedFolder(folder.id);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryAccent = isUnlocked
        ? const Color(0xFF22C55E)
        : AppTheme.primaryGoldDark;


    final titleFontSize = ResponsiveUtils.fontSize(
      context,
      18,
      minScale: 1.0,
      maxScale: 1.15,
    );
    final descFontSize = ResponsiveUtils.fontSize(
      context,
      14,
      minScale: 1.0,
      maxScale: 1.15,
    );
    final btnFontSize = ResponsiveUtils.fontSize(
      context,
      14,
      minScale: 1.0,
      maxScale: 1.15,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: primaryAccent.withValues(alpha: 0.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        folder.title.fixBidi,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textDarkNavy,
                          fontFamily: 'Inter',
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: primaryAccent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isUnlocked
                                    ? Icons.check_circle_rounded
                                    : Icons.lock_rounded,
                                size: 14,
                                color: primaryAccent,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                isUnlocked ? 'متاح للتعلم' : 'مغلق بالرمز',
                                style: TextStyle(
                                  color: primaryAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Module Description
                Text(
                  (folder.description ?? 'يتضمن هذا المجلد محاضرات وشروحات تفاعلية وتدريبات عملية.').fixBidi,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: descFontSize,
                    color: AppTheme.textGray,
                    fontFamily: 'Inter',
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),

                // Bottom Action Bar + Highlights
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quick Highlights Tags
                    Row(
                      children: [
                        _buildTag(Icons.play_circle_outline_rounded, 'شروحات'),
                        const SizedBox(width: 8),
                        _buildTag(Icons.folder_open_rounded, 'ملفات وتمارين'),
                      ],
                    ),

                    // CTA Button
                    GestureDetector(
                      onTap: () => _onTap(context),
                      child: Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isUnlocked
                                ? [
                                    const Color(0xFF22C55E),
                                    const Color(0xFF16A34A),
                                  ]
                                : [
                                    AppTheme.primaryGoldLight,
                                    AppTheme.primaryGoldDark,
                                  ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: primaryAccent.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isUnlocked
                                  ? Icons.arrow_back_rounded
                                  : Icons.vpn_key_rounded,
                              color: isUnlocked ? Colors.white : AppTheme.textDarkNavy,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isUnlocked ? 'ابدأ التعلم' : 'ادخل الرمز',
                              style: TextStyle(
                                color: isUnlocked ? Colors.white : AppTheme.textDarkNavy,
                                fontWeight: FontWeight.w900,
                                fontSize: btnFontSize,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppTheme.textGray),
          const SizedBox(width: 4),
          Text(
            label.fixBidi,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.textGray,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
