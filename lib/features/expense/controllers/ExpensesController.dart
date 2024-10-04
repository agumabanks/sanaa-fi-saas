import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/expense/data/ExpensesModal.dart';
import 'package:sanaa_fi_saas/features/expense/data/expenseRepo.dart';
// import 'package:your_project_name/features/Finance/data/ExpensesModal.dart';
// import 'package:your_project_name/features/Finance/data/ExpenseRepo.dart';

class ExpensesController extends GetxController {
  final ExpenseRepo expenseRepo;

  ExpensesController({required this.expenseRepo});

  // Observables for managing expense data and state
  var expenses = <Datum>[].obs; // Holds expenses data
  var isLoading = false.obs; // Loading state
  var isError = false.obs; // Error state
  var errorMessage = ''.obs; // Error message state

  // Pagination and search query observables
  var searchQuery = ''.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs; // Tracks the total number of pages

  // Observable for viewing a single expense
  var selectedExpense = Rxn<Datum>();

  @override
  void onInit() {
    super.onInit();
    fetchExpenses(); // Fetch initial expenses
  }

  // Fetch expenses with pagination and search
  Future<void> fetchExpenses({int page = 1}) async {
    try {
      isLoading(true); // Start loading indicator
      isError(false); // Reset error state

      ExpensesModal? expensesData = await expenseRepo.getExpenses(
        page: page,
        search: searchQuery.value,
      );

      if (expensesData != null && expensesData.data != null) {
        final fetchedExpenses = expensesData.data;
        if (fetchedExpenses!.isNotEmpty) {
          if (page == 1) expenses.clear(); // Clear current expenses if first page
          expenses.addAll(fetchedExpenses); // Add fetched expenses to the list

          // Update pagination data
          currentPage.value = page;
          // Assuming your API provides total pages; update this if necessary
          // totalPages.value = expensesData.pagination?.lastPage ?? 1;
        }
      } else {
        print("No expenses found.");
      }
    } catch (e) {
      print("Error fetching expenses: $e");
      isError(true);
      errorMessage('An error occurred while fetching expenses.');
    } finally {
      isLoading(false); // Stop loading indicator
    }
  }

  // View expense details by expenseId and update the selectedExpense observable
  void viewExpense(int expenseId) {
    try {
      isLoading(true); // Start loading indicator
      isError(false); // Reset error state

      // Find the expense from the current list
      Datum? expense = expenses.firstWhere(
        (element) => element.id == expenseId,
        // orElse: () => null,
      );

      if (expense != null) {
        selectedExpense.value = expense; // Set the selected expense
        // Navigate to expense detail page if necessary
        // e.g., Get.to(ExpenseDetailPage(expense: expense));
      } else {
        print("Expense not found.");
        isError(true);
        errorMessage('Expense not found.');
      }
    } catch (e) {
      print("Error viewing expense: $e");
      isError(true);
      errorMessage('An error occurred while viewing the expense.');
    } finally {
      isLoading(false); // Stop loading indicator
    }
  }

  // Create a new expense
  Future<void> createExpense(Map<String, dynamic> expenseData) async {
    try {
      isLoading(true);
      isError(false);

      final response = await expenseRepo.createExpense(expenseData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Expense created successfully
        // Optionally, fetch the updated list of expenses
        fetchExpenses(page: 1);
      } else {
        // Handle error
        isError(true);
        errorMessage('Failed to create expense.');
      }
    } catch (e) {
      print("Error creating expense: $e");
      isError(true);
      errorMessage('An error occurred while creating the expense.');
    } finally {
      isLoading(false);
    }
  }

  // Update an existing expense
  Future<void> updateExpense(int id, Map<String, dynamic> updatedData) async {
    try {
      isLoading(true);
      isError(false);

      final response = await expenseRepo.updateExpense(id, updatedData);

      if (response.statusCode == 200) {
        // Expense updated successfully
        // Update the expense in the list
        int index = expenses.indexWhere((expense) => expense.id == id);
        if (index != -1) {
          expenses[index] = Datum.fromJson(updatedData);
        }
      } else {
        // Handle error
        isError(true);
        errorMessage('Failed to update expense.');
      }
    } catch (e) {
      print("Error updating expense: $e");
      isError(true);
      errorMessage('An error occurred while updating the expense.');
    } finally {
      isLoading(false);
    }
  }

  // Delete an expense
  Future<void> deleteExpense(int id) async {
    try {
      isLoading(true);
      isError(false);

      final response = await expenseRepo.deleteExpense(id);

      if (response.statusCode == 200) {
        // Expense deleted successfully
        // Remove the expense from the list
        expenses.removeWhere((expense) => expense.id == id);
      } else {
        // Handle error
        isError(true);
        errorMessage('Failed to delete expense.');
      }
    } catch (e) {
      print("Error deleting expense: $e");
      isError(true);
      errorMessage('An error occurred while deleting the expense.');
    } finally {
      isLoading(false);
    }
  }

  // Clear search and reset expenses list
  void clearSearch() {
    searchQuery.value = ''; // Clear search query
    currentPage.value = 1; // Reset to the first page
    fetchExpenses(page: 1); // Re-fetch expenses
  }

  // Refresh expenses list
  void refreshExpenses() async {
    expenses.clear(); // Clear expenses list
    fetchExpenses(); // Re-fetch expenses from the first page
  }

  // Search expenses based on a query
  void searchExpenses(String query) {
    searchQuery.value = query;
    expenses.clear(); // Clear expenses list to apply search filter
    fetchExpenses(); // Re-fetch expenses based on the search query
  }

  // Load more expenses (pagination)
  void loadMoreExpenses() {
    if (currentPage.value < totalPages.value) {
      fetchExpenses(page: currentPage.value + 1); // Fetch next page of expenses
    }
  }
}
