import 'package:cad_code_academy/features/courses/domain/entities/course_entity.dart';

abstract class CoursesRepository {
  Future<List<CourseEntity>> getCourses();
}
