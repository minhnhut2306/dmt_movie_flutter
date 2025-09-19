import 'package:flutter/material.dart';

class Responsive {
  // Breakpoints
  static const double tabletBreakpoint = 768;
  static const double largeTabletBreakpoint = 1024;
  
  // Screen dimensions
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  
  // Device type detection
  static bool isMobile(BuildContext context) => width(context) < tabletBreakpoint;
  static bool isTablet(BuildContext context) => 
      width(context) >= tabletBreakpoint && width(context) < largeTabletBreakpoint;
  static bool isLargeTablet(BuildContext context) => width(context) >= largeTabletBreakpoint;
  
  // For navigation purposes, treat large tablets as tablets
  static bool isTabletOrLarger(BuildContext context) => width(context) >= tabletBreakpoint;
  
  // Responsive values
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
  
  // Padding and margins
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
  
  // Navigation dimensions
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
      mobile: 32,
      tablet: 36,
      largeTablet: 40,
    );
  }
  
  // Icon sizes
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
  
  // Animation durations
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
  
  // Grid and layout
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
  
  // Max width for content
  static double maxContentWidth(BuildContext context) {
    return responsive<double>(
      context,
      mobile: double.infinity,
      tablet: 800,
      largeTablet: 1000,
    );
  }
  
  // Blur intensity for glassmorphism
  static double blurIntensity(BuildContext context) {
    return responsive<double>(
      context,
      mobile: 12,
      tablet: 15,
      largeTablet: 18,
    );
  }
  
  // Shadow properties
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
}