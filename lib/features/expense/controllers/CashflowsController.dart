// cashflows_controller.dart

import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/expense/data/CashFlowModal.dart';
import 'package:sanaa_fi_saas/features/expense/data/expenseRepo.dart';
// import 'package:your_project_name/data/api/api_client.dart';
// import 'package:your_project_name/features/Finance/data/CashFlowModal.dart';
// import 'package:your_project_name/features/Finance/data/ExpenseRepo.dart';

class CashflowsController extends GetxController {
  final ExpenseRepo expenseRepo;

  CashflowsController({required this.expenseRepo});

  var cashflows = <CashFlowDatum>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  var searchQuery = ''.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCashflows();
  }

  Future<void> fetchCashflows({int page = 1}) async {
    try {
      isLoading(true);
      isError(false);

      CashFlowModal? cashflowsData = await expenseRepo.getCashflows(
        page: page,
        search: searchQuery.value,
      );

      if (cashflowsData != null && cashflowsData.data != null) {
        final fetchedCashflows = cashflowsData.data!;
        if (fetchedCashflows.isNotEmpty) {
          if (page == 1) cashflows.clear();
          cashflows.addAll(fetchedCashflows);
          currentPage.value = page;
          // Update totalPages if available
        }
      } else {
        print("No cashflows found.");
      }
    } catch (e) {
      print("Error fetching cashflows: $e");
      isError(true);
      errorMessage('An error occurred while fetching cashflows.');
    } finally {
      isLoading(false);
    }
  }

  // Implement methods for create, update, delete cashflows

  Future<void> createCashflow(Map<String, dynamic> cashflowData) async {
    try {
      isLoading(true);
      isError(false);

      final response = await expenseRepo.createCashflow(cashflowData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Cashflow created successfully
        fetchCashflows(page: 1);
      } else {
        isError(true);
        errorMessage('Failed to create cashflow.');
      }
    } catch (e) {
      print("Error creating cashflow: $e");
      isError(true);
      errorMessage('An error occurred while creating the cashflow.');
    } finally {
      isLoading(false);
    }
  }

  // Implement update and delete methods similarly
}
