import 'package:get/get.dart';

showAppSnackBar(String? title, String message) {
  Get.snackbar(
    title ?? "",
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Get.theme.colorScheme.surface,
    colorText: Get.theme.colorScheme.onSurface,
    duration: const Duration(seconds: 2),
  );
}
