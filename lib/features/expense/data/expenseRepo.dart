import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sanaa_fi_saas/data/api/api_client.dart';
import 'package:sanaa_fi_saas/features/expense/data/ExpensesModal.dart';
import 'package:sanaa_fi_saas/features/expense/data/CashFlowModal.dart';

class ExpenseRepo {
  final ApiClient apiClient;
  final GetStorage storage = GetStorage();

  ExpenseRepo({required this.apiClient});

  /// Fetch all expenses with optional search query
  Future<ExpensesModal?> getExpenses({String? search, int page = 1}) async {
    try {
      final response = await apiClient.getData(
        '/finance/expenses',
        query: {
          if (search != null && search.isNotEmpty) 'search': search,
          'page': page.toString(),
        },
      );

      if (response.statusCode == 200) {
        ExpensesModal expensesModal = ExpensesModal.fromJson(response.body);
        storage.write('expenses_page_$page', response.body); // Cache data
        return expensesModal;
      } else {
        // Fallback to cache if API call fails
        final cachedData = storage.read('expenses_page_$page');
        if (cachedData != null) {
          return ExpensesModal.fromJson(cachedData);
        }
      }
    } catch (e) {
      print("Error fetching expenses: $e");
    }
    return null;
  }

  /// Create a new expense
  Future<Response> createExpense(Map<String, dynamic> expenseData) async {
    try {
      return await apiClient.postData('/finance/expenses', expenseData);
    } catch (e) {
      print("Error creating expense: $e");
      rethrow;
    }
  }

  /// Update an existing expense by ID
  Future<Response> updateExpense(int id, Map<String, dynamic> updatedData) async {
    try {
      return await apiClient.putData('/finance/expenses/$id', updatedData);
    } catch (e) {
      print("Error updating expense: $e");
      rethrow;
    }
  }

  /// Delete an expense by ID
  Future<Response> deleteExpense(int id) async {
    try {
      return await apiClient.deleteData('/finance/expenses/$id');
    } catch (e) {
      print("Error deleting expense: $e");
      rethrow;
    }
  }

  /// Fetch all cashflows with optional search query
  Future<CashFlowModal?> getCashflows({String? search, int page = 1}) async {
    try {
      final response = await apiClient.getData(
        '/finance/cashflows',
        query: {
          if (search != null && search.isNotEmpty) 'search': search,
          'page': page.toString(),
        },
      );

      if (response.statusCode == 200) {
        CashFlowModal cashFlowModal = CashFlowModal.fromJson(response.body);
        storage.write('cashflows_page_$page', response.body); // Cache data
        return cashFlowModal;
      } else {
        // Fallback to cache if API call fails
        final cachedData = storage.read('cashflows_page_$page');
        if (cachedData != null) {
          return CashFlowModal.fromJson(cachedData);
        }
      }
    } catch (e) {
      print("Error fetching cashflows: $e");
    }
    return null;
  }

  /// Create a new cashflow
  Future<Response> createCashflow(Map<String, dynamic> cashflowData) async {
    try {
      return await apiClient.postData('/finance/cashflows', cashflowData);
    } catch (e) {
      print("Error creating cashflow: $e");
      rethrow;
    }
  }

  /// Update an existing cashflow by ID
  Future<Response> updateCashflow(int id, Map<String, dynamic> updatedData) async {
    try {
      return await apiClient.putData('/finance/cashflows/$id', updatedData);
    } catch (e) {
      print("Error updating cashflow: $e");
      rethrow;
    }
  }

  /// Delete a cashflow by ID
  Future<Response> deleteCashflow(int id) async {
    try {
      return await apiClient.deleteData('/finance/cashflows/$id');
    } catch (e) {
      print("Error deleting cashflow: $e");
      rethrow;
    }
  }
}
