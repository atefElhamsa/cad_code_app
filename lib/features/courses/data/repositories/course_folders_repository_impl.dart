import '../../domain/entities/course_folder_entity.dart';
import '../../domain/repositories/course_folders_repository.dart';
import '../datasources/course_folders_remote_data_source.dart';

class CourseFoldersRepositoryImpl implements CourseFoldersRepository {
  final CourseFoldersRemoteDataSource remoteDataSource;

  CourseFoldersRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CourseFolderEntity>> getCourseFolders(int courseId) async {
    return await remoteDataSource.getCourseFolders(courseId);
  }
}
