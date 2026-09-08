import 'package:cad_code_academy/features/courses/data/models/course_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CoursesRemoteDataSource {
  Future<List<CourseModel>> getCourses();
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
}
