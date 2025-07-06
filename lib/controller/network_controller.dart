import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_app/core/utils/app_snackbar.dart';

class NetworkController extends GetxController {
  final isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    _checkInitialConnection();
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    final wasOffline = !isConnected.value;

    isConnected.value = result != ConnectivityResult.none;

    if (wasOffline && isConnected.value) {
      showAppSnackBar("Back Online", "Internet connection restored");
    } else if (!isConnected.value) {
      showAppSnackBar("No Internet", "Please check your connection");
    }
  }

  void _checkInitialConnection() async {
    final result = await Connectivity().checkConnectivity();
    isConnected.value = result != ConnectivityResult.none;
  }
}
