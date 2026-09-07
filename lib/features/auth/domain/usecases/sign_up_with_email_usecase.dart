import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class SignUpWithEmailUseCase {
  final AuthRepository repository;

  SignUpWithEmailUseCase(this.repository);

  Future<AuthUser> call(
    String email,
    String password,
    String name, [
    String? phone,
  ]) {
    return repository.signUpWithEmail(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
  }
}
