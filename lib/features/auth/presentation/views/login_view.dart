import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/gold_gradient_button.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_divider.dart';
import '../widgets/social_login_button.dart';
import '../viewmodels/auth_cubit.dart';
import '../viewmodels/auth_state.dart';

import '../../../../core/utils/custom_snackbar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isEmailLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isEmailLoading = true);
      context.read<AuthCubit>().signInWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
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
            CustomSnackBar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const AuthLogo(),
                        const SizedBox(height: 30),
                        const Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            )
                            .animate()
                            .fadeIn(delay: 200.ms)
                            .slideY(begin: 0.2, curve: Curves.easeOut),
                        const SizedBox(height: 8),
                        Text(
                              'Sign in to continue your journey',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withValues(alpha: 0.6),
                              ),
                              textAlign: TextAlign.center,
                            )
                            .animate()
                            .fadeIn(delay: 300.ms)
                            .slideY(begin: 0.2, curve: Curves.easeOut),
                        const SizedBox(height: 40),
                        CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Please enter your email'
                                  : null,
                            )
                            .animate()
                            .fadeIn(delay: 400.ms)
                            .slideX(begin: 0.2, curve: Curves.easeOut),
                        const SizedBox(height: 16),
                        CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              prefixIcon: Icons.lock_outline,
                              isPassword: true,
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Please enter your password'
                                  : null,
                            )
                            .animate()
                            .fadeIn(delay: 500.ms)
                            .slideX(begin: -0.2, curve: Curves.easeOut),
                        const SizedBox(height: 40),
                        PrimaryGradientButton(
                              text: 'Login',
                              isLoading: _isEmailLoading,
                              onPressed: isLoading ? null : _onLogin,
                            )
                            .animate()
                            .fadeIn(delay: 600.ms)
                            .scale(curve: Curves.easeOutBack),
                        const SizedBox(height: 20),
                        const AuthDivider(),
                        const SizedBox(height: 20),
                        SocialLoginButton(
                          isLoading: _isGoogleLoading,
                          onPressed: isLoading ? null : _onGoogleLogin,
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () => context.push('/signup'),
                          child: RichText(
                            text: const TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign up",
                                  style: TextStyle(
                                    color: AppTheme.primaryGoldLight,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn(delay: 800.ms),
                      ],
                    ),
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
