import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/session_model.dart';

abstract class SessionsRemoteDataSource {
  Future<List<SessionModel>> getSessions(int folderId);
}

class SupabaseSessionsRemoteDataSourceImpl implements SessionsRemoteDataSource {
  final SupabaseClient client;

  SupabaseSessionsRemoteDataSourceImpl(this.client);

  @override
  Future<List<SessionModel>> getSessions(int folderId) async {
    try {
      final response = await client
          .from('sessions')
          .select()
          .eq('folder_id', folderId)
          .order('order_index', ascending: true);

      final List<dynamic> data = response;
      return data.map((json) => SessionModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch sessions: $e');
    }
  }
}
