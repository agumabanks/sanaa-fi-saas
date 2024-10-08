import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sanaa_fi_saas/data/api/api_client.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/LoanController.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/allLoansControllers.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/loans_dashboard_controller.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/transaction_history_controller.dart';
import 'package:sanaa_fi_saas/features/Loans/data/loansRepo.dart';
import 'package:sanaa_fi_saas/features/Reports/controllers/report_controller.dart';
import 'package:sanaa_fi_saas/features/Reports/data/reportsRepo.dart';
import 'package:sanaa_fi_saas/features/clients/controller/ClientController.dart';
import 'package:sanaa_fi_saas/features/clients/controller/client_profile_controller.dart';
import 'package:sanaa_fi_saas/features/clients/data/client_repo.dart';
import 'package:sanaa_fi_saas/features/expense/controllers/CashflowsController.dart';
import 'package:sanaa_fi_saas/features/expense/controllers/ExpensesController.dart';
import 'package:sanaa_fi_saas/features/expense/data/expenseRepo.dart';
import 'package:sanaa_fi_saas/features/home/controllers/ContentController.dart';
import 'package:sanaa_fi_saas/features/home/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage and SharedPreferences
  await GetStorage.init();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // Get device info and generate uniqueId
  final BaseDeviceInfo deviceInfo = await DeviceInfoPlugin().deviceInfo;
  final uniqueId = Uuid().v4(); // Generate unique ID

  // Register ApiClient
  Get.lazyPut<ApiClient>(() => ApiClient(
        appBaseUrl: 'https://lendsup.sanaa.co/api/v1',
        sharedPreferences: sharedPreferences,
        deiceInfo: deviceInfo,
        uniqueId: uniqueId,
      ));

 

   // Register Repositories
  Get.lazyPut<ClientRepo>(() => ClientRepo(apiClient: Get.find<ApiClient>()));
  Get.lazyPut<ExpenseRepo>(() => ExpenseRepo(apiClient: Get.find<ApiClient>()));
  // Get.lazyPut<LoanRepo>(() => LoanRepo(apiClient: Get.find<ApiClient>()));
  Get.lazyPut(() => LoanRepo(apiClient: Get.find()));
   Get.lazyPut(() => ReportRepo(apiClient: Get.find()));


  // Register Controllers ReportRepo
  Get.lazyPut(()=>ClientProfileController(clientRepo: Get.find()));
  Get.lazyPut<ClientController>(() => ClientController(clientRepo: Get.find<ClientRepo>()));
  Get.put<TransactionHistoryController>(TransactionHistoryController(loanRepo: Get.find()));

  // DashboardController
  Get.put<DashboardController>(DashboardController(loanRepo: Get.find()));

  Get.put<CashflowsController>(CashflowsController(expenseRepo: Get.find()));
  Get.put<ExpensesController>(ExpensesController(expenseRepo: Get.find()));

  //   final ReportController reportController = Get.put(ReportController(reportRepo: ReportRepo(apiClient: ApiClient())));
  Get.put<ReportController>(ReportController(reportRepo: Get.find()));



  // AllLoansController
    // Get.lazyPut<AllLoansController>(() => AllLoansController(clientRepo: Get.find<ClientRepo>()));

  // Get.lazyPut<LoanController>(() => LoanController(loanRepo: Get.find<LoanRepo>()));
  // Get.put<LoanController>(LoanController(loanRepo: Get.find<LoanRepo>()));
    Get.lazyPut(() => LoanController(loanRepo: Get.find()));
    Get.lazyPut(() => AllLoansController(loanRepo: Get.find()));
      // Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));





  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sanaa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
