import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/gold_gradient_button.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_logo_header.dart';
import '../widgets/auth_title.dart';
import '../widgets/auth_footer_link.dart';
import '../viewmodels/auth_cubit.dart';
import '../viewmodels/auth_state.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isEmailLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        CustomSnackBar.showError(context, 'Passwords do not match!');
        return;
      }
      setState(() => _isEmailLoading = true);
      context.read<AuthCubit>().signUpWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final showTwoPanes = context.screenWidth > 900;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is! AuthLoading) setState(() => _isEmailLoading = false);
        if (state is Authenticated) {
          context.go('/');
        } else if (state is AuthActionSuccess) {
          CustomSnackBar.showSuccess(context, state.message);
          context.pop();
        } else if (state is AuthError) {
          CustomSnackBar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        final formFieldsAndActions = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: _nameController,
              hintText: 'Full Name',
              prefixIcon: Icons.person_outline,
              fieldHeight: 52,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              validator: (val) => val == null || val.isEmpty
                  ? 'Please enter your name'
                  : null,
            ).animate().fadeIn(delay: 350.ms),
            const SizedBox(height: 14),
            CustomTextField(
              controller: _emailController,
              hintText: 'Email',
              prefixIcon: Icons.email_outlined,
              fieldHeight: 52,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              validator: (val) => val == null || val.isEmpty
                  ? 'Please enter your email'
                  : null,
            ).animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 14),
            CustomTextField(
              controller: _phoneController,
              hintText: 'Guardian Phone (WhatsApp)',
              prefixIcon: Icons.phone_outlined,
              fieldHeight: 52,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.telephoneNumber],
              validator: (val) => val == null || val.isEmpty
                  ? 'Please enter your phone number'
                  : null,
            ).animate().fadeIn(delay: 450.ms),
            const SizedBox(height: 14),
            CustomTextField(
              controller: _passwordController,
              hintText: 'Password',
              prefixIcon: Icons.lock_outline,
              fieldHeight: 52,
              isPassword: true,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
              validator: (val) => val == null || val.length < 6
                  ? 'Password must be 6+ characters'
                  : null,
            ).animate().fadeIn(delay: 500.ms),
            const SizedBox(height: 14),
            CustomTextField(
              controller: _confirmPasswordController,
              hintText: 'Confirm Password',
              prefixIcon: Icons.lock_outline,
              fieldHeight: 52,
              isPassword: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              onFieldSubmitted: (_) => _onSignUp(),
              validator: (val) => val == null || val.isEmpty
                  ? 'Please confirm your password'
                  : null,
            ).animate().fadeIn(delay: 550.ms),
            const SizedBox(height: 24),
            PrimaryGradientButton(
              text: 'Sign Up',
              height: 52,
              isLoading: _isEmailLoading,
              onPressed: isLoading ? null : _onSignUp,
            ).animate().fadeIn(delay: 600.ms).scale(curve: Curves.easeOutBack),
            const SizedBox(height: 20),
            AuthFooterLink(
              normalText: 'Already have an account? ',
              linkText: 'Sign in',
              onTap: () => context.pop(),
            ),
          ],
        );

        Widget bodyContent;

        if (showTwoPanes) {
          bodyContent = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Pane: Logo, Title, Subtitle
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    AuthLogoHeader(logoSize: 90),
                    SizedBox(height: 20),
                    AuthTitle(
                      title: 'Create Account',
                      subtitle: 'Join the ultimate coding journey',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48),

              // Right Pane: 5 Fields + Button + Footer
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: formFieldsAndActions,
              ),
            ],
          );
        } else {
          bodyContent = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              AuthLogoHeader(
                logoSize: (context.shortestSide * 0.12).clamp(56.0, 84.0),
              ),
              const SizedBox(height: 16),
              const AuthTitle(
                title: 'Create Account',
                subtitle: 'Join the ultimate coding journey',
              ),
              const SizedBox(height: 24),
              formFieldsAndActions,
            ],
          );
        }

        return AuthScaffold(
          showBack: true,
          child: Form(
            key: _formKey,
            child: bodyContent,
          ),
        );
      },
    );
  }
}
