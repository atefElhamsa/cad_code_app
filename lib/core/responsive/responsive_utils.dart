import 'package:flutter/material.dart';
import 'responsive_builder.dart';

extension BidiFixExtension on String {
  String get fixBidi {
    if (isEmpty) return this;

    String text = trim();

    final match = RegExp(
      r'^(C\s*\+\+|c\s*\+\+|C\s*#|c\s*#|\.NET|\.net|Flutter|flutter|Dart|dart|Python|python|Scratch|scratch|HTML|CSS|Java|JavaScript|PHP|SQL|Android|iOS)\s+([\u0600-\u06FF\s\d\.\,\:\!\?\-\_\(\)]+)$',
      caseSensitive: false,
    ).firstMatch(text);

    if (match != null) {
      final tech = match.group(1)!;
      final arabicText = match.group(2)!.trim();
      text = '$arabicText $tech';
    }

    return text.replaceAllMapped(
      RegExp(
        r'(C\s*\+\+|c\s*\+\+|C\s*#|c\s*#|\.NET|\.net|Node\.js|Vue\.js|Flutter|flutter|Dart|dart|Python|python|Scratch|scratch|Android|iOS|HTML|CSS|Java|JavaScript|TypeScript|PHP|SQL)',
        caseSensitive: false,
      ),
      (m) => '\u200E\u2066${m.group(0)}\u2069\u200E',
    );
  }
}

class ResponsiveUtils {
  static double getTabletScale(BuildContext context) {
    if (!context.isTablet) return 1.0;
    final shortest = context.shortestSide;
    return (shortest / 600.0).clamp(1.1, 1.25);
  }

  static double fontSize(
    BuildContext context,
    double baseSize, {
    double minScale = 1.0,
    double maxScale = 1.25,
  }) {
    if (context.isTablet) {
      final scaled = baseSize * getTabletScale(context);
      return scaled.clamp(baseSize * minScale, baseSize * maxScale);
    }
    return baseSize;
  }

  static TextScaler clampedTextScaler(BuildContext context) {
    return MediaQuery.textScalerOf(context).clamp(
      minScaleFactor: 1.0,
      maxScaleFactor: 1.3,
    );
  }

  static double iconSize(
    BuildContext context,
    double baseSize, {
    double maxScale = 1.2,
  }) {
    if (context.isTablet) {
      return (baseSize * getTabletScale(context)).clamp(baseSize, baseSize * maxScale);
    }
    return baseSize;
  }

  static double spaceXs(BuildContext context) => 4.0 * (context.isTablet ? 1.15 : 1.0);
  static double spaceSm(BuildContext context) => 8.0 * (context.isTablet ? 1.15 : 1.0);
  static double spaceMd(BuildContext context) => 12.0 * (context.isTablet ? 1.15 : 1.0);
  static double spaceLg(BuildContext context) => 16.0 * (context.isTablet ? 1.2 : 1.0);
  static double spaceXl(BuildContext context) => 24.0 * (context.isTablet ? 1.2 : 1.0);
  static double spaceXxl(BuildContext context) => 32.0 * (context.isTablet ? 1.25 : 1.0);
}
