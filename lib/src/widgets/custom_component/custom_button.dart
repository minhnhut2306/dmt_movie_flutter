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
  });

  final String title;
  final VoidCallback onPress;
  final bool isSmall;
  final bool isOutlineButton;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isSmall ? null : double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          side: isOutlineButton
              ? BorderSide(color: Colors.black, width: 1)
              : null,
          backgroundColor: backgroundColor ??
              (isOutlineButton ? Colors.white : Theme.of(context).primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: isSmall
              ? EdgeInsets.symmetric(vertical: 1, horizontal: 20)
              : EdgeInsets.symmetric(vertical: 14),
        ),
        child: Row(
          mainAxisSize: isSmall ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: textColor ??
                    (isOutlineButton ? Colors.black : Colors.white),
                size: isSmall ? 16 : 20,
              ),
              SizedBox(width: 8),
            ],
            Text(
              isSmall ? title : title.toUpperCase(),
              style: isSmall
                  ? Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: textColor ??
                          (isOutlineButton ? Colors.black : null))
                  : Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: textColor ??
                          (isOutlineButton ? Colors.black : null),
                      fontWeight: isOutlineButton ? FontWeight.w500 : null),
            ),
          ],
        ),
      ),
    );
  }
}