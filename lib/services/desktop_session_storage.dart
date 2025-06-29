import 'package:get_storage/get_storage.dart';
import 'package:sanaa_fi_saas/utils/app_constants.dart';

class SessionData {
  final String token;
  final int sessionId;
  final String email;
  SessionData({required this.token, required this.sessionId, required this.email});
}

class DesktopSessionStorage {
  static const _tokenKey = AppConstants.desktopAuthToken;
  static const _sessionIdKey = AppConstants.desktopSessionId;
  static const _emailKey = AppConstants.desktopUserEmail;
  static final _storage = GetStorage();

  static Future<void> saveSession(String token, int sessionId, String email) async {
    await _storage.write(_tokenKey, token);
    await _storage.write(_sessionIdKey, sessionId);
    await _storage.write(_emailKey, email);
  }

  static Future<SessionData?> getSession() async {
    final token = _storage.read<String>(_tokenKey);
    final id = _storage.read<int>(_sessionIdKey);
    final email = _storage.read<String>(_emailKey);
    if (token != null && id != null && email != null) {
      return SessionData(token: token, sessionId: id, email: email);
    }
    return null;
  }

  static Future<void> clearSession() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_sessionIdKey);
    await _storage.remove(_emailKey);
  }

  static Future<bool> hasValidSession() async {
    final data = await getSession();
    return data != null;
  }
}
