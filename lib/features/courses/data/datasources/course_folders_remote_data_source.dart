import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course_folder_model.dart';

abstract class CourseFoldersRemoteDataSource {
  Future<List<CourseFolderModel>> getCourseFolders(int courseId);
}

class SupabaseCourseFoldersRemoteDataSourceImpl
    implements CourseFoldersRemoteDataSource {
  final SupabaseClient client;

  SupabaseCourseFoldersRemoteDataSourceImpl(this.client);

  @override
  Future<List<CourseFolderModel>> getCourseFolders(int courseId) async {
    try {
      final response = await client
          .from('course_folders')
          .select()
          .eq('course_id', courseId)
          .order('created_at', ascending: true);

      return (response as List)
          .map((folderJson) => CourseFolderModel.fromJson(folderJson))
          .toList();
    } catch (e) {
      throw Exception('Failed to load course folders: $e');
    }
  }
}
