import 'package:flutter/material.dart';
import '../responsive/responsive.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) => context.isMobile;
  static bool isTablet(BuildContext context) => context.isTablet;
  static bool isDesktop(BuildContext context) => context.isDesktop;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: (_) => mobile,
      tablet: tablet != null ? (_) => tablet! : null,
      desktop: (_) => desktop,
    );
  }
}
