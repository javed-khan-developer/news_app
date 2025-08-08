import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  final supportedLocales = const [Locale('en'), Locale('hi')];
  final Rx<Locale> currentLocale = Locale('en').obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with the current locale from EasyLocalization
    currentLocale.value = Get.locale ?? const Locale('en');
  }

  void syncWithEasyLocalization(Locale locale) {
    currentLocale.value = locale;
  }

  void changeLanguage(Locale newLocale, BuildContext context) async {
    try {
      print('Changing language to: ${newLocale.languageCode}');
      
      // Set the locale using EasyLocalization
      await context.setLocale(newLocale);
      
      // Update the controller's current locale
      currentLocale.value = newLocale;
      
      // Force rebuild of the app to reflect language changes
      Get.forceAppUpdate();
      
      print('Language changed successfully to: ${newLocale.languageCode}');
      
    } catch (e) {
      print('Error changing language: $e');
    }
  }

  String get currentLanguageCode => currentLocale.value.languageCode;
  
  String get currentLanguageName {
    switch (currentLocale.value.languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'Hindi';
      default:
        return 'English';
    }
  }
  
  bool isCurrentLanguage(String languageCode) {
    return currentLocale.value.languageCode == languageCode;
  }
}
