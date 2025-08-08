import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'controller/language_controller.dart';
import 'controller/network_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Initialize controllers before runApp
  Get.put(NetworkController());
  Get.put(LanguageController()); // ✅ move here

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('hi')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      saveLocale: true,
      child: MyApp(),
    ),
  );
}
