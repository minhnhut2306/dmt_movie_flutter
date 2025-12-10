import 'package:dmt_movie_flutter/src/core/app_colors.dart';
import 'package:dmt_movie_flutter/src/core/responsive.dart';
import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: Responsive.cardPadding(context),
      decoration: BoxDecoration(
        color: isDark 
          ? Colors.white.withOpacity(0.08)
          : Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(Responsive.radiusXL(context)),
        border: Border.all(
          color: isDark 
            ? Colors.white.withOpacity(0.1)
            : AppColors.border.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}