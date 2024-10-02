// lib/controllers/transaction_history_controller.dart

import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/Loans/data/latestPaymentTransactions.dart';
import 'package:sanaa_fi_saas/features/Loans/data/loansRepo.dart';
// import 'package:sanaa_fi_saas/repositories/loan_repo.dart';

class TransactionHistoryController extends GetxController {
  final LoanRepo loanRepo;

  TransactionHistoryController({required this.loanRepo});

  // Observable variables
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  var transactions = <Datum>[].obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLatestPaymentTransactions();
  }

  // **Fetch Latest Payment Transactions**
  Future<void> fetchLatestPaymentTransactions({int page = 1}) async {
    try {
      isLoading(true);
      isError(false);

      LatestPaymentTransactions? transactionData = await loanRepo.getLatestPaymentTransactions(
        search: searchQuery.value.isNotEmpty ? searchQuery.value : null,
        page: page,
        perPage: 20,
      );

      if (transactionData != null && transactionData.data != null && transactionData.data!.data != null) {
        final fetchedTransactions = transactionData.data!.data!;
        if (page == 1) {
          transactions.clear(); // Clear existing data if fetching the first page
        }
        transactions.addAll(fetchedTransactions);

        // Update pagination details
        currentPage.value = transactionData.data!.currentPage ?? 1;
        lastPage.value = transactionData.data!.lastPage ?? 1;
      } else {
        if (page == 1) {
          transactions.clear(); // Clear data if no transactions found
        }
        isError(true);
        errorMessage.value = 'No transactions found.';
      }
    } catch (e) {
      print("Error fetching latest payment transactions: $e");
      isError(true);
      errorMessage.value = 'Failed to fetch transactions.';
    } finally {
      isLoading(false);
    }
  }

  // **Load More Transactions for Pagination**
  void loadMore() {
    if (currentPage.value < lastPage.value && !isLoading.value) {
      fetchLatestPaymentTransactions(page: currentPage.value + 1);
    }
  }

  // **Set Search Query and Refresh Transactions**
  void setSearchQuery(String query) {
    searchQuery.value = query;
    currentPage.value = 1;
    fetchLatestPaymentTransactions(page: 1);
  }
}
