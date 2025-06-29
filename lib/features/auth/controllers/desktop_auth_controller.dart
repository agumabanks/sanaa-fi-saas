import 'dart:async';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/data/repository/auth_repo.dart';
import 'package:sanaa_fi_saas/services/desktop_session_storage.dart';
import 'package:sanaa_fi_saas/services/device_fingerprint_service.dart';
import '../utils/auth_error_handler.dart';

class DesktopAuthController extends GetxController {
  final AuthRepo authRepo;
  DesktopAuthController({required this.authRepo});

  RxBool isAuthenticated = false.obs;
  RxInt remainingSeconds = 0.obs;
  RxBool isRefreshing = false.obs;
  RxString userEmail = ''.obs;

  Timer? sessionCheckTimer;
  Timer? autoRefreshTimer;

  Future<void> login({required String email, required String password, bool rememberMe = false}) async {
    final fingerprint = await DeviceFingerprintService.generateFingerprint();
    final response = await authRepo.desktopLogin(email: email, password: password, rememberMe: rememberMe, deviceFingerprint: fingerprint);
    if (response.statusCode == 200) {
      final token = response.body['token'];
      final sessionId = response.body['session_id'];
      await DesktopSessionStorage.saveSession(token, sessionId, email);
      authRepo.apiClient.updateDesktopHeaders(token, fingerprint);
      isAuthenticated.value = true;
      userEmail.value = email;
      await startSessionMonitoring();
    } else {
      AuthErrorHandler.handleLoginError(response.body);
    }
  }

  Future<void> logout() async {
    await authRepo.desktopLogout();
    await DesktopSessionStorage.clearSession();
    isAuthenticated.value = false;
    sessionCheckTimer?.cancel();
    autoRefreshTimer?.cancel();
  }

  Future<void> logoutAllDevices() async {
    await authRepo.desktopLogoutAll();
    await DesktopSessionStorage.clearSession();
    isAuthenticated.value = false;
  }

  Future<void> startSessionMonitoring() async {
    sessionCheckTimer?.cancel();
    await checkSessionStatus();
    sessionCheckTimer = Timer.periodic(const Duration(seconds: 30), (_) => checkSessionStatus());
  }

  Future<void> refreshToken() async {
    if (isRefreshing.value) return;
    isRefreshing.value = true;
    try {
      final response = await authRepo.refreshDesktopToken();
      if (response.statusCode == 200) {
        final token = response.body['token'];
        final sessionId = response.body['session_id'];
        await DesktopSessionStorage.saveSession(token, sessionId, userEmail.value);
        final fp = await DeviceFingerprintService.getStoredFingerprint() ?? await DeviceFingerprintService.generateFingerprint();
        authRepo.apiClient.updateDesktopHeaders(token, fp);
        scheduleTokenRefresh();
      } else {
        AuthErrorHandler.handleTokenRefreshError(response.body);
      }
    } finally {
      isRefreshing.value = false;
    }
  }

  Future<void> checkSessionStatus() async {
    final response = await authRepo.getSessionInfo();
    if (response.statusCode == 200) {
      remainingSeconds.value = response.body['remaining_seconds'];
      scheduleTokenRefresh();
    } else if (response.statusCode == 401) {
      handleSessionExpiry();
    }
  }

  void scheduleTokenRefresh() {
    autoRefreshTimer?.cancel();
    final refreshIn = remainingSeconds.value - 120;
    if (refreshIn > 0) {
      autoRefreshTimer = Timer(Duration(seconds: refreshIn), () {
        refreshToken();
      });
    }
  }

  void handleSessionExpiry() {
    logout();
  }

  Future<void> checkExistingSession() async {
    if (await DesktopSessionStorage.hasValidSession()) {
      final session = await DesktopSessionStorage.getSession();
      if (session != null) {
        userEmail.value = session.email;
        final fp = await DeviceFingerprintService.getStoredFingerprint() ?? await DeviceFingerprintService.generateFingerprint();
        authRepo.apiClient.updateDesktopHeaders(session.token, fp);
        isAuthenticated.value = true;
        await startSessionMonitoring();
      }
    }
  }

  Future<void> handleRememberMe(bool remember) async {
    if (remember) {
      // TODO: store credentials securely
    } else {
      // TODO: clear stored credentials
    }
  }

  void setupActivityMonitoring() {
    // TODO: implement user activity based refresh
  }
}

// Handles connectivity changes and queues refresh calls when back online
class NetworkAwareAuthController extends DesktopAuthController {
  NetworkAwareAuthController({required super.authRepo});

  @override
  void onInit() {
    super.onInit();
    // TODO: listen to connectivity changes and handle offline mode
  }
}
*** End Patch
