import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';

// API and Data imports
import 'package:sanaa_fi_saas/data/api/api_client.dart';
import 'package:sanaa_fi_saas/utils/app_constants.dart';

// Repository imports
import 'package:sanaa_fi_saas/features/Loans/data/loansRepo.dart';
import 'package:sanaa_fi_saas/features/Reports/data/reportsRepo.dart';
import 'package:sanaa_fi_saas/features/clients/data/client_repo.dart';
import 'package:sanaa_fi_saas/features/expense/data/expenseRepo.dart';
import 'package:sanaa_fi_saas/features/auth/domain/repositories/auth_repo.dart';
import 'package:sanaa_fi_saas/features/splash/domain/reposotories/splash_repo.dart';

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

// Route helper
import 'package:sanaa_fi_saas/helper/route_helper.dart';
import 'package:sanaa_fi_saas/helper/network_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage and SharedPreferences
  await GetStorage.init();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // Get device info and generate uniqueId
  final BaseDeviceInfo deviceInfo = await DeviceInfoPlugin().deviceInfo;
  final uniqueId = const Uuid().v4();

  // Initialize dependency injection
  await _initializeDependencies(sharedPreferences, deviceInfo, uniqueId);

  runApp(const MyApp());
}

Future<void> _initializeDependencies(
  SharedPreferences sharedPreferences,
  BaseDeviceInfo deviceInfo,
  String uniqueId,
) async {
  // Register ApiClient first (most important dependency)
  Get.lazyPut<ApiClient>(() => ApiClient(
        appBaseUrl: AppConstants.baseUrl + AppConstants.apiPath,
        sharedPreferences: sharedPreferences,
        deiceInfo: deviceInfo,
        uniqueId: uniqueId,
      ));

  // Register NetworkInfo
  Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl());

  // Register Repositories
  Get.lazyPut<AuthRepo>(() => AuthRepo(
        apiClient: Get.find<ApiClient>(),
        sharedPreferences: sharedPreferences,
      ));

  Get.lazyPut<SplashRepo>(() => SplashRepo(
        apiClient: Get.find<ApiClient>(),
        sharedPreferences: sharedPreferences,
      ));

  Get.lazyPut<ClientRepo>(() => ClientRepo(apiClient: Get.find<ApiClient>()));
  Get.lazyPut<ExpenseRepo>(() => ExpenseRepo(apiClient: Get.find<ApiClient>()));
  Get.lazyPut<LoanRepo>(() => LoanRepo(apiClient: Get.find()));
  Get.lazyPut<ReportRepo>(() => ReportRepo(apiClient: Get.find()));

  // Register Core Controllers (Auth and Splash must be registered early)
  Get.lazyPut<AuthController>(() => AuthController(authRepo: Get.find<AuthRepo>()));
  Get.lazyPut<SplashController>(() => SplashController(splashRepo: Get.find<SplashRepo>()));

  // Register Feature Controllers
  Get.lazyPut<ClientProfileController>(() => ClientProfileController(clientRepo: Get.find()));
  Get.lazyPut<ClientController>(() => ClientController(clientRepo: Get.find<ClientRepo>()));

  // Register Loan Controllers
  Get.lazyPut<TransactionHistoryController>(() => TransactionHistoryController(loanRepo: Get.find()));
  Get.lazyPut<LoanController>(() => LoanController(loanRepo: Get.find()));
  Get.lazyPut<AllLoansController>(() => AllLoansController(loanRepo: Get.find()));
  Get.lazyPut<LoansDashboardController>(() => LoansDashboardController(loanRepo: Get.find()));

  // Register Expense Controllers
  Get.lazyPut<ExpensesController>(() => ExpensesController(expenseRepo: Get.find()));
  Get.lazyPut<CashflowsController>(() => CashflowsController(expenseRepo: Get.find()));

  // Register Report Controllers
  Get.lazyPut<ReportController>(() => ReportController(reportRepo: Get.find()));

  // Register Content Controller
  Get.lazyPut<ContentController>(() => ContentController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sanaa Fi SaaS',
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      // Routing configuration
      initialRoute: RouteHelper.getSplashRoute(),
      getPages: RouteHelper.routes,
      
      // Default transitions
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
      
      // Error handling
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(
          body: Center(
            child: Text('Page not found'),
          ),
        ),
      ),
      
      // Locale configuration
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}

// NetworkInfo implementation if not already present
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    try {
      final result = await Connectivity().checkConnectivity();
      return !result.contains(ConnectivityResult.none) && result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}