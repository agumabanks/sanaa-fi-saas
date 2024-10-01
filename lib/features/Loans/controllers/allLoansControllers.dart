import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/LoanController.dart';
import 'package:sanaa_fi_saas/features/Loans/data/AllLoanPlans.dart';
import 'package:sanaa_fi_saas/features/Loans/data/PendingLoansModal.dart';
import 'package:sanaa_fi_saas/features/Loans/data/RunningLoansModal.dart';
import 'package:sanaa_fi_saas/features/Loans/data/allLoansModal.dart';
import 'package:sanaa_fi_saas/features/Loans/data/viewLoanModal.dart';
import 'package:sanaa_fi_saas/features/Loans/data/loansRepo.dart';

class AllLoansController extends GetxController {
  final LoanRepo loanRepo;

  AllLoansController({required this.loanRepo});

  // Observables for managing loan data and state
  var loans = <AllLoansDatum>[].obs; // Holds all loans data
  var pendingLoans = <PendingLoansModalDatum>[].obs; // Holds pending loans data
  var runningLoans = <RunningLoansModalDatum>[].obs; // Holds pending loans data
  var loanPlans = Rxn<List<Datum>>(); // Holds loan plans data

  var isLoading = false.obs; // Loading state
  var isError = false.obs; // Error state
  var errorMessage = ''.obs; // Error message state

  // Pagination and search query observables
  var searchQuery = ''.obs;
  var currentPage = 1.obs; // Tracks the current page number
  var totalPages = 1.obs; // Tracks the total number of pages

  // Observable for viewing a single loan
  var selectedLoan = Rxn<ViewLoanModal>();

  @override
  void onInit() {
    super.onInit();
    fetchAllLoans();  
    fetchLoanPlans();  
    fetchPendingLoans();  
    fetchRunningLoans();  
  }

  // Fetch pending loans with pagination and search
  Future<void> fetchRunningLoans({int page = 1}) async {
    try {
      isLoading(true); // Start loading indicator
      isError(false); // Reset error state

      RunningLoansModal? runningLoansData =
          await loanRepo.getRunniningLoans(page: page, search: searchQuery.value);

      if (runningLoansData != null && runningLoansData.data != null) {
        final fetchedLoans = runningLoansData.data;
        if (fetchedLoans!.isNotEmpty) {
          if (page == 1) runningLoans.clear(); // Clear current pending loans if first page
          runningLoans.addAll(fetchedLoans); // Add fetched pending loans to the list

          // Update pagination data
          currentPage.value = runningLoansData.pagination?.currentPage ?? 1;
          totalPages.value = runningLoansData.pagination?.lastPage ?? 1;
        }
      } else {
        print("No Running loans found.");
      }
    } catch (e) {
      print("Error fetching Running loans: $e");
    } finally {
      isLoading(false); // Stop loading indicator
    }
  }


  // Fetch loan plans
  Future<void> fetchLoanPlans() async {
    try {
      isLoading(true); // Start loading indicator
      isError(false); // Reset error state
      errorMessage(''); // Reset error message

      AllLoanPlans? fetchedLoanPlans = await loanRepo.getLoanPlans();

      if (fetchedLoanPlans != null && fetchedLoanPlans.data != null) {
        loanPlans.value = fetchedLoanPlans.data; // Set loan plans data
      } else {
        isError(true);
        errorMessage('Failed to load loan plans.');
      }
    } catch (e) {
      isError(true);
      errorMessage('An error occurred: $e');
      print("Error fetching loan plans: $e");
    } finally {
      isLoading(false); // Stop loading indicator
    }
  }

  // Fetch all loans with pagination and search
  Future<void> fetchAllLoans({int page = 1}) async {
    try {
      isLoading(true); // Start loading indicator
      isError(false); // Reset error state

      AllLoansModal? allLoans = await loanRepo.getAllLoans(page: page, search: searchQuery.value);

      if (allLoans != null && allLoans.data != null) {
        final fetchedLoans = allLoans.data;
        if (fetchedLoans!.isNotEmpty) {
          if (page == 1) loans.clear(); // Clear current loans if first page
          loans.addAll(fetchedLoans); // Add fetched loans to the list

          // Update pagination data
          currentPage.value = allLoans.pagination?.currentPage ?? 1;
          totalPages.value = allLoans.pagination?.lastPage ?? 1;
        }
      } else {
        print("No loans found.");
      }
    } catch (e) {
      print("Error fetching loans: $e");
    } finally {
      isLoading(false); // Stop loading indicator
    }
  }

  // Fetch pending loans with pagination and search
  Future<void> fetchPendingLoans({int page = 1}) async {
    try {
      isLoading(true); // Start loading indicator
      isError(false); // Reset error state

      PendingLoansModal? pendingLoansData =
          await loanRepo.getPendingLoans(page: page, search: searchQuery.value);

      if (pendingLoansData != null && pendingLoansData.data != null) {
        final fetchedLoans = pendingLoansData.data;
        if (fetchedLoans!.isNotEmpty) {
          if (page == 1) pendingLoans.clear(); // Clear current pending loans if first page
          pendingLoans.addAll(fetchedLoans); // Add fetched pending loans to the list

          // Update pagination data
          currentPage.value = pendingLoansData.pagination?.currentPage ?? 1;
          totalPages.value = pendingLoansData.pagination?.lastPage ?? 1;
        }
      } else {
        print("No pending loans found.");
      }
    } catch (e) {
      print("Error fetching pending loans: $e");
    } finally {
      isLoading(false); // Stop loading indicator
    }
  }

  // Fetch loan details by loanId and update the selectedLoan observable
  Future<void> viewLoan(int loanId) async {
    try {
      isLoading(true); // Start loading indicator

      ViewLoanModal? loanDetails = await loanRepo.getLoanById(loanId);

      if (loanDetails != null) {
        selectedLoan.value = loanDetails; // Set the selected loan
        Get.find<LoanController>().changePage(7); // Navigate to loan view page
      } else {
        print("Loan details not found.");
        Get.back(); // Navigate back if no loan details found
      }
    } catch (e) {
      print("Error fetching loan details: $e");
    } finally {
      isLoading(false); // Stop loading indicator
    }
  }

  // Clear search and reset loans list
  void clearSearch() {
    searchQuery.value = ''; // Clear search query
    currentPage.value = 1; // Reset to the first page
    fetchAllLoans(page: 1); // Re-fetch all loans
  }

  // Refresh loans list
  void refreshLoans() async {
    loans.clear(); // Clear loans list
    fetchAllLoans(); // Re-fetch all loans from the first page
  }

  // Search loans based on a query
  void searchLoans(String query) {
    searchQuery.value = query;
    loans.clear(); // Clear loans list to apply search filter
    fetchAllLoans(); // Re-fetch loans based on the search query
  }

  // Load more loans (pagination)
  void loadMoreLoans() {
    if (currentPage.value < totalPages.value) {
      fetchAllLoans(page: currentPage.value + 1); // Fetch next page of loans
    }
  }
}
