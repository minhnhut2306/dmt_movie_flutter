import 'package:flutter/material.dart';
import '../../../core/constants/app_dimensions.dart';

class OutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final double? height;

  const OutlineButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.borderColor,
    this.textColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBorderColor = borderColor ?? Colors.black;
    final effectiveTextColor = textColor ?? Colors.black;

    return SizedBox(
      width: width,
      height: height ?? AppDimensions.buttonHeightS,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: effectiveBorderColor,
            width: AppDimensions.borderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          backgroundColor: Colors.white,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: effectiveTextColor, size: AppDimensions.iconXS),
                    SizedBox(width: AppDimensions.spacingS),
                  ],
                  Text(
                    title,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: effectiveTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}