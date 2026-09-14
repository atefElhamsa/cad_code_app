import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/datasources/course_folders_remote_data_source.dart';
import '../../data/datasources/access_code_remote_data_source.dart';
import '../../data/repositories/course_folders_repository_impl.dart';
import '../../data/repositories/access_code_repository_impl.dart';
import '../../presentation/viewmodels/course_folders_cubit/course_folders_cubit.dart';
import '../../presentation/viewmodels/course_folders_cubit/course_folders_state.dart';
import 'course_folder_card.dart';
import 'course_folder_shimmer_card.dart';

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
        AccessCodeRepositoryImpl(
          SupabaseAccessCodeRemoteDataSourceImpl(Supabase.instance.client),
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
              separatorBuilder: (context, index) => SizedBox(height: 24.h),
              itemBuilder: (context, index) {
                return const CourseFolderShimmerCard();
              },
            );
          } else if (state is CourseFoldersError) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Error loading folders: ${state.message}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (state is CourseFoldersLoaded) {
            final folders = state.folders;
            final unlockedFolderIds = state.unlockedFolderIds;
            if (folders.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_off_outlined,
                        size: 80,
                        color: AppTheme.primaryGoldLight.withValues(alpha: 0.5),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'لا يوجد محتوى حالياً',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDarkNavy,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'لم يتم إضافة أي مجلدات لهذا الكورس بعد.',
                        style: TextStyle(
                          fontSize: 16.sp,
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
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: folders.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final folder = folders[index];
                    final isUnlocked = unlockedFolderIds.contains(folder.id);
                    return CourseFolderCard(
                          folder: folder,
                          isUnlocked: isUnlocked,
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
          return SizedBox.shrink();
        },
      ),
    );
  }
}
