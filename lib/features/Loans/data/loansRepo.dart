import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sanaa_fi_saas/data/api/api_client.dart';
import 'package:sanaa_fi_saas/features/Loans/data/AllLoanPlans.dart';
import 'package:sanaa_fi_saas/features/Loans/data/ClientLoanDetails.dart';
import 'package:sanaa_fi_saas/features/Loans/data/ClientLoanspayHistory.dart';
import 'package:sanaa_fi_saas/features/Loans/data/PendingLoansModal.dart';
import 'package:sanaa_fi_saas/features/Loans/data/RejectedLoansModal.dart';
import 'package:sanaa_fi_saas/features/Loans/data/RunningLoansModal.dart';
import 'package:sanaa_fi_saas/features/Loans/data/allLoansModal.dart';
import 'package:sanaa_fi_saas/features/Loans/data/loanModal.dart';
import 'package:sanaa_fi_saas/features/Loans/data/viewLoanModal.dart';

class LoanRepo {
  final ApiClient apiClient;
  final GetStorage storage = GetStorage();

  LoanRepo({required this.apiClient});

  // Fetch all loans with optional search query
Future<AllLoansModal?> getAllLoans({String? search, int page = 1}) async {
  try {
    final response = await apiClient.getData(
      '/d/loans/all',
      query: {
        if (search != null && search.isNotEmpty) 'search': search,
        'page': page.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Corrected variable name from 'AllLoAllLoansModalans' to 'AllLoansModal'
      AllLoansModal allLoans = AllLoansModal.fromJson(response.body);
      storage.write('loans_page_$page', response.body); // Cache data
      return allLoans;
    } else {
      // Fallback to cache if API fails
      final cachedData = storage.read('loans_page_$page');
      if (cachedData != null) {
        return AllLoansModal.fromJson(cachedData);
      }
    }
  } catch (e) {
    print("Error fetching loans: $e");
  }
  return null;
}


// Fetch all Pending loans with optional search query
Future<PendingLoansModal?> getPendingLoans({String? search, int page = 1}) async {
  try {
    final response = await apiClient.getData(
      '/d/loans/pending',
      query: {
        if (search != null && search.isNotEmpty) 'search': search,
        'page': page.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Corrected variable name from 'AllLoAllLoansModalans' to 'AllLoansModal'
      PendingLoansModal allLoans = PendingLoansModal.fromJson(response.body);
      storage.write('loans_page_$page', response.body); // Cache data
      return allLoans;
    } else {
      // Fallback to cache if API fails
      final cachedData = storage.read('loans_page_$page');
      if (cachedData != null) {
        return PendingLoansModal.fromJson(cachedData);
      }
    }
  } catch (e) {
    print("Error fetching loans: $e");
  }
  return null;
}



// Fetch all Rejected loans with optional search query
Future<RejectedLoansModal?> getRejectedLoans({String? search, int page = 1}) async {
  try {
    final response = await apiClient.getData(
      '/d/loans/rejected',
      query: {
        if (search != null && search.isNotEmpty) 'search': search,
        'page': page.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Corrected variable name from 'AllLoAllLoansModalans' to 'AllLoansModal'
      RejectedLoansModal allLoans = RejectedLoansModal.fromJson(response.body);
      storage.write('loans_page_$page', response.body); // Cache data
      return allLoans;
    } else {
      // Fallback to cache if API fails
      final cachedData = storage.read('loans_page_$page');
      if (cachedData != null) {
        return RejectedLoansModal.fromJson(cachedData);
      }
    }
  } catch (e) {
    print("Error fetching loans: $e");
  }
  return null;
}


// Fetch all Pending loans with optional search query
Future<RunningLoansModal?> getRunniningLoans({String? search, int page = 1}) async {
  try {
    final response = await apiClient.getData(
      '/d/loans/running',
      query: {
        if (search != null && search.isNotEmpty) 'search': search,
        'page': page.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Corrected variable name from 'AllLoAllLoansModalans' to 'AllLoansModal'
      RunningLoansModal allLoans = RunningLoansModal.fromJson(response.body);
      storage.write('loans_page_$page', response.body); // Cache data
      return allLoans;
    } else {
      // Fallback to cache if API fails
      final cachedData = storage.read('loans_page_$page');
      if (cachedData != null) {
        return RunningLoansModal.fromJson(cachedData);
      }
    }
  } catch (e) {
    print("Error fetching loans: $e");
  }
  return null;
}



  // Get loan details by ID
  Future<ViewLoanModal?> getLoanById(int id) async {
    try {
      final response = await apiClient.getData('/d/loans/$id/show');
      if (response.statusCode == 200) {
        return ViewLoanModal.fromJson(response.body);
      }
    } catch (e) {
      print("Error fetching loan details: $e");
    }
    return null;
  }

  // Create a new loan
  Future<Response> createLoan(Map<String, dynamic> loanData) async {
    try {
      return await apiClient.postData('/dloans/create', loanData);
    } catch (e) {
      print("Error creating loan: $e");
      rethrow;
    }
  }

  // Update an existing loan by ID
  Future<Response> updateLoan(int id, Map<String, dynamic> updatedData) async {
    try {
      return await apiClient.putData('/dloans/save-edit/$id', updatedData);
    } catch (e) {
      print("Error updating loan: $e");
      rethrow;
    }
  }

  // Delete a loan by ID
  Future<Response> deleteLoan(int id) async {
    try {
      return await apiClient.deleteData('/dloans/$id');
    } catch (e) {
      print("Error deleting loan: $e");
      rethrow;
    }
  }

  // Get loans for a specific client
  Future<AllLoans?> getClientLoans(int clientId) async {
    try {
      final response = await apiClient.getData('/dclients/$clientId/loans');
      if (response.statusCode == 200) {
        return AllLoans.fromJson(response.body);
      }
    } catch (e) {
      print("Error fetching client loans: $e");
    }
    return null;
  }

  // Get loans for a specific user/agent
  Future<AllLoans?> getUserLoans(int userId) async {
    try {
      final response = await apiClient.getData('/dusers/$userId/loans');
      if (response.statusCode == 200) {
        return AllLoans.fromJson(response.body);
      }
    } catch (e) {
      print("Error fetching user loans: $e");
    }
    return null;
  }

  // Pay loan
  Future<Response> payLoan(Map<String, dynamic> paymentData) async {
    try {
      return await apiClient.postData('/dloans/pay', paymentData);
    } catch (e) {
      print("Error processing loan payment: $e");
      rethrow;
    }
  }

  // Reverse payment
  Future<Response> reversePayment(int id) async {
    try {
      return await apiClient.postData('/dloans/$id/reverse', {});
    } catch (e) {
      print("Error reversing payment: $e");
      rethrow;
    }
  }

  // Approve loan
  Future<Response> approveLoan(int id) async {
    try {
      return await apiClient.postData('/dloans/$id/approve', {});
    } catch (e) {
      print("Error approving loan: $e");
      rethrow;
    }
  }

  // Fetch all loan plans
  Future<AllLoanPlans?> getLoanPlans10() async {
    try {
      final response = await apiClient.getData('/dloan-plans');
      if (response.statusCode == 200) {
        AllLoanPlans allLoanPlans = AllLoanPlans.fromJson(response.body);
        storage.write('loan_plans', response.body); // Cache the data
        return allLoanPlans;
      } else {
        // Attempt to retrieve cached data
        final cachedData = storage.read('loan_plans');
        if (cachedData != null) {
          return AllLoanPlans.fromJson(cachedData);
        }
      }
    } catch (e) {
      print("Error fetching loan plans: $e");
    }
    return null;
  }

  // Repository function for fetching loan plans
Future<AllLoanPlans?> getLoanPlans() async {
  try {
    final response = await apiClient.getData('/d/loan-plans');
    if (response.statusCode == 200) {
      AllLoanPlans allLoanPlans = AllLoanPlans.fromJson(response.body);
      storage.write('loan_plans', response.body); // Cache the data
      return allLoanPlans;
    } else {
      // Attempt to retrieve cached data
      final cachedData = storage.read('loan_plans');
      if (cachedData != null) {
        return AllLoanPlans.fromJson(cachedData);
      }
    }
  } catch (e) {
    print("Error fetching loan plans: $e");
  }
  return null;
}


  // Create a loan plan
  Future<Response> createLoanPlan(Map<String, dynamic> planData) async {
    try {
      return await apiClient.postData('/dplans/create', planData);
    } catch (e) {
      print("Error creating loan plan: $e");
      rethrow;
    }
  }

  // Update loan plan
  Future<Response> updateLoanPlan(int id, Map<String, dynamic> updatedData) async {
    try {
      return await apiClient.putData('/dplans/$id/update', updatedData);
    } catch (e) {
      print("Error updating loan plan: $e");
      rethrow;
    }
  }

  // Delete loan plan
  Future<Response> deleteLoanPlan(int id) async {
    try {
      return await apiClient.deleteData('/dplans/$id/destroy');
    } catch (e) {
      print("Error deleting loan plan: $e");
      rethrow;
    }
  }

  // Get client loan payment history
  Future<ClientLoanspayHistory?> getClientLoanPaymentHistory(int clientId) async {
    try {
      final response = await apiClient.getData('/d/dclients/$clientId/loan-history');
      if (response.statusCode == 200) {
        return ClientLoanspayHistory.fromJson(response.body);
      }
    } catch (e) {
      print("Error fetching loan payment history: $e");
    }
    return null;
  }

  // Get total amount for an agent on a specific date
  Future<Map<String, dynamic>?> getTotalAmountForAgentOnDate(int agentId, {DateTime? date}) async {
    try {
      final response = await apiClient.postData(
        '/dagents/$agentId/total-amount',
        {'date': date?.toIso8601String() ?? DateTime.now().toIso8601String()},
      );
      if (response.statusCode == 200) {
        return response.body['data'];
      }
    } catch (e) {
      print("Error fetching agent's total amount: $e");
    }
    return null;
  }
}
