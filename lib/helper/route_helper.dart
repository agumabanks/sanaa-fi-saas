import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/auth/screens/login_screen.dart';
import 'package:sanaa_fi_saas/features/splash/screens/splash_screen.dart';
import 'package:sanaa_fi_saas/features/home/views/home.dart';
// Import other screens as needed

class RouteHelper {
  // Route constants
  static const String splash = '/splash';
  static const String loginScreen = '/login';
  static const String choseLoginOrRegScreen = '/choose-login-reg';
  static const String createAccountScreen = '/create-account';
  static const String verifyScreen = '/verify';
  static const String home = '/home';
  static const String navbar = '/navbar';
  static const String welcomeScreen = '/welcome';
  static const String resetPassScreen = '/reset-password';
  static const String editProfileScreen = '/edit-profile';
  static const String faq = '/faq';
  static const String terms = '/terms';
  static const String aboutUs = '/about-us';
  static const String privacy = '/privacy';
  static const String support = '/support';

  // Authentication route methods
  static String getLoginRoute({
    String? countryCode, 
    String? phoneNumber, 
    String? redirect
  }) {
    String route = loginScreen;
    List<String> params = [];
    
    if (countryCode != null) {
      params.add('country-code=${Uri.encodeComponent(countryCode)}');
    }
    if (phoneNumber != null) {
      params.add('phone-number=${Uri.encodeComponent(phoneNumber)}');
    }
    if (redirect != null) {
      params.add('redirect=${Uri.encodeComponent(redirect)}');
    }
    
    if (params.isNotEmpty) {
      route += '?${params.join('&')}';
    }
    
    return route;
  }

  static String getChoseLoginRegRoute() => choseLoginOrRegScreen;
  
  static String getCreateAccountRoute() => createAccountScreen;
  
  static String getVerifyRoute({String? phoneNumber}) {
    if (phoneNumber != null) {
      return '$verifyScreen?phone_number=${Uri.encodeComponent(phoneNumber)}';
    }
    return verifyScreen;
  }

  static String getWelcomeRoute({
    required String countryCode, 
    required String phoneNumber, 
    required String password
  }) {
    return '$welcomeScreen?country-code=${Uri.encodeComponent(countryCode)}&phone-number=${Uri.encodeComponent(phoneNumber)}&password=${Uri.encodeComponent(password)}';
  }

  static String getResetPassRoute({String? phoneNumber, String? otp}) {
    List<String> params = [];
    if (phoneNumber != null) {
      params.add('phone-number=${Uri.encodeComponent(phoneNumber)}');
    }
    if (otp != null) {
      params.add('otp=${Uri.encodeComponent(otp)}');
    }
    
    String route = resetPassScreen;
    if (params.isNotEmpty) {
      route += '?${params.join('&')}';
    }
    return route;
  }

  // Navigation helper methods
  static String getSplashRoute() => splash;
  static String getHomeRoute() => home;
  static String getNavBarRoute() => navbar;
  static String getEditProfileRoute() => editProfileScreen;
  static String getFaqRoute() => faq;
  static String getTermsRoute() => terms;
  static String getAboutUsRoute() => aboutUs;
  static String getPrivacyRoute() => privacy;
  static String getSupportRoute() => support;

  // Route pages definition
  static List<GetPage> routes = [
    // Splash Screen
    GetPage(
      name: splash, 
      page: () => const SplashScreen()
    ),

    // Authentication Screens
    GetPage(
      name: loginScreen, 
      page: () {
        final String? countryCode = Get.parameters['country-code'] != null 
            ? Uri.decodeComponent(Get.parameters['country-code']!) 
            : null;
        final String? phoneNumber = Get.parameters['phone-number'] != null 
            ? Uri.decodeComponent(Get.parameters['phone-number']!) 
            : null;
            
        return LoginScreen(
          countryCode: countryCode,
          phoneNumber: phoneNumber,
        );
      }
    ),

    // Choice Screen (Login or Register)
    GetPage(
      name: choseLoginOrRegScreen, 
      page: () {
        // Replace with your actual ChoiceScreen widget
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Choose Login or Register'),
                ElevatedButton(
                  onPressed: () => Get.toNamed(loginScreen),
                  child: Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () => Get.toNamed(createAccountScreen),
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        );
      }
    ),

    // Create Account Screen
    GetPage(
      name: createAccountScreen, 
      page: () {
        // Replace with your actual CreateAccountScreen widget
        return Scaffold(
          appBar: AppBar(title: Text('Create Account')),
          body: Center(
            child: Text('Create Account Screen'),
          ),
        );
      }
    ),

    // Verification Screen
    GetPage(
      name: verifyScreen, 
      page: () {
        final String? phoneNumber = Get.parameters['phone_number'] != null
            ? Uri.decodeComponent(Get.parameters['phone_number']!)
            : null;
        
        // Replace with your actual VerificationScreen widget
        return Scaffold(
          appBar: AppBar(title: Text('Verify Phone')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Verify: ${phoneNumber ?? "No phone number"}'),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed(home),
                  child: Text('Verify'),
                ),
              ],
            ),
          ),
        );
      }
    ),

    // Home Screen
    GetPage(
      name: home, 
      page: () => const HomeScreen()
    ),

    // Welcome Screen
    GetPage(
      name: welcomeScreen, 
      page: () {
        final String countryCode = Get.parameters['country-code']?.replaceAll(' ', '+') ?? '';
        final String? phoneNumber = Get.parameters['phone-number'];
        final String? password = Get.parameters['password'];
        
        // Replace with your actual WelcomeScreen widget
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome!'),
                Text('Country: $countryCode'),
                Text('Phone: ${phoneNumber ?? "N/A"}'),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed(navbar),
                  child: Text('Continue'),
                ),
              ],
            ),
          ),
        );
      }
    ),

    // Reset Password Screen
    GetPage(
      name: resetPassScreen, 
      page: () {
        final String phoneNumber = Get.parameters['phone-number']?.replaceAll(' ', '+') ?? '';
        final String otp = Get.parameters['otp']?.replaceAll(' ', '+') ?? '';
        
        // Replace with your actual ResetPasswordScreen widget
        return Scaffold(
          appBar: AppBar(title: Text('Reset Password')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Reset password for: $phoneNumber'),
                Text('OTP: $otp'),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed(loginScreen),
                  child: Text('Reset Password'),
                ),
              ],
            ),
          ),
        );
      }
    ),

    // Other screens can be added here
    GetPage(
      name: editProfileScreen, 
      page: () => Scaffold(
        appBar: AppBar(title: Text('Edit Profile')),
        body: Center(child: Text('Edit Profile Screen')),
      )
    ),

    GetPage(
      name: faq, 
      page: () => Scaffold(
        appBar: AppBar(title: Text('FAQ')),
        body: Center(child: Text('FAQ Screen')),
      )
    ),

    GetPage(
      name: support, 
      page: () => Scaffold(
        appBar: AppBar(title: Text('Support')),
        body: Center(child: Text('Support Screen')),
      )
    ),
  ];
}