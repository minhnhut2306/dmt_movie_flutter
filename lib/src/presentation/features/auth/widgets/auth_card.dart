import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';

class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: AppDimensions.borderWidth,
        ),
      ),
      child: child,
    );
  }
}