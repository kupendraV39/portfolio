import 'package:flutter/material.dart';

/// Breakpoint helper — mirrors the Tailwind sm / md / xl prefixes
/// used throughout the React project.
///
///  Mobile  : < 640 px   (default / xs)
///  Tablet  : 640–1279 px (sm / md)
///  Desktop : ≥ 1280 px   (xl)
class Responsive {
  Responsive._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 640;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= 640 && w < 1280;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1280;

  static bool isTabletOrDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 640;

  /// Horizontal page padding — mirrors styles.paddingX from styles.ts
  static double paddingH(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= 1280) return w * 0.06;
    if (w >= 640)  return w * 0.05;
    return 16.0;
  }

  /// Section vertical padding — mirrors styles.padding / styles.sectionHeadText
  static EdgeInsets sectionPadding(BuildContext context) {
    final ph = paddingH(context);
    return EdgeInsets.symmetric(horizontal: ph, vertical: isMobile(context) ? 60 : 100);
  }

  /// Card grid cross-axis count for different sections
  static int serviceGridCount(BuildContext context) {
    if (isDesktop(context)) return 4;
    if (isTablet(context))  return 2;
    return 1;
  }

  static int projectGridCount(BuildContext context) {
    if (isDesktop(context)) return 3;
    if (isTablet(context))  return 2;
    return 1;
  }

  static int techGridCount(BuildContext context) {
    if (isDesktop(context)) return 7;
    if (isTablet(context))  return 5;
    return 3;
  }
}
