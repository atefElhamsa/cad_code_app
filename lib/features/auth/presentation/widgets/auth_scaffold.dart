import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_theme.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;
  final bool showBack;
  final VoidCallback? onBack;

  const AuthScaffold({
    super.key,
    required this.child,
    this.showBack = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscapeTablet = context.screenWidth > 900;
    final maxWidth = isLandscapeTablet
        ? 1000.0
        : (context.isTablet ? 440.0 : double.infinity);

    return Scaffold(
      backgroundColor: AppTheme.backgroundDarkNavy,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            if (showBack)
              PositionedDirectional(
                top: 8,
                start: 8,
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppTheme.primaryGoldLight,
                      size: context.isTablet ? 28 : 24,
                    ),
                    onPressed: onBack ?? () => context.pop(),
                  ),
                ),
              ),
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.symmetric(
                      horizontal: isLandscapeTablet ? 32 : 24,
                      vertical: 20,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: (constraints.maxHeight - 40).clamp(0.0, double.infinity),
                      ),
                      child: IntrinsicHeight(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: child,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
