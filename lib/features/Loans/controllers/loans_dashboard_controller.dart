// lib/controllers/dashboard_controller.dart

import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/Loans/data/LoansDash.dart';
import 'package:sanaa_fi_saas/features/Loans/data/loansRepo.dart';
// import 'package:sanaa_fi_saas/models/dashboard_stats.dart';
// import 'package:sanaa_fi_saas/repositories/loan_repo.dart';

class DashboardController extends GetxController {
  final LoanRepo loanRepo;

  DashboardController({required this.loanRepo});

  // Observable variables
  var totalClients = 0.obs;
  var totalActiveLoans = 0.obs;
  var totalPendingLoans = 0.obs;
  var totalRunningLoans = 0.obs;
  var totalAmountInLoans = ''.obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLoanDashboardStats();
  }

  /// Fetches the loan dashboard statistics from the repository
  Future<void> fetchLoanDashboardStats() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      DashboardStats? stats = await loanRepo.getLoanDashboardStats();
      if (stats != null) {
        totalClients.value = stats.totalClients;
        totalActiveLoans.value = stats.totalActiveLoans;
        totalPendingLoans.value = stats.totalPendingLoans;
        totalRunningLoans.value = stats.totalRunningLoans;
        totalAmountInLoans.value = formatCurrency(stats.totalAmountInLoans);
      } else {
        errorMessage.value = 'Failed to load dashboard statistics.';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Formats the loan amount to a currency string
  String formatCurrency(String amount) {
    double? parsedAmount = double.tryParse(amount);
    if (parsedAmount != null) {
      // Format to currency, e.g., $132,386,458.90
      return '${parsedAmount.toStringAsFixed(0)}  /='.replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    } else {
      return '0.0 /=';
    }
  }
}
