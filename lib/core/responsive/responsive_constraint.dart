import 'package:flutter/material.dart';
import 'responsive_builder.dart';

class ResponsiveConstraint extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final double? mobileMaxWidth;
  final double? tabletMaxWidth;
  final double? desktopMaxWidth;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;

  const ResponsiveConstraint({
    super.key,
    required this.child,
    this.maxWidth,
    this.mobileMaxWidth,
    this.tabletMaxWidth,
    this.desktopMaxWidth,
    this.padding,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    double targetMaxWidth;

    if (maxWidth != null) {
      targetMaxWidth = maxWidth!;
    } else if (context.isDesktop) {
      targetMaxWidth = desktopMaxWidth ?? 800.0;
    } else if (context.isTablet) {
      targetMaxWidth = tabletMaxWidth ?? 680.0;
    } else {
      targetMaxWidth = mobileMaxWidth ?? double.infinity;
    }

    Widget content = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: targetMaxWidth),
      child: child,
    );

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    return Align(
      alignment: alignment,
      child: content,
    );
  }
}
