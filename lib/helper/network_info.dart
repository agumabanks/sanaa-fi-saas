import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/helper/custom_snackbar_helper.dart';

class NetworkInfo extends GetxService {
  final Connectivity connectivity;
  
  // Observable variables for reactive UI updates
  final _isConnected = false.obs;
  final _connectionType = ConnectivityResult.none.obs;
  final _hasInternetAccess = false.obs;
  
  // Stream subscription for cleanup
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  
  // Timer for periodic internet checks
  Timer? _internetCheckTimer;
  
  // Getters for external access
  bool get isConnected => _isConnected.value;
  bool get hasInternetAccess => _hasInternetAccess.value;
  ConnectivityResult get connectionType => _connectionType.value;
  
  // Stream for listening to connection changes
  Stream<bool> get onConnectivityChanged => _isConnected.stream;
  
  NetworkInfo(this.connectivity);
  
  @override
  void onInit() {
    super.onInit();
    // Initialize connection checking when the service starts
    initConnectionCheck();
    // Perform initial connection check
    checkConnection();
  }
  
  @override
  void onClose() {
    // Clean up resources when the service is disposed
    _connectivitySubscription?.cancel();
    _internetCheckTimer?.cancel();
    super.onClose();
  }
  
  /// Checks if device has any network connection
  /// This only checks if WiFi/Mobile data is on, not actual internet access
  Future<bool> checkConnection() async {
    try {
      final result = await connectivity.checkConnectivity();
      _updateConnectionStatus(result as ConnectivityResult);
      
      // Also check for actual internet access
      if (result != ConnectivityResult.none) {
        await checkInternetAccess();
      }
      
      return result != ConnectivityResult.none;
    } catch (e) {
      print('Error checking connection: $e');
      return false;
    }
  }
  
  /// Verifies actual internet access by pinging a reliable server
  /// This is important because having WiFi doesn't mean having internet
  Future<bool> checkInternetAccess() async {
    try {
      // Try to lookup a reliable domain
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      
      // If lookup is successful and has results, we have internet
      final hasInternet = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      _hasInternetAccess.value = hasInternet;
      
      return hasInternet;
    } on SocketException catch (_) {
      // No internet connection
      _hasInternetAccess.value = false;
      return false;
    } on TimeoutException catch (_) {
      // Request timed out - likely very slow or no connection
      _hasInternetAccess.value = false;
      return false;
    } catch (e) {
      // Any other error
      print('Error checking internet access: $e');
      _hasInternetAccess.value = false;
      return false;
    }
  }
  
  /// Initializes continuous monitoring of connection changes
  void initConnectionCheck() {
    // Listen to connectivity changes
    _connectivitySubscription = connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        // Use the first result if available, otherwise default to none
        final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
        _handleConnectivityChange(result);
      },
      onError: (error) {
        if (kDebugMode) {
          print('Connectivity subscription error: $error');
        }
      },
    );
    
    // Set up periodic internet access checks (every 30 seconds)
    _internetCheckTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) {
        if (_isConnected.value) {
          checkInternetAccess();
        }
      },
    );
  }
  
  /// Handles connectivity state changes
  void _handleConnectivityChange(ConnectivityResult result) {
    _updateConnectionStatus(result);
    
    // Show appropriate messages based on connection state
    if (result == ConnectivityResult.none) {
      _showNoConnectionMessage();
      _hasInternetAccess.value = false;
    } else {
      // Connection restored - check for actual internet
      checkInternetAccess().then((hasInternet) {
        if (hasInternet) {
          _showConnectionRestoredMessage();
        } else {
          _showNoInternetAccessMessage();
        }
      });
    }
  }
  
  /// Updates the connection status observables
  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionType.value = result;
    _isConnected.value = result != ConnectivityResult.none;
  }
  
  /// Shows no connection message
  void _showNoConnectionMessage() {
    showCustomSnackBarHelper(
      'no_internet_connection'.tr,
      isError: true,
      duration: const Duration(seconds: 5),
    );
  }
  
  /// Shows connection restored message
  void _showConnectionRestoredMessage() {
    showCustomSnackBarHelper(
      'connection_restored'.tr,
      isError: false,
      duration: const Duration(seconds: 3),
    );
  }
  
  /// Shows message when connected to network but no internet
  void _showNoInternetAccessMessage() {
    showCustomSnackBarHelper(
      'connected_but_no_internet'.tr,
      isError: true,
      duration: const Duration(seconds: 5),
    );
  }
  
  /// Gets human-readable connection type
  String getConnectionTypeString() {
    switch (_connectionType.value) {
      case ConnectivityResult.wifi:
        return 'WiFi';
      case ConnectivityResult.mobile:
        return 'Mobile Data';
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
      case ConnectivityResult.none:
        return 'No Connection';
      default:
        return 'Unknown';
    }
  }
  
  /// Retry an operation with network check
  /// This is useful for API calls that fail due to network issues
  Future<T?> retryWithNetworkCheck<T>({
    required Future<T> Function() operation,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 2),
  }) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      // Check connection before attempting
      final hasConnection = await checkConnection();
      final hasInternet = await checkInternetAccess();
      
      if (!hasConnection || !hasInternet) {
        showCustomSnackBarHelper(
          'waiting_for_connection'.tr,
          duration: const Duration(seconds: 2),
        );
        await Future.delayed(retryDelay);
        attempts++;
        continue;
      }
      
      try {
        // Attempt the operation
        return await operation();
      } catch (e) {
        // Check if it's a network error
        if (e.toString().contains('SocketException') || 
            e.toString().contains('TimeoutException')) {
          attempts++;
          if (attempts < maxRetries) {
            await Future.delayed(retryDelay);
            continue;
          }
        }
        // If not a network error, rethrow
        rethrow;
      }
    }
    
    // Max retries reached
    showCustomSnackBarHelper(
      'operation_failed_check_connection'.tr,
      isError: true,
    );
    return null;
  }
}

// Extension to make it easier to check network status from anywhere
extension NetworkCheck on GetInterface {
  NetworkInfo get network => Get.find<NetworkInfo>();
  
  bool get isConnected => Get.find<NetworkInfo>().isConnected;
  bool get hasInternet => Get.find<NetworkInfo>().hasInternetAccess;
}