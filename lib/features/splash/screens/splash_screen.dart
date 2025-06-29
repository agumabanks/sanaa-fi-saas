import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sanaa_fi_saas/features/auth/controllers/auth_controller.dart';
import 'package:sanaa_fi_saas/features/splash/controllers/splash_controller.dart';
import 'package:sanaa_fi_saas/data/api/api_checker.dart';
import 'package:sanaa_fi_saas/features/auth/domain/models/user_short_data_model.dart';
import 'package:sanaa_fi_saas/helper/route_helper.dart';
import 'package:sanaa_fi_saas/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/helper/custom_snackbar_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
  late StreamSubscription<List<ConnectivityResult>> subscription;

  @override
  void initState() {
    super.initState();
    _initializeSplash();
  }

  void _initializeSplash() {
    bool isFirstTime = true;

    // Check current connectivity status
    _checkInitialConnectivity();

    // Listen to connectivity changes
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      
      // Check VPN
      if (await ApiChecker.isVpnActive()) {
        showCustomSnackBarHelper(
          'You are using VPN',
          isVpn: true, 
          duration: const Duration(minutes: 10)
        );
      }
      
      // Check connection status
      bool connected = result.isNotEmpty && 
          !result.contains(ConnectivityResult.none);
      
      if (!connected) {
        showCustomSnackBarHelper('No internet connection');
      }
      
      // Execute route logic only once when app starts
      if (isFirstTime) {
        isFirstTime = false;
        await _executeRouting();
      }
    });
  }

  Future<void> _checkInitialConnectivity() async {
    try {
      final List<ConnectivityResult> result = await Connectivity().checkConnectivity();
      if (result.contains(ConnectivityResult.none) || result.isEmpty) {
        showCustomSnackBarHelper('No internet connection');
      }
    } catch (e) {
      print('Connectivity check error: $e');
    }
  }

  Future<void> _executeRouting() async {
    try {
      // Add a small delay for splash screen effect
      await Future.delayed(const Duration(seconds: 1));

      // Check if required controllers are registered
      if (!Get.isRegistered<SplashController>()) {
        print('SplashController not registered, navigating to login choice');
        Get.offAllNamed(RouteHelper.getChoseLoginRegRoute());
        return;
      }

      if (!Get.isRegistered<AuthController>()) {
        print('AuthController not registered, navigating to login choice');
        Get.offAllNamed(RouteHelper.getChoseLoginRegRoute());
        return;
      }

      // Get config data
      final Response configResponse = await Get.find<SplashController>().getConfigData();
      
      if (configResponse.isOk) {
        // Initialize shared preferences
        await Get.find<SplashController>().initSharedData();
        
        // Get user data from AuthController
        UserShortDataModel? userData = Get.find<AuthController>().getUserData();
        
        // Determine navigation based on user authentication status
        await _navigateBasedOnAuth(userData);
        
      } else {
        // Config loading failed, go to choice screen
        print('Config loading failed, navigating to choice screen');
        Get.offAllNamed(RouteHelper.getChoseLoginRegRoute());
      }
      
    } catch (e) {
      print('Error in splash routing: $e');
      // Fallback navigation
      Get.offAllNamed(RouteHelper.getChoseLoginRegRoute());
    }
  }

  Future<void> _navigateBasedOnAuth(UserShortDataModel? userData) async {
    try {
      if (userData != null) {
        // User has saved data, check if config has company name (indicating proper setup)
        final configModel = Get.find<SplashController>().configModel;
        
        if (configModel?.companyName != null && configModel!.companyName!.isNotEmpty) {
          // User is authenticated and app is properly configured
          // Navigate to login screen with user's saved data for potential auto-login
          Get.offAllNamed(RouteHelper.getLoginRoute(
            countryCode: userData.countryCode,
            phoneNumber: userData.phone,
          ));
        } else {
          // App not properly configured, go to choice screen
          Get.offAllNamed(RouteHelper.getChoseLoginRegRoute());
        }
      } else {
        // No user data found, user needs to login or register
        Get.offAllNamed(RouteHelper.getChoseLoginRegRoute());
      }
    } catch (e) {
      print('Error in navigation logic: $e');
      // Fallback to choice screen
      Get.offAllNamed(RouteHelper.getChoseLoginRegRoute());
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset(
                Images.logo, 
                height: 175,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 175,
                    width: 175,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.account_balance,
                      size: 80,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 30),
              
              // Loading indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              
              const SizedBox(height: 20),
              
              // App name or loading text
              Text(
                'Sanaa Fi SaaS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 10),
              
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}