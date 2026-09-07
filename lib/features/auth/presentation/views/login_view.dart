import 'package:cad_code_academy/core/theme/app_theme.dart';
import 'package:cad_code_academy/features/auth/presentation/viewmodels/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/auth_dialogs.dart';
import '../widgets/login_form.dart';
import '../viewmodels/auth_cubit.dart';
import '../../../../core/utils/custom_snackbar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isEmailLoading = false;
  bool _isGoogleLoading = false;

  void _onLogin(String email, String password) {
    setState(() => _isEmailLoading = true);
    context.read<AuthCubit>().signInWithEmail(email: email, password: password);
  }

  void _onGoogleLogin() {
    setState(() => _isGoogleLoading = true);
    context.read<AuthCubit>().signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDarkNavy,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is! AuthLoading) {
            setState(() {
              _isEmailLoading = false;
              _isGoogleLoading = false;
            });
          }
          if (state is Authenticated) {
            context.go('/');
          } else if (state is AuthError) {
            if (state.message ==
                'Your account has been banned due to policy violations.') {
              AuthDialogs.showAuthWarningDialog(
                context: context,
                icon: Icons.gavel_rounded,
                color: Colors.redAccent,
                title: 'Account Suspended',
                message: state.message,
                buttonText: 'I Understand',
              );
            } else if (state.message ==
                'This account does not exist or has been deleted.') {
              AuthDialogs.showAuthWarningDialog(
                context: context,
                icon: Icons.person_off_rounded,
                color: Colors.orangeAccent,
                title: 'Account Not Found',
                message: state.message,
                buttonText: 'Okay',
              );
            } else {
              CustomSnackBar.showError(context, state.message);
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: LoginForm(
                    isEmailLoading: _isEmailLoading,
                    isGoogleLoading: _isGoogleLoading,
                    onLogin: _onLogin,
                    onGoogleLogin: _onGoogleLogin,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
