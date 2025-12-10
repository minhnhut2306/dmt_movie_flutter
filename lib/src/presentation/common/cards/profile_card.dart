import 'package:flutter/material.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/constants/app_dimensions.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final Color borderColor;
  final VoidCallback? onTap;

  const ProfileCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppDimensions.avatarL,
            height: AppDimensions.avatarL,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: 74,
                height: 74,
              ),
            ),
          ),
          SizedBox(height: AppDimensions.spacingS),
          Text(
            name,
            style: const TextStyle(
              fontSize: AppTextStyles.fontSizeL,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}