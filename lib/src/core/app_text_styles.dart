import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Font Sizes
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 11.0;
  static const double fontSizeM = 12.0;
  static const double fontSizeBase = 13.0;
  static const double fontSizeL = 14.0;
  static const double fontSizeXL = 15.0;
  static const double fontSize2XL = 16.0;
  static const double fontSize3XL = 18.0;
  static const double fontSize4XL = 20.0;
  static const double fontSize5XL = 22.0;
  static const double fontSize6XL = 24.0;
  static const double fontSize7XL = 28.0;
  static const double fontSize8XL = 32.0;

  // Display Styles
  static const displayLarge = TextStyle(
    fontSize: fontSize8XL,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.2,
  );
  
  static const displayMedium = TextStyle(
    fontSize: fontSize7XL,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.3,
  );
  
  static const displaySmall = TextStyle(
    fontSize: fontSize6XL,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.3,
  );
  
  // Heading Styles
  static const headingLarge = TextStyle(
    fontSize: fontSize5XL,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.4,
  );
  
  static const heading = TextStyle(
    fontSize: fontSize4XL,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  static const headingSmall = TextStyle(
    fontSize: fontSize3XL,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  // Body Styles
  static const bodyLarge = TextStyle(
    fontSize: fontSize2XL,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  static const body = TextStyle(
    fontSize: fontSizeL,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  static const bodySmall = TextStyle(
    fontSize: fontSizeM,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
  
  // Label Styles
  static const labelLarge = TextStyle(
    fontSize: fontSizeL,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  static const label = TextStyle(
    fontSize: fontSizeM,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  static const labelSmall = TextStyle(
    fontSize: fontSizeXS,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );
  
  // Navigation Label Styles
  static const navLabel = TextStyle(
    fontSize: fontSizeM,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );
  
  static const navLabelSelected = TextStyle(
    fontSize: fontSizeM,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
  
  static const navLabelTablet = TextStyle(
    fontSize: fontSizeBase,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );
  
  static const navLabelTabletSelected = TextStyle(
    fontSize: fontSizeBase,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  // Button Styles
  static const button = TextStyle(
    fontSize: fontSizeL,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
  
  static const buttonLarge = TextStyle(
    fontSize: fontSize2XL,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
  
  static const buttonSmall = TextStyle(
    fontSize: fontSizeM,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
  
  // Caption Style
  static const caption = TextStyle(
    fontSize: fontSizeS,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );
  
  // Helper Methods
  static TextStyle getNavLabelStyle({
    required bool isSelected,
    required bool isTablet,
    required bool isDark,
  }) {
    final baseStyle = isTablet
        ? (isSelected ? navLabelTabletSelected : navLabelTablet)
        : (isSelected ? navLabelSelected : navLabel);
        
    final color = isSelected
        ? AppColors.primary
        : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary);
        
    return baseStyle.copyWith(color: color);
  }
  
  static TextStyle getTextStyle({
    required TextStyle baseStyle,
    required bool isDark,
    bool isPrimary = false,
    bool isSecondary = false,
  }) {
    Color textColor;
    
    if (isPrimary) {
      textColor = AppColors.primary;
    } else if (isSecondary) {
      textColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    } else {
      textColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    }
    
    return baseStyle.copyWith(color: textColor);
  }
}