import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app/routes/app_pages.dart';
import 'package:news_app/view/home/home_view.dart';
import 'package:news_app/widgets/no_internet.dart';
import 'controller/language_controller.dart';
import 'controller/network_controller.dart';
import 'controller/theme_controller.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder:
          (_, child) => Obx(() {
            final isConnected = Get.find<NetworkController>().isConnected.value;
            return GetMaterialApp(
              title: AppStrings.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeController.themeMode.value,
              home: isConnected ? HomeView() : const NoInternetWidget(),
              getPages: AppPages.routes,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              localizationsDelegates: context.localizationDelegates,
              builder: (context, child) {
                // ✅ Sync current locale with controller
                Get.find<LanguageController>().syncWithEasyLocalization(context.locale);
                return child!;
              },
            );
          }),
    );
  }
}
