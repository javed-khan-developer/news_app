import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

import '../controller/language_controller.dart';
import '../core/constants/app_colors.dart';
import 'app_text.dart';

class LanguageSwitcherWidget extends StatelessWidget {
  final controller = Get.find<LanguageController>();

  LanguageSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  Expanded(
                    child:                     AppText(
                      'Language Settings',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 48.sp), // Balance the back button
                ],
              ),
            ),
            
            // Language Selection Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.gradientStart, AppColors.gradientEnd],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.sp),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.language,
                            color: AppColors.white,
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.sp),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  'Choose Your Language',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                                AppText(
                                  'Select your preferred language for the app',
                                  fontSize: 14.sp,
                                  color: AppColors.white.withOpacity(0.8),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 24.sp),
                    
                    // Current Language Display
                    AppText(
                      'Current Language',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 12.sp),
                    Container(
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.sp),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: AppColors.white,
                              size: 16.sp,
                            ),
                          ),
                          SizedBox(width: 12.sp),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  _getLanguageName(context.locale.languageCode),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                AppText(
                                  context.locale.languageCode.toUpperCase(),
                                  fontSize: 12.sp,
                                  color: AppColors.textSecondary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 24.sp),
                    
                    // Available Languages
                    AppText(
                      'Available Languages',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 12.sp),
                    
                    // Language Options
                    ...controller.supportedLocales.map((locale) {
                      final isCurrent = context.locale.languageCode == locale.languageCode;
                      return Container(
                        margin: EdgeInsets.only(bottom: 12.sp),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _changeLanguage(locale, context),
                            borderRadius: BorderRadius.circular(12.sp),
                            child: Container(
                              padding: EdgeInsets.all(16.sp),
                              decoration: BoxDecoration(
                                color: isCurrent 
                                    ? AppColors.primary.withOpacity(0.1)
                                    : Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(
                                  color: isCurrent 
                                      ? AppColors.primary.withOpacity(0.3)
                                      : AppColors.cardShadow,
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.cardShadow,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.sp,
                                    height: 40.sp,
                                    decoration: BoxDecoration(
                                      color: isCurrent 
                                          ? AppColors.primary
                                          : AppColors.textLight.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8.sp),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getLanguageFlag(locale.languageCode),
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.sp),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          _getLanguageName(locale.languageCode),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        AppText(
                                          _getLanguageNativeName(locale.languageCode),
                                          fontSize: 14.sp,
                                          color: AppColors.textSecondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isCurrent)
                                    Icon(
                                      Icons.check_circle,
                                      color: AppColors.primary,
                                      size: 20.sp,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    
                    const Spacer(),
                    
                    // Info Section
                    Container(
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                        color: AppColors.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.sp),
                        border: Border.all(
                          color: AppColors.info.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.info,
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.sp),
                          Expanded(
                            child: AppText(
                              'Language changes will be applied immediately',
                              fontSize: 14.sp,
                              color: AppColors.info,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'Hindi';
      default:
        return 'Unknown';
    }
  }

  String _getLanguageNativeName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'हिंदी';
      default:
        return 'Unknown';
    }
  }

  String _getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇺🇸';
      case 'hi':
        return '🇮🇳';
      default:
        return '🌐';
    }
  }

  void _changeLanguage(Locale newLocale, BuildContext context) async {
    try {
      print('Language switcher: Changing to ${newLocale.languageCode}');
      
      // Call the controller method
      controller.changeLanguage(newLocale, context);
      
      // Show success message
      Get.snackbar(
        'Language Changed',
        'Language has been updated successfully',
        backgroundColor: AppColors.success.withOpacity(0.9),
        colorText: AppColors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      
      // Navigate back after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    } catch (e) {
      print('Language switcher error: $e');
      // Show error message
      Get.snackbar(
        'Error',
        'Failed to change language. Please try again.',
        backgroundColor: AppColors.error.withOpacity(0.9),
        colorText: AppColors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
