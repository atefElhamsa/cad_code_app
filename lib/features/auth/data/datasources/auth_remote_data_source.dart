import '../../domain/entities/auth_user.dart' as entity;

abstract class AuthRemoteDataSource {
  Future<entity.AuthUser> signInWithEmail({
    required String email,
    required String password,
  });
  Future<entity.AuthUser> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    String? phone,
  });
  Future<entity.AuthUser> signInWithGoogle();
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<entity.AuthUser?> getCurrentUser();
  Future<void> deleteAccount();
  Future<entity.AuthUser> updateUserMetadata({String? name, String? phone});
  Future<void> updatePassword(String newPassword);
}
