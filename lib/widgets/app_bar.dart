import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/view/bookmark/bookmark_view.dart';

import '../controller/theme_controller.dart';
import '../routes/app_pages.dart';
import 'app_text.dart';

AppBar buildAppBar({
  required String title,
  VoidCallback? onRefresh,
  double? fontSize,
  bool? showRefresh = false,
  bool? showHome = false,
  bool? centreTitle = false,
  bool? showBookmarked = true,
}) {
  final ThemeController themeController = Get.find<ThemeController>();

  return AppBar(
    title: AppText(title, fontSize: fontSize),
    centerTitle: centreTitle,
    actions: [
      if (showRefresh == true)
        IconButton(icon: const Icon(Icons.refresh), onPressed: onRefresh),
      if (showHome == true)
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Get.offAllNamed(Routes.home),
        ),
      Obx(() {
        final isDark = themeController.themeMode.value == ThemeMode.dark;
        return IconButton(
          icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
          onPressed: themeController.toggleTheme,
          tooltip: 'Toggle Theme',
        );
      }),
      if (showBookmarked == true)
        IconButton(
          icon: const Icon(Icons.bookmark),
          onPressed:
              () => Get.to(
                () => BookmarkView(),
                transition: Transition.leftToRight,
              ),
        ),
    ],
  );
}
