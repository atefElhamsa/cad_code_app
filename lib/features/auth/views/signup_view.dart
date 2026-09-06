import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gold_gradient_button.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/signup_logo.dart';
import '../widgets/auth_divider.dart';
import '../widgets/social_login_button.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDarkNavy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppTheme.primaryGoldLight,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SignupLogo(),
              const SizedBox(height: 40),
              const Text(
                    'Create Account',
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
                    'Join the ultimate coding journey',
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
                    hintText: 'Full Name',
                    prefixIcon: Icons.person_outline,
                  )
                  .animate()
                  .fadeIn(delay: 400.ms)
                  .slideX(begin: 0.2, curve: Curves.easeOut),
              const SizedBox(height: 16),
              const CustomTextField(
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
                  )
                  .animate()
                  .fadeIn(delay: 500.ms)
                  .slideX(begin: -0.2, curve: Curves.easeOut),
              const SizedBox(height: 16),
              const CustomTextField(
                    hintText: 'Guardian Phone (WhatsApp)',
                    prefixIcon: Icons.phone_outlined,
                  )
                  .animate()
                  .fadeIn(delay: 600.ms)
                  .slideX(begin: 0.2, curve: Curves.easeOut),
              const SizedBox(height: 16),
              const CustomTextField(
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                  )
                  .animate()
                  .fadeIn(delay: 700.ms)
                  .slideX(begin: -0.2, curve: Curves.easeOut),
              const SizedBox(height: 16),
              const CustomTextField(
                    hintText: 'Confirm Password',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                  )
                  .animate()
                  .fadeIn(delay: 800.ms)
                  .slideX(begin: 0.2, curve: Curves.easeOut),
              const SizedBox(height: 40),
              PrimaryGradientButton(
                    text: 'Sign Up',
                    onPressed: () => context.go('/'),
                  )
                  .animate()
                  .fadeIn(delay: 900.ms)
                  .scale(curve: Curves.easeOutBack),
              const SizedBox(height: 24),
              const AuthDivider(),
              const SizedBox(height: 24),
              const SocialLoginButton(),
              const SizedBox(height: 32),
              TextButton(
                onPressed: () => context.pop(),
                child: RichText(
                  text: const TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "Sign in",
                        style: TextStyle(
                          color: AppTheme.primaryGoldLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 1100.ms),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
