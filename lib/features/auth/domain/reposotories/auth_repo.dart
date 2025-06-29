import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sanaa_fi_saas/data/api/api_client.dart';
import 'package:sanaa_fi_saas/utils/app_constants.dart';
import 'package:sanaa_fi_saas/features/auth/domain/models/user_short_data_model.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  // Login method
  Future<Response> login({
    String? phone,
    String? password,
    String? dialCode,
  }) async {
    try {
      Map<String, dynamic> loginData = {
        'phone': phone,
        'password': password,
        'dial_code': dialCode,
      };

      Response response = await apiClient.postData(
        AppConstants.loginUri,
        loginData,
      );

      return response;
    } catch (e) {
      print('Login error: $e');
      return Response(statusCode: 500, statusText: 'Login failed');
    }
  }

  // Check phone number
  Future<Response> checkPhone(String phoneNumber) async {
    try {
      Response response = await apiClient.postData(
        AppConstants.checkPhoneUri,
        {'phone': phoneNumber},
      );
      return response;
    } catch (e) {
      print('Check phone error: $e');
      return Response(statusCode: 500, statusText: 'Phone check failed');
    }
  }

  // Registration
  Future<Response> registration(
    Map<String, String> allCustomerInfo,
    dynamic multipartBody,
  ) async {
    try {
      Response response = await apiClient.postMultipartData(
        AppConstants.registrationUri,
        allCustomerInfo,
        multipartBody,
      );
      return response;
    } catch (e) {
      print('Registration error: $e');
      return Response(statusCode: 500, statusText: 'Registration failed');
    }
  }

  // Logout
  Future<Response> logout() async {
    try {
      Response response = await apiClient.postData(
        AppConstants.logoutUri,
        {},
      );
      
      // Clear local data
      await clearUserToken();
      await removeUserData();
      
      return response;
    } catch (e) {
      print('Logout error: $e');
      return Response(statusCode: 500, statusText: 'Logout failed');
    }
  }

  // Save user token
  Future<bool> saveUserToken(String token) async {
    try {
      apiClient.token = token;
      return await sharedPreferences.setString(AppConstants.token, token);
    } catch (e) {
      print('Save token error: $e');
      return false;
    }
  }

  // Update token in API client
  Future<void> updateToken() async {
    try {
      String? token = sharedPreferences.getString(AppConstants.token);
      if (token != null) {
        apiClient.token = token;
        apiClient.updateHeader(token);
      }
    } catch (e) {
      print('Update token error: $e');
    }
  }

  // Get user token
  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? '';
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token) &&
           getUserToken().isNotEmpty;
  }

  // Clear user token
  Future<bool> clearUserToken() async {
    try {
      apiClient.token = '';
      return await sharedPreferences.remove(AppConstants.token);
    } catch (e) {
      print('Clear token error: $e');
      return false;
    }
  }

  // Remove customer token (alias for clearUserToken)
  Future<bool> removeCustomerToken() async {
    return await clearUserToken();
  }

  // Save user data
  Future<bool> saveUserData(UserShortDataModel userData) async {
    try {
      String userDataJson = jsonEncode(userData.toJson());
      return await sharedPreferences.setString(
        AppConstants.userData,
        userDataJson,
      );
    } catch (e) {
      print('Save user data error: $e');
      return false;
    }
  }

  // Get user data
  UserShortDataModel? getUserData() {
    try {
      String? userDataString = sharedPreferences.getString(AppConstants.userData);
      if (userDataString != null && userDataString.isNotEmpty) {
        Map<String, dynamic> userData = jsonDecode(userDataString);
        return UserShortDataModel.fromJson(userData);
      }
      return null;
    } catch (e) {
      print('Get user data error: $e');
      return null;
    }
  }

  // Remove user data
  Future<bool> removeUserData() async {
    try {
      return await sharedPreferences.remove(AppConstants.userData);
    } catch (e) {
      print('Remove user data error: $e');
      return false;
    }
  }

  // Delete user account
  Future<Response> deleteUser() async {
    try {
      Response response = await apiClient.deleteData(AppConstants.deleteUserUri);
      
      if (response.statusCode == 200) {
        await clearUserToken();
        await removeUserData();
      }
      
      return response;
    } catch (e) {
      print('Delete user error: $e');
      return Response(statusCode: 500, statusText: 'Delete user failed');
    }
  }

  // Forgot password OTP
  Future<Response> forgetPassOtp({required String phoneNumber}) async {
    try {
      Response response = await apiClient.postData(
        AppConstants.forgetPassOtpUri,
        {'phone': phoneNumber},
      );
      return response;
    } catch (e) {
      print('Forgot password OTP error: $e');
      return Response(statusCode: 500, statusText: 'Forgot password OTP failed');
    }
  }

  // Verify OTP
  Future<Response> verifyOtpApi({required String otp}) async {
    try {
      Response response = await apiClient.postData(
        AppConstants.verifyOtpUri,
        {'otp': otp},
      );
      return response;
    } catch (e) {
      print('Verify OTP error: $e');
      return Response(statusCode: 500, statusText: 'OTP verification failed');
    }
  }

  // Check OTP
  Future<Response> checkOtpApi() async {
    try {
      Response response = await apiClient.getData(AppConstants.checkOtpUri);
      return response;
    } catch (e) {
      print('Check OTP error: $e');
      return Response(statusCode: 500, statusText: 'Check OTP failed');
    }
  }

  // Reset password
  Future<Response> resetPassword({
    required String phoneNumber,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      Map<String, dynamic> resetData = {
        'phone': phoneNumber,
        'otp': otp,
        'password': password,
        'password_confirmation': confirmPassword,
      };

      Response response = await apiClient.postData(
        AppConstants.resetPasswordUri,
        resetData,
      );
      return response;
    } catch (e) {
      print('Reset password error: $e');
      return Response(statusCode: 500, statusText: 'Reset password failed');
    }
  }

  // Get customer by phone
  Future<Response> getCustomerByPhone(String phoneNumber) async {
    try {
      Response response = await apiClient.getData(
        '${AppConstants.customerByPhoneUri}?phone=$phoneNumber',
      );
      return response;
    } catch (e) {
      print('Get customer by phone error: $e');
      return Response(statusCode: 500, statusText: 'Get customer failed');
    }
  }

  // Update profile
  Future<Response> updateProfile({
    required Map<String, String> userData,
    dynamic profileImage,
  }) async {
    try {
      Response response = await apiClient.postMultipartData(
        AppConstants.updateProfileUri,
        userData,
        profileImage,
      );
      return response;
    } catch (e) {
      print('Update profile error: $e');
      return Response(statusCode: 500, statusText: 'Update profile failed');
    }
  }

  // Change password
  Future<Response> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      Map<String, dynamic> passwordData = {
        'old_password': oldPassword,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      };

      Response response = await apiClient.postData(
        AppConstants.changePasswordUri,
        passwordData,
      );
      return response;
    } catch (e) {
      print('Change password error: $e');
      return Response(statusCode: 500, statusText: 'Change password failed');
    }
  }

  // Check biometric support
  bool isBiometricEnabled() {
    return sharedPreferences.getBool(AppConstants.biometricAuth) ?? false;
  }

  // Set biometric preference
  Future<bool> setBiometricEnabled(bool enabled) async {
    try {
      return await sharedPreferences.setBool(AppConstants.biometricAuth, enabled);
    } catch (e) {
      print('Set biometric error: $e');
      return false;
    }
  }
}