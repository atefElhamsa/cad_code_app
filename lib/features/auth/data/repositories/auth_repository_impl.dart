import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) {
    return remoteDataSource.signInWithEmail(email: email, password: password);
  }

  @override
  Future<AuthUser> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    return await remoteDataSource.signUpWithEmail(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
  }

  @override
  Future<AuthUser> signInWithGoogle() {
    return remoteDataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }

  @override
  Future<void> resetPassword(String email) {
    return remoteDataSource.resetPassword(email);
  }

  @override
  Future<AuthUser?> getCurrentUser() {
    return remoteDataSource.getCurrentUser();
  }

  @override
  Future<void> deleteAccount() {
    return remoteDataSource.deleteAccount();
  }

  @override
  Future<AuthUser> updateUserMetadata({String? name, String? phone}) {
    return remoteDataSource.updateUserMetadata(name: name, phone: phone);
  }

  @override
  Future<void> updatePassword(String newPassword) {
    return remoteDataSource.updatePassword(newPassword);
  }
}
