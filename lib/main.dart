import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sanaa_fi_saas/features/auth/domain/reposotories/auth_repo.dart';
import 'package:sanaa_fi_saas/features/splash/domain/reposotories/splash_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

// API and Data imports
import 'package:sanaa_fi_saas/data/api/api_client.dart';
import 'package:sanaa_fi_saas/utils/app_constants.dart';

// Repository imports
import 'package:sanaa_fi_saas/features/Loans/data/loansRepo.dart';
import 'package:sanaa_fi_saas/features/Reports/data/reportsRepo.dart';
import 'package:sanaa_fi_saas/features/clients/data/client_repo.dart';
import 'package:sanaa_fi_saas/features/expense/data/expenseRepo.dart';
// import 'package:sanaa_fi_saas/features/auth/domain/repositories/auth_repo.dart'; // Fixed spelling
// import 'package:sanaa_fi_saas/features/splash/domain/repositories/splash_repo.dart'; // Fixed spelling

// Controller imports
import 'package:sanaa_fi_saas/features/Loans/controllers/LoanController.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/allLoansControllers.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/loans_dashboard_controller.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/transaction_history_controller.dart';
import 'package:sanaa_fi_saas/features/Reports/controllers/report_controller.dart';
import 'package:sanaa_fi_saas/features/clients/controller/ClientController.dart';
import 'package:sanaa_fi_saas/features/clients/controller/client_profile_controller.dart';
import 'package:sanaa_fi_saas/features/expense/controllers/CashflowsController.dart';
import 'package:sanaa_fi_saas/features/expense/controllers/ExpensesController.dart';
import 'package:sanaa_fi_saas/features/home/controllers/ContentController.dart';
import 'package:sanaa_fi_saas/features/auth/controllers/auth_controller.dart';
import 'package:sanaa_fi_saas/features/splash/controllers/splash_controller.dart';

// Helper imports
import 'package:sanaa_fi_saas/helper/route_helper.dart';
import 'package:sanaa_fi_saas/helper/network_info.dart';

// Theme imports (if you have custom theme)
// import 'package:sanaa_fi_saas/utils/theme_data.dart';

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations (optional but recommended for mobile apps)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize local storage
  await GetStorage.init();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // Get device information properly
  // final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  // Map<String, dynamic> deviceData = {};



  // Get device information - keeping the original BaseDeviceInfo type
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late BaseDeviceInfo deviceInfo;
  
  try {
    if (Platform.isAndroid) {
      deviceInfo = await deviceInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      deviceInfo = await deviceInfoPlugin.iosInfo;
    } else if (Platform.isLinux) {
      deviceInfo = await deviceInfoPlugin.linuxInfo;
    } else if (Platform.isWindows) {
      deviceInfo = await deviceInfoPlugin.windowsInfo;
    } else if (Platform.isMacOS) {
      deviceInfo = await deviceInfoPlugin.macOsInfo;
    } else {
      // For web or other platforms, you might need to handle differently
      deviceInfo = await deviceInfoPlugin.webBrowserInfo;
    }
  } catch (e) {
    print('Error getting device info: $e');
    // Create a fallback - this depends on your ApiClient implementation
    // You might need to adjust this based on what your ApiClient does with deviceInfo
    rethrow; // Or handle the error appropriately
  }
  
   

  // Generate unique device ID
  final uniqueId = const Uuid().v4();

  // Initialize dependency injection
  await _initializeDependencies(
    sharedPreferences: sharedPreferences,
    deviceInfo: deviceInfo, // Now passing the correct type
    uniqueId: uniqueId,
  );

  // Run the app
  runApp(const MyApp());
}

