import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  });

  Future<AuthUser> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    String? phone,
  });

  Future<AuthUser> signInWithGoogle();

  Future<void> signOut();

  Future<void> resetPassword(String email);

  Future<AuthUser?> getCurrentUser();

  Future<void> deleteAccount();

  Future<AuthUser> updateUserMetadata({String? name, String? phone});

  Future<void> updatePassword(String newPassword);
}
