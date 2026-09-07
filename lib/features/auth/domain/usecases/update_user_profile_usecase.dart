import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class UpdateUserProfileUseCase {
  final AuthRepository repository;

  UpdateUserProfileUseCase(this.repository);

  Future<AuthUser> call({String? name, String? phone}) {
    return repository.updateUserMetadata(name: name, phone: phone);
  }
}