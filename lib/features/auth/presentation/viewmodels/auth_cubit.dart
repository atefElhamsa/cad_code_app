import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import '../../domain/usecases/auth_usecases.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithEmailUseCase _signInWithEmailUseCase;
  final SignUpWithEmailUseCase _signUpWithEmailUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignOutUseCase _signOutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final UpdateUserPasswordUseCase _updateUserPasswordUseCase;
  final SupabaseClient _supabase;

  bool _isSigningUp = false;

  AuthCubit(
    this._signInWithEmailUseCase,
    this._signUpWithEmailUseCase,
    this._signInWithGoogleUseCase,
    this._signOutUseCase,
    this._deleteAccountUseCase,
    this._updateUserProfileUseCase,
    this._updateUserPasswordUseCase,
    this._supabase,
  ) : super(AuthInitial()) {
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    _supabase.auth.onAuthStateChange.listen((data) {
      if (_isSigningUp) return;
      final session = data.session;
      if (session != null) {
        emit(Authenticated(session.user));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  String _getFriendlyErrorMessage(dynamic error) {
    if (error is AuthException) {
      if (error.message.toLowerCase().contains('invalid login credentials')) {
        return 'Incorrect email or password. Please try again.';
      } else if (error.message.toLowerCase().contains('already registered')) {
        return 'An account with this email already exists.';
      } else if (error.message.toLowerCase().contains(
        'password should be at least',
      )) {
        return 'Password is too weak. Please use a stronger password.';
      } else if (error.message.toLowerCase().contains('email not confirmed')) {
        return 'Please check your email to verify your account before logging in.';
      }
      return error.message; // Fallback to Supabase message
    }

    final errorStr = error.toString();
    if (errorStr.contains('Exception: Supabase Google Sign In failed')) {
      return 'Google Sign-In was canceled or failed. Please try again.';
    } else if (errorStr.contains('network') || errorStr.contains('socket')) {
      return 'Please check your internet connection and try again.';
    }

    return 'An unexpected error occurred. Please try again later.';
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      await _signInWithEmailUseCase(email, password);
    } catch (e) {
      emit(AuthError(_getFriendlyErrorMessage(e)));
      emit(Unauthenticated());
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      _isSigningUp = true;
      emit(AuthLoading());
      await _signUpWithEmailUseCase(email, password, name, phone);

      final session = _supabase.auth.currentSession;
      if (session != null) {
        await _supabase.auth.signOut();
        emit(
          const AuthActionSuccess(
            'Account created successfully! Please sign in.',
          ),
        );
      } else {
        emit(
          const AuthError('Account may already exist. Please try signing in.'),
        );
      }
    } catch (e) {
      emit(AuthError(_getFriendlyErrorMessage(e)));
    } finally {
      _isSigningUp = false;
      emit(Unauthenticated());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());
      await _signInWithGoogleUseCase();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(_getFriendlyErrorMessage(e)));
      emit(Unauthenticated());
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      await _signOutUseCase();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(_getFriendlyErrorMessage(e)));
    }
  }

  Future<void> deleteAccount() async {
    try {
      emit(AuthLoading());
      await _deleteAccountUseCase();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(_getFriendlyErrorMessage(e)));
      emit(Unauthenticated());
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      emit(AuthLoading());
      await _updateUserProfileUseCase(name: name, phone: phone);
      emit(const AuthActionSuccess('Profile updated successfully!'));
      final session = _supabase.auth.currentSession;
      if (session != null) {
        emit(Authenticated(session.user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(_getFriendlyErrorMessage(e)));
      final session = _supabase.auth.currentSession;
      if (session != null) {
        emit(Authenticated(session.user));
      } else {
        emit(Unauthenticated());
      }
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      emit(AuthLoading());
      await _updateUserPasswordUseCase(newPassword);
      emit(const AuthActionSuccess('Password updated successfully!'));
      final session = _supabase.auth.currentSession;
      if (session != null) {
        emit(Authenticated(session.user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(_getFriendlyErrorMessage(e)));
      final session = _supabase.auth.currentSession;
      if (session != null) {
        emit(Authenticated(session.user));
      } else {
        emit(Unauthenticated());
      }
    }
  }
}
