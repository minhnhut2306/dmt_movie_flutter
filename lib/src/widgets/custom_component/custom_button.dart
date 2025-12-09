import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPress,
    this.isSmall = false,
    this.isOutlineButton = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.width,
    this.isDisabled = false,
    this.isLoading = false,
    this.borderColor,
    this.borderWidth,
    this.elevation,
  });

  final String title;
  final VoidCallback onPress;
  final bool isSmall;
  final bool isOutlineButton;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final bool isDisabled;
  final bool isLoading;
  final Color? borderColor;
  final double? borderWidth;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? (isSmall ? null : double.infinity),
      height: height,
      child: ElevatedButton(
        onPressed: (isDisabled || isLoading) ? null : onPress,
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? (isOutlineButton ? 0 : 2),
          side: isOutlineButton
              ? BorderSide(
                  color: borderColor ?? Colors.black,
                  width: borderWidth ?? 1,
                )
              : (borderColor != null
                  ? BorderSide(
                      color: borderColor!,
                      width: borderWidth ?? 1,
                    )
                  : null),
          backgroundColor: isDisabled
              ? Colors.grey.shade400
              : backgroundColor ??
                  (isOutlineButton
                      ? Colors.white
                      : Theme.of(context).primaryColor),
          disabledBackgroundColor: Colors.grey.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16),
          ),
          padding: padding ??
              (isSmall
                  ? const EdgeInsets.symmetric(vertical: 8, horizontal: 20)
                  : const EdgeInsets.symmetric(vertical: 14)),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ??
                        (isOutlineButton ? Colors.black : Colors.white),
                  ),
                ),
              )
            : Row(
                mainAxisSize: isSmall ? MainAxisSize.min : MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: isDisabled
                          ? Colors.grey.shade600
                          : textColor ??
                              (isOutlineButton ? Colors.black : Colors.white),
                      size: isSmall ? 16 : 20,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    isSmall ? title : title.toUpperCase(),
                    style: isSmall
                        ? Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: isDisabled
                                  ? Colors.grey.shade600
                                  : textColor ??
                                      (isOutlineButton ? Colors.black : null),
                              fontSize: fontSize,
                              fontWeight: fontWeight,
                            )
                        : Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: isDisabled
                                  ? Colors.grey.shade600
                                  : textColor ??
                                      (isOutlineButton ? Colors.black : null),
                              fontWeight: fontWeight ??
                                  (isOutlineButton
                                      ? FontWeight.w500
                                      : FontWeight.bold),
                              fontSize: fontSize,
                            ),
                  ),
                ],
              ),
      ),
    );
  }
}