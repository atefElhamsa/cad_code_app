import 'package:cad_code_academy/features/courses/domain/entities/course_folder_entity.dart';

abstract class CourseFoldersRepository {
  Future<List<CourseFolderEntity>> getCourseFolders(int courseId);
}
