import 'package:cad_code_academy/features/courses/data/datasources/courses_remote_data_source.dart';
import 'package:cad_code_academy/features/courses/domain/entities/course_entity.dart';
import 'package:cad_code_academy/features/courses/domain/repositories/courses_repository.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  final CoursesRemoteDataSource remoteDataSource;

  CoursesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CourseEntity>> getCourses() async {
    return await remoteDataSource.getCourses();
  }
}
