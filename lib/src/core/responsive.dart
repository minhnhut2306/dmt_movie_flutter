import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  static const double tabletBreakpoint = 768;
  static const double largeTabletBreakpoint = 1024;
  
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  
  static bool isMobile(BuildContext context) => width(context) < tabletBreakpoint;
  static bool isTablet(BuildContext context) => 
      width(context) >= tabletBreakpoint && width(context) < largeTabletBreakpoint;
  static bool isLargeTablet(BuildContext context) => width(context) >= largeTabletBreakpoint;
  
  static bool isTabletOrLarger(BuildContext context) => width(context) >= tabletBreakpoint;
  
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    required T tablet,
    T? largeTablet,
  }) {
    if (isLargeTablet(context) && largeTablet != null) {
      return largeTablet;
    } else if (isTabletOrLarger(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }
  
  // ============= PADDING & MARGIN =============
  
  static EdgeInsets pagePadding(BuildContext context) {
    return responsive<EdgeInsets>(
      context,
      mobile: const EdgeInsets.all(16),
      tablet: const EdgeInsets.all(24),
      largeTablet: const EdgeInsets.all(32),
    );
  }
  
  static EdgeInsets cardPadding(BuildContext context) {
    return responsive<EdgeInsets>(
      context,
      mobile: const EdgeInsets.all(16),
      tablet: const EdgeInsets.all(20),
      largeTablet: const EdgeInsets.all(24),
    );
  }
  
  static EdgeInsets horizontalPadding(BuildContext context) {
    return responsive<EdgeInsets>(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 16),
      tablet: const EdgeInsets.symmetric(horizontal: 24),
      largeTablet: const EdgeInsets.symmetric(horizontal: 32),
    );
  }
  
  static EdgeInsets verticalPadding(BuildContext context) {
    return responsive<EdgeInsets>(
      context,
      mobile: const EdgeInsets.symmetric(vertical: 16),
      tablet: const EdgeInsets.symmetric(vertical: 20),
      largeTablet: const EdgeInsets.symmetric(vertical: 24),
    );
  }
  
  // ============= BOTTOM NAVIGATION =============
  
  static double bottomNavHeight(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 90,
      tablet: 95,
      largeTablet: 100,
    );
  }
  
  static double bottomNavMargin(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 16,
      tablet: 20,
      largeTablet: 24,
    );
  }
  
  static double bottomNavBorderRadius(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 8,
      tablet: 36,
      largeTablet: 8,
    );
  }
  
  static double iconSize(BuildContext context, {bool isSelected = false}) {
    final baseSize = responsive<double>(
      context,
      mobile: 24,
      tablet: 26,
      largeTablet: 28,
    );
    return isSelected ? baseSize + 2 : baseSize;
  }
  
  static double centerIconSize(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 30,
      tablet: 32,
      largeTablet: 34,
    );
  }
  
  static double centerIconContainerSize(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 64,
      tablet: 68,
      largeTablet: 72,
    );
  }
  
  // ============= TEXT & FONT SIZES =============
  
  static double fontSize(BuildContext context, double base) {
    return responsive<double>(
      context,
      mobile: base,
      tablet: base + 1,
      largeTablet: base + 2,
    );
  }
  
  static double titleFontSize(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 28,
      tablet: 32,
      largeTablet: 36,
    );
  }
  
  static double headingFontSize(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 20,
      tablet: 22,
      largeTablet: 24,
    );
  }
  
  static double bodyFontSize(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 14,
      tablet: 15,
      largeTablet: 16,
    );
  }
  
  static double captionFontSize(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 11,
      tablet: 12,
      largeTablet: 13,
    );
  }
  
  // ============= SPACING =============
  
  static double spacing(BuildContext context, double base) {
    return responsive<double>(
      context,
      mobile: base,
      tablet: base * 1.2,
      largeTablet: base * 1.4,
    );
  }
  
  static double spacingXS(BuildContext context) => spacing(context, 4);
  static double spacingS(BuildContext context) => spacing(context, 8);
  static double spacingM(BuildContext context) => spacing(context, 16);
  static double spacingL(BuildContext context) => spacing(context, 24);
  static double spacingXL(BuildContext context) => spacing(context, 32);
  static double spacing2XL(BuildContext context) => spacing(context, 40);
  static double spacing3XL(BuildContext context) => spacing(context, 48);
  
  // ============= BORDER RADIUS =============
  
  static double radius(BuildContext context, double base) {
    return responsive<double>(
      context,
      mobile: base,
      tablet: base * 1.1,
      largeTablet: base * 1.2,
    );
  }
  
  static double radiusXS(BuildContext context) => radius(context, 4);
  static double radiusS(BuildContext context) => radius(context, 8);
  static double radiusM(BuildContext context) => radius(context, 12);
  static double radiusL(BuildContext context) => radius(context, 16);
  static double radiusXL(BuildContext context) => radius(context, 20);
  static double radius2XL(BuildContext context) => radius(context, 24);
  
  // ============= BUTTON SIZES =============
  
  static double buttonHeight(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 48,
      tablet: 52,
      largeTablet: 56,
    );
  }
  
  static double buttonHeightSmall(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 40,
      tablet: 44,
      largeTablet: 48,
    );
  }
  
  static double buttonHeightLarge(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 56,
      tablet: 60,
      largeTablet: 64,
    );
  }
  
  // ============= INPUT SIZES =============
  
  static double inputHeight(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 56,
      tablet: 60,
      largeTablet: 64,
    );
  }
  
  // ============= AVATAR & IMAGE SIZES =============
  
  static double avatarSmall(BuildContext context) => size(context, 40);
  static double avatarMedium(BuildContext context) => size(context, 60);
  static double avatarLarge(BuildContext context) => size(context, 80);
  static double avatarXLarge(BuildContext context) => size(context, 100);
  
  // ============= CARD SIZES =============
  
  static double cardElevation(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 2,
      tablet: 3,
      largeTablet: 4,
    );
  }
  
  // ============= ANIMATION =============
  
  static Duration animationDuration(BuildContext context, {bool isLong = false}) {
    final baseDuration = isLong ? 400 : 200;
    final multiplier = responsive<double>(
      context,
      mobile: 1.0,
      tablet: 0.9,
      largeTablet: 0.8,
    );
    return Duration(milliseconds: (baseDuration * multiplier).round());
  }
  
  // ============= GRID & LAYOUT =============
  
  static int crossAxisCount(BuildContext context, {
    int mobile = 2,
    int tablet = 3,
    int largeTablet = 4,
  }) {
    return responsive<int>(
      context,
      mobile: mobile,
      tablet: tablet,
      largeTablet: largeTablet,
    );
  }
  
  static double maxContentWidth(BuildContext context) {
    return responsive<double>(
      context,
      mobile: double.infinity,
      tablet: 800,
      largeTablet: 1000,
    );
  }
  
  static double gridSpacing(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 12,
      tablet: 16,
      largeTablet: 20,
    );
  }
  
  // ============= EFFECTS =============
  
  static double blurIntensity(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 12,
      tablet: 15,
      largeTablet: 18,
    );
  }
  
  static double shadowBlurRadius(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 24,
      tablet: 28,
      largeTablet: 32,
    );
  }
  
  static Offset shadowOffset(BuildContext context) {
    return responsive<Offset>(
      context,
      mobile: const Offset(0, 4),
      tablet: const Offset(0, 6),
      largeTablet: const Offset(0, 8),
    );
  }
  
  // ============= COMMON SIZE HELPERS =============
  
  static double size(BuildContext context, double mobile, {double? tablet, double? largeTablet}) {
    return responsive<double>(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.15,
      largeTablet: largeTablet ?? mobile * 1.3,
    );
  }
  
  // Predefined common sizes
  static double size16(BuildContext context) => size(context, 16);
  static double size20(BuildContext context) => size(context, 20);
  static double size24(BuildContext context) => size(context, 24);
  static double size32(BuildContext context) => size(context, 32);
  static double size40(BuildContext context) => size(context, 40);
  static double size48(BuildContext context) => size(context, 48);
  static double size56(BuildContext context) => size(context, 56);
  static double size60(BuildContext context) => size(context, 60);
  static double size64(BuildContext context) => size(context, 64);
  static double size72(BuildContext context) => size(context, 72);
  static double size74(BuildContext context) => size(context, 74);
  static double size80(BuildContext context) => size(context, 80);
  static double size96(BuildContext context) => size(context, 96);
  static double size100(BuildContext context) => size(context, 100);
  static double size120(BuildContext context) => size(context, 120);
  
  // ============= APP BAR =============
  
  static double appBarHeight(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 56,
      tablet: 60,
      largeTablet: 64,
    );
  }
  
  // ============= AUTH SCREENS =============
  
  static double authBackgroundHeight(BuildContext context) {
    return height(context) * responsive<double>(
      context,
      mobile: 0.48,
      tablet: 0.45,
      largeTablet: 0.42,
    );
  }
  
  static double authHeaderOffset(BuildContext context) {
    return responsive<double>(
      context,
      mobile: -150,
      tablet: -170,
      largeTablet: -190,
    );
  }
  
  // ============= PROFILE SCREENS =============
  
  static double profileGridSpacing(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 40,
      tablet: 48,
      largeTablet: 56,
    );
  }
  
  static double profileRowSpacing(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 30,
      tablet: 36,
      largeTablet: 42,
    );
  }
}