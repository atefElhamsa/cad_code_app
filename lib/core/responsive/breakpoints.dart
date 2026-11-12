enum DeviceType { mobile, tablet, desktop }

class Breakpoints {
  static const double mobileMax = 599.0;
  static const double tabletMin = 600.0;
  static const double tabletMax = 1024.0;
  static const double desktopMin = 1025.0;

  static DeviceType getDeviceType(double width) {
    if (width < tabletMin) {
      return DeviceType.mobile;
    } else if (width <= tabletMax) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }
}
