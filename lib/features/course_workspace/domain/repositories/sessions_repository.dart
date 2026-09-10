import '../entities/session_entity.dart';

abstract class SessionsRepository {
  Future<List<SessionEntity>> getSessions(int folderId);
}
