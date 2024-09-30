import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:sanaa_fi_saas/features/Loans/data/loanModal.dart';
import 'package:sanaa_fi_saas/features/Loans/data/loansRepo.dart';
import 'package:sanaa_fi_saas/features/Loans/views/allLoans.dart';
import 'package:sanaa_fi_saas/features/Loans/views/loansWidgets.dart';

class LoanController extends GetxController {
  final LoanRepo loanRepo;
  
  LoanController({required this.loanRepo});

  // var loans = <LoanModal>[].obs;

  var loans = <Datum>[].obs;  // List to store fetched loans
  var isLoading = false.obs;
  var searchQuery = ''.obs;
  var currentPage = 0.obs; // Observable variable to track the current page

  // List of pages corresponding to each loan type
  final List<Widget> pages = [
    LoansHome(),
    AllLoansPage(),  // Page for pending loans
    RejectedLoansPage(), // Page for rejected loans
    RunningLoansPage(),  // Page for running loans
  ];

  // Method to change the page based on index
  void changePage(int index) {
    currentPage.value = index;  // Change the current page index
  }
  @override
  void onInit() {
    fetchAllLoans();  // Automatically fetch loans when the controller is initialized
    super.onInit();
  }

  // Fetch all loans from the LoanRepo
  void fetchAllLoans() async {
    isLoading.value = true;
    AllLoans? allLoans = await loanRepo.getAllLoans();  // Fetch all loans
    if (allLoans != null && allLoans.data != null) {
      loans.addAll(allLoans.data!.data!);  // Populate loans list with the fetched data
    }
    isLoading.value = false;
  }

  // Search functionality
  void searchLoans(String query) {
    searchQuery.value = query;
    // fetchLoans(currentLoanType, search: query); // Re-fetch loans with search
  }
}
