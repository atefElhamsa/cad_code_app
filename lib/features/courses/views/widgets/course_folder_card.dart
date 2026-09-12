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
              SupabaseAccessCodeRemoteDataSourceImpl(
                Supabase.instance.client,
              ),
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
    final buttonColor = isUnlocked ? const Color(0xFF22C55E) : AppTheme.primaryCyan;
    
    // Responsive image height
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageHeight = screenWidth > 600 ? 250.0 : 170.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
                Stack(
                  children: [
                    Image.network(
                      folder.imageUrl!,
                      height: imageHeight,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: imageHeight,
                        color: const Color(0xFF0F172A),
                        child: const Center(
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
                        height: 60,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.lock_rounded,
                                  color: Color(0xFFD4AF37), size: 14),
                              SizedBox(width: 5),
                              Text(
                                'مغلق',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),

              // ── Info section ─────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Title
                    Text(
                      folder.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDarkNavy,
                        fontFamily: 'Inter',
                        height: 1.3,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 6),

                    // Description
                    Text(
                      folder.description ??
                          'لا يوجد وصف متاح لهذا المجلد حالياً.',
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Action button ──────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Open / Access button
                        GestureDetector(
                          onTap: () => _onTap(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 12,
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
                              borderRadius: BorderRadius.circular(50),
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
                                const SizedBox(width: 6),
                                Text(
                                  isUnlocked ? 'ابدأ الآن' : 'فتح',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Chapters count or lock icon
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(14),
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