Future<void> _initializeDependencies({
   required SharedPreferences sharedPreferences,
  required BaseDeviceInfo deviceInfo, // Changed parameter type back to BaseDeviceInfo
  required String uniqueId,
}) async {
  // Core Services
  Get.put<SharedPreferences>(sharedPreferences);
  
  // Network Service - Single instance with proper implementation
  Get.put<NetworkInfo>(NetworkInfo(Connectivity()));
  
  // API Client - The foundation for all API calls
  Get.put<ApiClient>(
    ApiClient(
      appBaseUrl: AppConstants.baseUrl + AppConstants.apiPath,
      sharedPreferences: sharedPreferences,
      deviceInfo: deviceInfo, // This now matches the expected type
      uniqueId: uniqueId,
    ),
  );

  // Repositories - Data layer
  Get.lazyPut<AuthRepo>(
    () => AuthRepo(
      apiClient: Get.find<ApiClient>(),
      sharedPreferences: Get.find<SharedPreferences>(),
    ),
  );

  Get.lazyPut<SplashRepo>(
    () => SplashRepo(
      apiClient: Get.find<ApiClient>(),
      sharedPreferences: Get.find<SharedPreferences>(),
    ),
  );

  Get.lazyPut<ClientRepo>(
    () => ClientRepo(
      apiClient: Get.find<ApiClient>(),
    ),
  );

  Get.lazyPut<ExpenseRepo>(
    () => ExpenseRepo(
      apiClient: Get.find<ApiClient>(),
    ),
  );

  Get.lazyPut<LoanRepo>(
    () => LoanRepo(
      apiClient: Get.find<ApiClient>(),
    ),
  );

  Get.lazyPut<ReportRepo>(
    () => ReportRepo(
      apiClient: Get.find<ApiClient>(),
    ),
  );

  // Core Controllers - These should be available immediately
  Get.put<SplashController>(
    SplashController(
      splashRepo: Get.find<SplashRepo>(),
    ),
  );

  Get.put<AuthController>(
    AuthController(
      authRepo: Get.find<AuthRepo>(),
    ),
  );

  // Feature Controllers - Lazy loaded when needed
  Get.lazyPut<ContentController>(
    () => ContentController(),
  );

  Get.lazyPut<ClientController>(
    () => ClientController(
      clientRepo: Get.find<ClientRepo>(),
    ),
  );

  Get.lazyPut<ClientProfileController>(
    () => ClientProfileController(
      clientRepo: Get.find<ClientRepo>(),
    ),
  );

  // Loan Controllers
  Get.lazyPut<LoanController>(
    () => LoanController(
      loanRepo: Get.find<LoanRepo>(),
    ),
  );

  Get.lazyPut<AllLoansController>(
    () => AllLoansController(
      loanRepo: Get.find<LoanRepo>(),
    ),
  );

  Get.lazyPut<LoansDashboardController>(
    () => LoansDashboardController(
      loanRepo: Get.find<LoanRepo>(),
    ),
  );

  Get.lazyPut<TransactionHistoryController>(
    () => TransactionHistoryController(
      loanRepo: Get.find<LoanRepo>(),
    ),
  );

  // Expense Controllers
  Get.lazyPut<ExpensesController>(
    () => ExpensesController(
      expenseRepo: Get.find<ExpenseRepo>(),
    ),
  );

  Get.lazyPut<CashflowsController>(
    () => CashflowsController(
      expenseRepo: Get.find<ExpenseRepo>(),
    ),
  );

  // Report Controller
  Get.lazyPut<ReportController>(
    () => ReportController(
      reportRepo: Get.find<ReportRepo>(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: ThemeData(
        primaryColor: const Color(0xFF2C3E50),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto', // Or your preferred font
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFF2C3E50),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: const Color(0xFF3498DB)),
      ),
      
      // Dark theme (optional)
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF2C3E50),
        colorScheme: ThemeData.dark().colorScheme.copyWith(
          secondary: const Color(0xFF3498DB),
        ),
      ),
      
      // System theme mode
      themeMode: ThemeMode.system,
      
      // Routing configuration
      initialRoute: RouteHelper.getSplashRoute(),
      getPages: RouteHelper.routes,
      
      // Default transitions
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      
      // Error handling
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => Scaffold(
          appBar: AppBar(
            title: const Text('Page Not Found'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Oops! Page not found',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'The page you are looking for does not exist',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed(RouteHelper.getSplashRoute()),
                  child: const Text('Go to Home'),
                ),
              ],
            ),
          ),
        ),
      ),
      
      // Locale configuration
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      
      // GetX configuration
      enableLog: true, // Set to false in production
      logWriterCallback: (String text, {bool? isError}) {
        // Custom logging if needed
        if (isError ?? false) {
          debugPrint('GetX Error: $text');
        }
      },
      
      // Navigation observers (useful for analytics)
      navigatorObservers: [
        // Add your navigation observers here
      ],
    );
  }
}