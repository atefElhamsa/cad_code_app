import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

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

  const CourseFolderCard({
    super.key,
    required this.folder,
    required this.isUnlocked,
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
    final buttonColor = isUnlocked
        ? const Color(0xFF22C55E)
        : AppTheme.primaryCyan;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onTap(context),
          splashColor: buttonColor.withValues(alpha: 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Cover image ──────────────────────────────────
              if (folder.imageUrl != null)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        folder.imageUrl!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        cacheWidth: 800,
                        cacheHeight: 500,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFF0F172A),
                          child: Center(
                            child: Icon(
                              Icons.school_rounded,
                              color: Color(0xFFD4AF37),
                              size: 48,
                            ),
                          ),
                        ),
                      ),
                      // subtle bottom gradient
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 60.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.25),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Lock badge (top-right)
                      if (!isUnlocked)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.lock_rounded,
                                  color: Color(0xFFD4AF37),
                                  size: 14,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  'مغلق',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

              // ── Info section ─────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Title
                    Text(
                      folder.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDarkNavy,
                        fontFamily: 'Inter',
                        height: 1.3,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 6.h),

                    // Description
                    Text(
                      folder.description ??
                          'لا يوجد وصف متاح لهذا المجلد حالياً.',
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade500,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ── Action button ──────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Open / Access button
                        GestureDetector(
                          onTap: () => _onTap(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  buttonColor,
                                  buttonColor.withValues(alpha: 0.8),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(50.r),
                              boxShadow: [
                                BoxShadow(
                                  color: buttonColor.withValues(alpha: 0.35),
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
                                      ? Icons.play_arrow_rounded
                                      : Icons.vpn_key_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  isUnlocked ? 'ابدأ الآن' : 'فتح',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14.sp,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Chapters count or lock icon
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Icon(
                            isUnlocked
                                ? Icons.folder_open_rounded
                                : Icons.lock_outline_rounded,
                            color: const Color(0xFFD4AF37),
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
