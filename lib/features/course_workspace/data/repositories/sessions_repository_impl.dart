import '../../domain/entities/session_entity.dart';
import '../../domain/repositories/sessions_repository.dart';
import '../datasources/sessions_remote_data_source.dart';

class SessionsRepositoryImpl implements SessionsRepository {
  final SessionsRemoteDataSource remoteDataSource;

  SessionsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<SessionEntity>> getSessions(int folderId) async {
    return await remoteDataSource.getSessions(folderId);
  }
}
