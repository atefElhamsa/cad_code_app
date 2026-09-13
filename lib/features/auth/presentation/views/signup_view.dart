import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/gold_gradient_button.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../widgets/signup_logo.dart';
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
    return Scaffold(
      backgroundColor: AppTheme.backgroundDarkNavy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppTheme.primaryGoldLight),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
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

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24, 10, 24, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SignupLogo(),
                        SizedBox(height: 30.h,),
                        const AuthTitle(
                          title: 'Create Account',
                          subtitle: 'Join the ultimate coding journey',
                        ),
                        SizedBox(height: 40.h,),
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Full Name',
                          prefixIcon: Icons.person_outline,
                          validator: (val) => val == null || val.isEmpty
                              ? 'Please enter your name'
                              : null,
                        ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.2, curve: Curves.easeOut),
                        SizedBox(height: 16.h,),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => val == null || val.isEmpty
                              ? 'Please enter your email'
                              : null,
                        ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.2, curve: Curves.easeOut),
                        SizedBox(height: 16.h,),
                        CustomTextField(
                          controller: _phoneController,
                          hintText: 'Guardian Phone (WhatsApp)',
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (val) => val == null || val.isEmpty
                              ? 'Please enter your phone number'
                              : null,
                        ).animate().fadeIn(delay: 600.ms).slideX(begin: 0.2, curve: Curves.easeOut),
                        SizedBox(height: 16.h,),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          validator: (val) => val == null || val.length < 6
                              ? 'Password must be 6+ characters'
                              : null,
                        ).animate().fadeIn(delay: 700.ms).slideX(begin: -0.2, curve: Curves.easeOut),
                        SizedBox(height: 16.h,),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirm Password',
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          validator: (val) => val == null || val.isEmpty
                              ? 'Please confirm your password'
                              : null,
                        ).animate().fadeIn(delay: 800.ms).slideX(begin: 0.2, curve: Curves.easeOut),
                        SizedBox(height: 40.h,),
                        PrimaryGradientButton(
                          text: 'Sign Up',
                          isLoading: _isEmailLoading,
                          onPressed: isLoading ? null : _onSignUp,
                        ).animate().fadeIn(delay: 900.ms).scale(curve: Curves.easeOutBack),
                        SizedBox(height: 25.h,),
                        AuthFooterLink(
                          normalText: 'Already have an account? ',
                          linkText: 'Sign in',
                          onTap: () => context.pop(),
                        ),
                        SizedBox(height: 40.h,),
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
