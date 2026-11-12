import 'package:flutter/material.dart';
import 'breakpoints.dart';

typedef ResponsiveWidgetBuilder = Widget Function(
  BuildContext context,
  BoxConstraints constraints,
  DeviceType deviceType,
);

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context)? mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;
  final ResponsiveWidgetBuilder? builder;

  const ResponsiveBuilder({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = Breakpoints.getDeviceType(constraints.maxWidth);

        if (builder != null) {
          return builder!(context, constraints, deviceType);
        }

        switch (deviceType) {
          case DeviceType.desktop:
            if (desktop != null) return desktop!(context);
            if (tablet != null) return tablet!(context);
            return mobile!(context);
          case DeviceType.tablet:
            if (tablet != null) return tablet!(context);
            return mobile!(context);
          case DeviceType.mobile:
            return mobile!(context);
        }
      },
    );
  }
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get shortestSide => MediaQuery.sizeOf(this).shortestSide;

  Orientation get orientation => MediaQuery.orientationOf(this);
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;

  DeviceType get deviceType => Breakpoints.getDeviceType(screenWidth);

  bool get isMobile => screenWidth < Breakpoints.tabletMin;
  bool get isTablet =>
      screenWidth >= Breakpoints.tabletMin &&
      screenWidth <= Breakpoints.tabletMax;
  bool get isDesktop => screenWidth > Breakpoints.tabletMax;

  bool get isTabletLandscape => isTablet && isLandscape;
  bool get isTabletPortrait => isTablet && isPortrait;
}
