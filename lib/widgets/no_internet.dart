import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app/widgets/app_text.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // or: final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, size: 80.sp, color: theme.colorScheme.error),
            SizedBox(height: 16.h),
            AppText(
              "No Internet Connection",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onBackground,
            ),
            SizedBox(height: 8.h),
            AppText(
              "Please check your network and try again.",
              textAlign: TextAlign.center,
              color: theme.textTheme.bodyMedium?.color ?? Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
