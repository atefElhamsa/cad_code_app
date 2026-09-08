import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../widgets/access_code_dialog.dart';
import '../../data/datasources/course_folders_remote_data_source.dart';
import '../../data/repositories/course_folders_repository_impl.dart';
import '../../presentation/viewmodels/course_folders_cubit/course_folders_cubit.dart';
import '../../presentation/viewmodels/course_folders_cubit/course_folders_state.dart';

class CourseFoldersList extends StatelessWidget {
  final int courseId;

  const CourseFoldersList({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseFoldersCubit(
        CourseFoldersRepositoryImpl(
          SupabaseCourseFoldersRemoteDataSourceImpl(Supabase.instance.client),
        ),
      )..fetchCourseFolders(courseId),
      child: BlocBuilder<CourseFoldersCubit, CourseFoldersState>(
        builder: (context, state) {
          if (state is CourseFoldersLoading) {
            return ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 220,
                            decoration: BoxDecoration(
                              color: AppTheme.backgroundDarkNavy.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 24,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: AppTheme.backgroundDarkNavy
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  height: 16,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppTheme.backgroundDarkNavy
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 48,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: AppTheme.backgroundDarkNavy
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(
                      duration: 1200.ms,
                      color: AppTheme.backgroundDarkNavy.withValues(
                        alpha: 0.05,
                      ),
                      angle: 0.5,
                    );
              },
            );
          } else if (state is CourseFoldersError) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Error loading folders: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is CourseFoldersLoaded) {
            final folders = state.folders;
            if (folders.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_off_outlined,
                        size: 80,
                        color: AppTheme.primaryGoldLight.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'لا يوجد محتوى حالياً',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDarkNavy,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'لم يتم إضافة أي مجلدات لهذا الكورس بعد.',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.textGray,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: folders.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 24),
                  itemBuilder: (context, index) {
                    final folder = folders[index];
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
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const AccessCodeDialog(),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppTheme.primaryCyan,
                                            shape: const StadiumBorder(),
                                            elevation: 4,
                                            shadowColor: AppTheme.primaryCyan
                                                .withValues(alpha: 0.4),
                                          ),
                                          child: const Text(
                                            'Access',
                                            style: TextStyle(
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
                        )
                        .animate()
                        .fadeIn(
                          delay: Duration(milliseconds: 500 + (index * 100)),
                        )
                        .slideY(begin: 0.1);
                  },
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
