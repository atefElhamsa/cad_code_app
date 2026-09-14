import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/presentation/viewmodels/auth_cubit.dart';
import '../../auth/presentation/viewmodels/auth_state.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/splash_orbs.dart';
import '../widgets/splash_logo.dart';
import '../widgets/animated_splash_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _timerDone = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        setState(() {
          _timerDone = true;
        });
        _navigateBasedOnState(context.read<AuthCubit>().state);
      }
    });
  }

  void _navigateBasedOnState(AuthState state) {
    if (!_timerDone) return;

    if (state is Authenticated) {
      context.go('/');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w900,
      fontFamily: 'Inter',
    );
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        _navigateBasedOnState(state);
      },
      child: Scaffold(
        backgroundColor: AppTheme.backgroundDarkNavy,
        body: Stack(
          children: [
            const SplashOrbs(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SplashLogo(),
                  SizedBox(height: 25.h,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSplashText(
                        text: 'C&C',
                        style: textStyle,
                        delayOffset: 800,
                      ),
                      SizedBox(width: 8.w,),
                      AnimatedSplashText(
                        text: 'Academy',
                        style: textStyle,
                        delayOffset: 1010,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
