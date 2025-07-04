import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  const AppText(
      this.text, {
        super.key,
        this.fontSize,
        this.fontWeight,
        this.color,
        this.textAlign,
        this.maxLines,
      });

  @override
  Widget build(BuildContext context) {
    final defaultColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

    return Text(
      text,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? 16.sp,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? defaultColor,
      ),
    );
  }
}
