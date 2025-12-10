import 'package:flutter/material.dart';
import '../../../core/responsive.dart';

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
    final avatarSize = Responsive.avatarLarge(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor,
                width: Responsive.responsive<double>(
                  context,
                  mobile: 3,
                  tablet: 3.5,
                  largeTablet: 4,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: Responsive.responsive<double>(
                    context,
                    mobile: 8,
                    tablet: 10,
                    largeTablet: 12,
                  ),
                  spreadRadius: 0,
                  offset: Offset(0, Responsive.responsive<double>(
                    context,
                    mobile: 3,
                    tablet: 4,
                    largeTablet: 5,
                  )),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: avatarSize,
                height: avatarSize,
              ),
            ),
          ),
          SizedBox(height: Responsive.spacingS(context)),
          Text(
            name,
            style: TextStyle(
              fontSize: Responsive.bodyFontSize(context),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}