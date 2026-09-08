import 'package:cad_code_academy/features/courses/domain/entities/course_entity.dart';
import 'package:cad_code_academy/features/courses/domain/repositories/courses_repository.dart';

class GetCoursesUseCase {
  final CoursesRepository repository;

  GetCoursesUseCase(this.repository);

  Future<List<CourseEntity>> call() async {
    return await repository.getCourses();
  }
}
