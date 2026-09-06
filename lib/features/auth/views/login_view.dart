import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gold_gradient_button.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_divider.dart';
import '../widgets/social_login_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDarkNavy,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
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
                  const CustomTextField(
                        hintText: 'Email',
                        prefixIcon: Icons.email_outlined,
                      )
                      .animate()
                      .fadeIn(delay: 400.ms)
                      .slideX(begin: 0.2, curve: Curves.easeOut),
                  const SizedBox(height: 16),
                  const CustomTextField(
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: AppTheme.primaryGoldLight,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 500.ms)
                      .slideX(begin: -0.2, curve: Curves.easeOut),
                  const SizedBox(height: 40),
                  PrimaryGradientButton(
                        text: 'Login',
                        onPressed: () => context.go('/'),
                      )
                      .animate()
                      .fadeIn(delay: 600.ms)
                      .scale(curve: Curves.easeOutBack),
                  const SizedBox(height: 20),
                  const AuthDivider(),
                  const SizedBox(height: 20),
                  const SocialLoginButton(),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () => context.push('/signup'),
                    child: RichText(
                      text: const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
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
  }
}
