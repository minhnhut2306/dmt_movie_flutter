import 'package:flutter/material.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/responsive.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundHeight = Responsive.authBackgroundHeight(context);

    return SizedBox(
      height: backgroundHeight,
      child: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark ? [
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.9),
                  Colors.black,
                ] : [
                  const Color(0xFFF8F9FA).withOpacity(0.0),
                  const Color(0xFFF8F9FA).withOpacity(0.3),
                  const Color(0xFFF8F9FA).withOpacity(0.6),
                  const Color(0xFFF8F9FA).withOpacity(0.9),
                  const Color(0xFFF8F9FA),
                ],
                stops: const [0.0, 0.5, 0.7, 0.85, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}