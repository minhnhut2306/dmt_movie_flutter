import 'package:flutter/material.dart';
import '../../../core/responsive.dart';

class LoadingSpinner extends StatelessWidget {
  final double? size;
  final double? strokeWidth;
  final Color? color;

  const LoadingSpinner({
    super.key,
    this.size,
    this.strokeWidth,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size ?? Responsive.size40(context);
    final effectiveStrokeWidth = strokeWidth ?? Responsive.responsive<double>(
      context,
      mobile: 3.0,
      tablet: 3.5,
      largeTablet: 4.0,
    );

    return Center(
      child: SizedBox(
        width: effectiveSize,
        height: effectiveSize,
        child: CircularProgressIndicator(
          strokeWidth: effectiveStrokeWidth,
          valueColor: color != null 
            ? AlwaysStoppedAnimation<Color>(color!) 
            : null,
        ),
      ),
    );
  }
}