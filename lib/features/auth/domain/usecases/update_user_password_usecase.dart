import '../repositories/auth_repository.dart';

class UpdateUserPasswordUseCase {
  final AuthRepository repository;

  UpdateUserPasswordUseCase(this.repository);

  Future<void> call(String newPassword) {
    return repository.updatePassword(newPassword);
  }
}