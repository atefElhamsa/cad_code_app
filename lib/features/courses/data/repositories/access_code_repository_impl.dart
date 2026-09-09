import '../../domain/repositories/access_code_repository.dart';
import '../datasources/access_code_remote_data_source.dart';

class AccessCodeRepositoryImpl implements AccessCodeRepository {
  final AccessCodeRemoteDataSource remoteDataSource;

  AccessCodeRepositoryImpl(this.remoteDataSource);

  @override
  Future<bool> validateAndUseAccessCode(int folderId, String code) async {
    return await remoteDataSource.validateAndUseAccessCode(folderId, code);
  }

  @override
  Future<List<int>> getUnlockedFolders() async {
    return await remoteDataSource.getUnlockedFolders();
  }
}
