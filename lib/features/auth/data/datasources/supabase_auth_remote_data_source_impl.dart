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
    final Map<String, dynamic> metadata = {'name': name};
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
    // We use the Supabase native OAuth which opens a secure browser.
    // We MUST pass the deep link redirect URL we added in AndroidManifest.xml
    final success = await supabaseClient.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.cadcodeacademy://login-callback/',
    );

    if (!success) {
      throw Exception('Supabase Google Sign In failed or was canceled');
    }

    // The user will be redirected to the browser.
    // When they return, Supabase's auth state listener will emit Authenticated.
    // For now, we return a pending user.
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
    // Note: Deleting a user requires either a custom Postgres function (RPC)
    // or an Edge Function in Supabase.
    // For now, we will assume an RPC function named 'delete_user' exists.
    try {
      await supabaseClient.rpc('delete_user');
      await supabaseClient.auth.signOut();
    } catch (e) {
      // If the RPC is not implemented on the backend yet, just sign out locally for the UI flow.
      await supabaseClient.auth.signOut();
      throw Exception(
        'Backend setup required: Please create a delete_user RPC in Supabase.',
      );
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

    // Also update the public.profiles table to keep it in sync
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
      // Silently ignore if profiles table doesn't exist or RLS blocks it
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
}
