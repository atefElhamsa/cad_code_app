import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (folder.imageUrl != null)
            Image.network(
              folder.imageUrl!,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  folder.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDarkNavy,
                    fontFamily: 'Inter',
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                Text(
                  folder.description ?? 'لا يوجد وصف متاح لهذا المجلد حالياً.',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 140,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isUnlocked) {
                          // Navigate to folder contents
                          // context.push('/folder-contents', extra: folder.id);
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
                                  context
                                      .read<CourseFoldersCubit>()
                                      .addUnlockedFolder(folder.id);
                                },
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isUnlocked
                            ? Colors.green
                            : AppTheme.primaryCyan,
                        shape: const StadiumBorder(),
                        elevation: 4,
                        shadowColor:
                            (isUnlocked ? Colors.green : AppTheme.primaryCyan)
                                .withValues(alpha: 0.4),
                      ),
                      child: Text(
                        isUnlocked ? 'Open' : 'Access',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
