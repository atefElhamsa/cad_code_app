import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_theme.dart';
import '../../auth/presentation/viewmodels/auth_cubit.dart';
import '../../auth/presentation/viewmodels/auth_state.dart';
import '../widgets/animated_splash_text.dart';
import '../widgets/splash_logo.dart';
import '../widgets/splash_orbs.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  static const _splashDuration = Duration(milliseconds: 3500);
  bool _timerDone = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppTheme.backgroundDarkNavy,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    Future.delayed(_splashDuration, () {
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
    final shortest = context.shortestSide;
    final titleFontSize = (shortest * 0.078).clamp(30.0, 44.0);

    final textStyle = GoogleFonts.inter(
      fontSize: titleFontSize,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.8,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SplashLogo(),
                  SizedBox(height: (shortest * 0.03).clamp(18.0, 28.0)),
                  AnimatedSplashText(
                    text: 'C&C Academy',
                    style: textStyle,
                    delayOffset: 500,
                  ),
                  SizedBox(height: (shortest * 0.022).clamp(12.0, 20.0)),
                  Text(
                    'LEARN  •  CODE  •  CREATE',
                    style: GoogleFonts.inter(
                      fontSize: (shortest * 0.028).clamp(10.0, 12.0),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.8,
                      color: Colors.white.withValues(alpha: 0.45),
                    ),
                  ).animate().fadeIn(delay: 1200.ms, duration: 500.ms),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.paddingOf(context).bottom + 40,
              child: const Center(child: _SplashProgressBar()),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashProgressBar extends StatelessWidget {
  const _SplashProgressBar();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 3200),
      curve: Curves.easeInOutCubic,
      builder: (context, value, _) {
        return SizedBox(
          width: 120,
          height: 3,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppTheme.primaryGoldLight.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    gradient: AppTheme.goldGradient,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
