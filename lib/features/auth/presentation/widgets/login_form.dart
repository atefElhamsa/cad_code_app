import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/gold_gradient_button.dart';
import '../../../../core/theme/app_theme.dart';
import 'auth_logo.dart';
import 'auth_divider.dart';
import 'social_login_button.dart';

class LoginForm extends StatefulWidget {
  final bool isEmailLoading;
  final bool isGoogleLoading;
  final void Function(String email, String password) onLogin;
  final VoidCallback onGoogleLogin;

  const LoginForm({
    super.key,
    required this.isEmailLoading,
    required this.isGoogleLoading,
    required this.onLogin,
    required this.onGoogleLogin,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onLogin(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isEmailLoading || widget.isGoogleLoading;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthLogo(),
          SizedBox(height: 30.h,),
          Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(delay: 200.ms)
              .slideY(begin: 0.2, curve: Curves.easeOut),
          SizedBox(height: 8.h,),
          Text(
                'Sign in to continue your journey',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(delay: 300.ms)
              .slideY(begin: 0.2, curve: Curves.easeOut),
          SizedBox(height: 40.h,),
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
          SizedBox(height: 16.h,),
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
          SizedBox(height: 40.h,),
          PrimaryGradientButton(
            text: 'Login',
            isLoading: widget.isEmailLoading,
            onPressed: isLoading ? null : _submit,
          ).animate().fadeIn(delay: 600.ms).scale(curve: Curves.easeOutBack),
          SizedBox(height: 20.h,),
          const AuthDivider(),
          SizedBox(height: 20.h,),
          SocialLoginButton(
            isLoading: widget.isGoogleLoading,
            onPressed: isLoading ? null : widget.onGoogleLogin,
          ),
          SizedBox(height: 15.h,),
          TextButton(
            onPressed: () => context.push('/signup'),
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(color: Colors.white70, fontSize: 16.sp,),
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
    );
  }
}
