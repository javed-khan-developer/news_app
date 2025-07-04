import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 48,
    this.borderRadius = 8,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: backgroundColor ?? theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onPressed,
        splashColor: Colors.white24,
        child: Container(
          height: height,
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: textColor ?? theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
