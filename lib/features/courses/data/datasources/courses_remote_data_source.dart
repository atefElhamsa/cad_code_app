import 'package:cad_code_academy/features/courses/data/models/course_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CoursesRemoteDataSource {
  Future<List<CourseModel>> getCourses();
  Future<List<CourseModel>> getEnrolledCourses();
}

class SupabaseCoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  final SupabaseClient client;

  SupabaseCoursesRemoteDataSourceImpl(this.client);

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      final response = await client.from('courses').select();
      
      return (response as List).map((courseJson) => CourseModel.fromJson(courseJson)).toList();
    } catch (e) {
      throw Exception('Failed to load courses: $e');
    }
  }

  @override
  Future<List<CourseModel>> getEnrolledCourses() async {
    try {
      final user = client.auth.currentUser;
      if (user == null) return [];
      
      // Get all unlocked folder IDs for the user
      final unlockedFoldersResponse = await client
          .from('user_unlocked_folders')
          .select('folder_id')
          .eq('user_id', user.id);
          
      final folderIds = (unlockedFoldersResponse as List).map((e) => e['folder_id'] as int).toList();
      if (folderIds.isEmpty) return [];

      // Get course IDs for those folders
      final foldersResponse = await client
          .from('course_folders')
          .select('course_id')
          .filter('id', 'in', '(${folderIds.join(',')})');
          
      final courseIds = (foldersResponse as List).map((e) => e['course_id'] as int).toSet().toList(); 
      if (courseIds.isEmpty) return [];

      // Get the actual courses
      final coursesResponse = await client
          .from('courses')
          .select()
          .filter('id', 'in', '(${courseIds.join(',')})');

      return (coursesResponse as List)
          .map((courseJson) => CourseModel.fromJson(courseJson))
          .toList();
    } catch (e) {
      throw Exception('Failed to load enrolled courses: $e');
    }
  }
}
