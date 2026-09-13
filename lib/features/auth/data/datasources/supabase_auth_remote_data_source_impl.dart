import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/auth_user.dart' as entity;
import 'auth_remote_data_source.dart';

class SupabaseAuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  SupabaseAuthRemoteDataSourceImpl(this.supabaseClient);

  entity.AuthUser _mapSupabaseUserToAuthUser(User user) {
    return entity.AuthUser(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] as String?,
      phone: user.userMetadata?['phone'] as String?,
    );
  }

  @override
  Future<entity.AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.user == null) throw Exception('Sign in failed');
    return _mapSupabaseUserToAuthUser(response.user!);
  }

  @override
  Future<entity.AuthUser> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    final Map<String, dynamic> metadata = {
      'name': name,
      'full_name': name, // Added for the DB trigger
    };
    if (phone != null && phone.isNotEmpty) {
      metadata['phone'] = phone;
    }

    final response = await supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: metadata,
      emailRedirectTo: 'io.supabase.cadcodeacademy://login-callback/',
    );
    if (response.user == null) throw Exception('Sign up failed');
    return _mapSupabaseUserToAuthUser(response.user!);
  }

  @override
  Future<entity.AuthUser> signInWithGoogle() async {
    final success = await supabaseClient.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.cadcodeacademy://login-callback/',
    );

    if (!success) {
      throw Exception('Supabase Google Sign In failed or was canceled');
    }

    return const entity.AuthUser(id: 'pending', email: 'pending@auth.com');
  }

  @override
  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await supabaseClient.auth.resetPasswordForEmail(email);
  }

  @override
  Future<entity.AuthUser?> getCurrentUser() async {
    final user = supabaseClient.auth.currentUser;
    if (user != null) {
      return _mapSupabaseUserToAuthUser(user);
    }
    return null;
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = supabaseClient.auth.currentUser;
      if (user != null) {
        try {
          // Attempt to delete avatar, but don't fail if it doesn't exist
          await supabaseClient.storage.from('avatars').remove([
            '${user.id}/avatar.jpg',
          ]);
        } catch (_) {
          // Ignore avatar deletion error, user might not have an uploaded avatar
        }
        try {
          // Delete user unlocked folders
          await supabaseClient
              .from('user_unlocked_folders')
              .delete()
              .eq('user_id', user.id);
        } catch (_) {}

        try {
          // Delete access codes used by the user
          await supabaseClient
              .from('access_codes')
              .delete()
              .eq('used_by', user.id);
        } catch (_) {}
      }

      await supabaseClient.rpc('delete_user');
      await supabaseClient.auth.signOut();
    } catch (e) {
      await supabaseClient.auth.signOut();
      throw Exception('Delete error: $e');
    }
  }

  @override
  Future<entity.AuthUser> updateUserMetadata({
    String? name,
    String? phone,
  }) async {
    final Map<String, dynamic> metadata = {};
    if (name != null) metadata['name'] = name;
    if (phone != null) metadata['phone'] = phone;

    final response = await supabaseClient.auth.updateUser(
      UserAttributes(data: metadata),
    );

    if (response.user == null) {
      throw Exception('Failed to update user profile');
    }

    try {
      final updateData = <String, dynamic>{};
      if (name != null) updateData['full_name'] = name;
      if (phone != null) updateData['phone'] = phone;

      if (updateData.isNotEmpty) {
        await supabaseClient
            .from('profiles')
            .update(updateData)
            .eq('id', response.user!.id);
      }
    } catch (e) {
      // Ignore error if profile update fails
    }

    return _mapSupabaseUserToAuthUser(response.user!);
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    final response = await supabaseClient.auth.updateUser(
      UserAttributes(password: newPassword),
    );

    if (response.user == null) {
      throw Exception('Failed to update password');
    }
  }

  @override
  Future<String> uploadAvatar(String filePath) async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final file = File(filePath);
    final fileExt = filePath.split('.').last.toLowerCase();
    final storagePath = '${user.id}/avatar.$fileExt';

    await supabaseClient.storage
        .from('avatars')
        .upload(
          storagePath,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );

    final publicUrl = supabaseClient.storage
        .from('avatars')
        .getPublicUrl(storagePath);

    final urlWithTimestamp =
        '$publicUrl?t=${DateTime.now().millisecondsSinceEpoch}';

    await supabaseClient.auth.updateUser(
      UserAttributes(data: {'avatar_url': urlWithTimestamp}),
    );

    try {
      await supabaseClient
          .from('profiles')
          .update({'avatar_url': urlWithTimestamp})
          .eq('id', user.id);
    } catch (e) {
      // Ignore error if profile update fails
    }

    return urlWithTimestamp;
  }
}
