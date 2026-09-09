abstract class AccessCodeRepository {
  Future<bool> validateAndUseAccessCode(int folderId, String code);
  Future<List<int>> getUnlockedFolders();
}
