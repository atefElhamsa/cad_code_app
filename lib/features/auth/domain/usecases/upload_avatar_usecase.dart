import '../repositories/auth_repository.dart';

class UploadAvatarUseCase {
  final AuthRepository repository;

  UploadAvatarUseCase(this.repository);

  Future<String> call(String filePath) {
    return repository.uploadAvatar(filePath);
  }
}
