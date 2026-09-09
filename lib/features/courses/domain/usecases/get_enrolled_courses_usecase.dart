import '../entities/course_entity.dart';
import '../repositories/courses_repository.dart';

class GetEnrolledCoursesUseCase {
  final CoursesRepository repository;

  GetEnrolledCoursesUseCase(this.repository);

  Future<List<CourseEntity>> call() async {
    return await repository.getEnrolledCourses();
  }
}
