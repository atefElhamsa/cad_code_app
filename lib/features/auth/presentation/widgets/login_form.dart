import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/gold_gradient_button.dart';
import 'auth_logo_header.dart';
import 'auth_divider.dart';
import 'social_login_button.dart';
import 'auth_footer_link.dart';

class LoginForm extends StatefulWidget {
  final bool isEmailLoading;
  final bool isGoogleLoading;
  final void Function(String email, String password) onLogin;
  final VoidCallback onGoogleLogin;
  final VoidCallback onSignUpTap;

  const LoginForm({
    super.key,
    required this.isEmailLoading,
    required this.isGoogleLoading,
    required this.onLogin,
    required this.onGoogleLogin,
    required this.onSignUpTap,
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
    final showTwoPanes = context.screenWidth > 900;

    final titleFontSize = ResponsiveUtils.fontSize(
      context,
      30,
      minScale: 1.0,
      maxScale: 1.15,
    );
    final subtitleFontSize = ResponsiveUtils.fontSize(
      context,
      16,
      minScale: 1.0,
      maxScale: 1.15,
    );

    final formFieldsAndActions = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(
          controller: _emailController,
          hintText: 'Email',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
          validator: (val) => val == null || val.isEmpty
              ? 'Please enter your email'
              : null,
        ).animate().fadeIn(delay: 400.ms),
        const SizedBox(height: 16),
        CustomTextField(
          controller: _passwordController,
          hintText: 'Password',
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.password],
          onFieldSubmitted: (_) => _submit(),
          validator: (val) => val == null || val.isEmpty
              ? 'Please enter your password'
              : null,
        ).animate().fadeIn(delay: 500.ms),
        const SizedBox(height: 24),
        PrimaryGradientButton(
          text: 'Login',
          isLoading: widget.isEmailLoading,
          onPressed: isLoading ? null : _submit,
        ).animate().fadeIn(delay: 600.ms).scale(curve: Curves.easeOutBack),
        const SizedBox(height: 20),
        const AuthDivider(),
        const SizedBox(height: 20),
        SocialLoginButton(
          isLoading: widget.isGoogleLoading,
          onPressed: isLoading ? null : widget.onGoogleLogin,
        ),
        const SizedBox(height: 24),
        AuthFooterLink(
          normalText: "Don't have an account? ",
          linkText: "Sign up",
          onTap: widget.onSignUpTap,
        ),
      ],
    );

    if (showTwoPanes) {
      return Form(
        key: _formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Pane: Logo, Title, Subtitle
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthLogoHeader(logoSize: 100),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, curve: Curves.easeOut),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue your journey',
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: Colors.white.withValues(alpha: 0.6),
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, curve: Curves.easeOut),
                ],
              ),
            ),
            const SizedBox(width: 48),

            // Right Pane: Form fields and actions
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: formFieldsAndActions,
            ),
          ],
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AuthLogoHeader(),
          const SizedBox(height: 24),
          Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, curve: Curves.easeOut),
          const SizedBox(height: 8),
          Text(
            'Sign in to continue your journey',
            style: TextStyle(
              fontSize: subtitleFontSize,
              color: Colors.white.withValues(alpha: 0.6),
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, curve: Curves.easeOut),
          const SizedBox(height: 32),
          formFieldsAndActions,
        ],
      ),
    );
  }
}
