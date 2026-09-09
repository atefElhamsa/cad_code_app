import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AccessCodeRemoteDataSource {
  Future<bool> validateAndUseAccessCode(int folderId, String code);
  Future<List<int>> getUnlockedFolders();
}

class SupabaseAccessCodeRemoteDataSourceImpl
    implements AccessCodeRemoteDataSource {
  final SupabaseClient client;

  SupabaseAccessCodeRemoteDataSourceImpl(this.client);

  @override
  Future<bool> validateAndUseAccessCode(int folderId, String code) async {
    final user = client.auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }

    try {
      // 1. Call a Supabase RPC function (safest for transactions) OR do it client-side.
      // Here we do it client-side for simplicity.
      final response = await client
          .from('access_codes')
          .select()
          .eq('folder_id', folderId)
          .eq('code', code)
          .eq('is_used', false)
          .maybeSingle();

      if (response == null) {
        throw Exception('Invalid or already used access code');
      }

      final accessCodeId = response['id'];

      // 2. Mark code as used
      await client
          .from('access_codes')
          .update({
            'is_used': true,
            'used_by': user.id,
            'used_at': DateTime.now().toIso8601String(),
          })
          .eq('id', accessCodeId);

      // 3. Add to user_unlocked_folders
      await client.from('user_unlocked_folders').insert({
        'user_id': user.id,
        'folder_id': folderId,
      });

      return true;
    } catch (e) {
      throw Exception('Failed to validate access code: $e');
    }
  }

  @override
  Future<List<int>> getUnlockedFolders() async {
    final user = client.auth.currentUser;
    if (user == null) {
      return [];
    }

    try {
      final response = await client
          .from('user_unlocked_folders')
          .select('folder_id')
          .eq('user_id', user.id);

      return (response as List).map((e) => e['folder_id'] as int).toList();
    } catch (e) {
      return [];
    }
  }
}
