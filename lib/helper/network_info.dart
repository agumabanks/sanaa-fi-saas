import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/helper/custom_snackbar_helper.dart';

class NetworkInfo extends GetxService {
  final Connectivity connectivity;
  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void initConnectionCheck() {
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        showCustomSnackBarHelper('No internet connection');
      }
    });
  }
}
