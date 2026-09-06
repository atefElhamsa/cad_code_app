import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SupabaseClient _supabase;

  AuthCubit(this._supabase) : super(AuthInitial()) {
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    final session = _supabase.auth.currentSession;
    if (session != null) {
      emit(Authenticated(session.user));
    } else {
      emit(Unauthenticated());
    }

    _supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session != null) {
        emit(Authenticated(session.user));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());

      const webClientId = 'YOUR_WEB_CLIENT_ID'; // TODO: Update this
      const iosClientId = 'YOUR_IOS_CLIENT_ID'; // TODO: Update this

      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize(
        serverClientId: webClientId,
        clientId: iosClientId,
      );

      final googleUser = await googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw 'No ID Token found.';
      }

      await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      await _supabase.auth.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
