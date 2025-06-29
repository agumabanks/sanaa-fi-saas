import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sanaa_fi_saas/utils/app_constants.dart';

class DeviceFingerprintService {
  static final _storage = GetStorage();

  static Future<String> generateFingerprint() async {
    final info = DeviceInfoPlugin();
    String deviceId = '';
    if (Platform.isWindows) {
      final data = await info.windowsInfo;
      deviceId = data.deviceId ?? '';
    } else if (Platform.isLinux) {
      final data = await info.linuxInfo;
      deviceId = data.machineId ?? '';
    } else if (Platform.isMacOS) {
      final data = await info.macOsInfo;
      deviceId = data.systemGUID ?? '';
    }
    final platform = Platform.operatingSystem;
    final name = Platform.localHostname;
    final mac = '';
    final raw = '$deviceId|$platform|$name|$mac';
    final hash = sha256.convert(utf8.encode(raw)).toString();
    await storeFingerprint(hash);
    return hash;
  }

  static Future<void> storeFingerprint(String fingerprint) async {
    await _storage.write(AppConstants.deviceFingerprint, fingerprint);
  }

  static Future<String?> getStoredFingerprint() async {
    return _storage.read(AppConstants.deviceFingerprint);
  }
}
