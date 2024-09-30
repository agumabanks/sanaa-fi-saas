import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sanaa_fi_saas/data/api/api_client.dart';
import 'package:sanaa_fi_saas/features/Loans/data/AllLoanPlans.dart';
import 'package:sanaa_fi_saas/features/Loans/data/ClientLoanDetails.dart';
import 'package:sanaa_fi_saas/features/Loans/data/ClientLoanspayHistory.dart';
import 'package:sanaa_fi_saas/features/Loans/data/loanModal.dart';
import 'package:sanaa_fi_saas/features/clients/data/client_profile.dart';
// Import your loan models here
// import 'package:sanaa_fi_saas/features/loans/data/all_loans.dart';
// Import other models as needed
// import 'package:sanaa_fi_saas/features/clients/data/client.dart';
// import 'package:sanaa_fi_saas/features/loans/data/loan_plan.dart';
// import 'package:sanaa_fi_saas/features/loans/data/loan_installment.dart';

class LoanRepo {
  final ApiClient apiClient;
  final GetStorage storage = GetStorage();

  LoanRepo({required this.apiClient});

  // Fetch all loans with optional search query
  Future<AllLoans?> getAllLoans({String? search, int page = 1}) async {
    final response = await apiClient.getData(
      '/dloans/all',
      query: {
        if (search != null && search.isNotEmpty) 'search': search,
        'page': page.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response into AllLoans
      AllLoans allLoans = AllLoans.fromJson(response.body);

      // Cache the data for offline access
      storage.write('loans_page_$page', response.body);

      return allLoans;
    } else {
      // Attempt to retrieve cached data
      final cachedData = storage.read('loans_page_$page');
      if (cachedData != null) {
        return AllLoans.fromJson(cachedData);
      }
      return null;
    }
  }

 // Get loan details by ID
  Future<ClientLoanDetails?> getLoanById(int id) async {
    final response = await apiClient.getData('/d/dloans/$id/show');

    if (response.statusCode == 200) {
      // Parse the JSON response into ClientLoanDetails
      ClientLoanDetails loanDetails = ClientLoanDetails.fromJson(response.body);
      return loanDetails;
    } else {
      return null;
    }
  }


  // Create a new loan
  Future<Response> createLoan(Map<String, dynamic> loanData) async {
    return await apiClient.postData('/dloans/create', loanData);
  }

  // Update an existing loan by ID
  Future<Response> updateLoan(int id, Map<String, dynamic> updatedData) async {
    return await apiClient.putData('/dloans/save-edit/$id', updatedData);
  }

  // Delete a loan by ID
  Future<Response> deleteLoan(int id) async {
    return await apiClient.deleteData('/dloans/$id');
  }

  // Get loans for a specific client
  Future<AllLoans?> getClientLoans(int clientId) async {
    final response = await apiClient.getData('/dclients/$clientId/loans');
    if (response.statusCode == 200) {
      // Assuming the response structure is similar to AllLoans
      AllLoans clientLoans = AllLoans.fromJson(response.body);
      return clientLoans;
    } else {
      return null;
    }
  }

  // Get loans for a specific agent/user
  Future<AllLoans?> getUserLoans(int userId) async {
    final response = await apiClient.getData('/dusers/$userId/loans');
    if (response.statusCode == 200) {
      AllLoans userLoans = AllLoans.fromJson(response.body);
      return userLoans;
    } else {
      return null;
    }
  }

  // Pay loan
  Future<Response> payLoan(Map<String, dynamic> paymentData) async {
    return await apiClient.postData('/dloans/pay', paymentData);
  }

  // Reverse payment
  Future<Response> reversePayment(int id) async {
    return await apiClient.postData('/dloans/$id/reverse', {});
  }

  // Approve loan
  Future<Response> approveLoan(int id) async {
    return await apiClient.postData('/dloans/$id/approve', {});
  }

 // Get loan plans
Future<AllLoanPlans?> getLoanPlans() async {
  final response = await apiClient.getData('/dloan-plans');
  if (response.statusCode == 200) {
    AllLoanPlans allLoanPlans = AllLoanPlans.fromJson(response.body);

    // Optionally, cache the data for offline access
    storage.write('loan_plans', response.body);

    return allLoanPlans;
  } else {
    // Attempt to retrieve cached data
    final cachedData = storage.read('loan_plans');
    if (cachedData != null) {
      return AllLoanPlans.fromJson(cachedData);
    }
    return null;
  }
}


  // Create loan plan
  Future<Response> createLoanPlan(Map<String, dynamic> planData) async {
    return await apiClient.postData('/dplans/create', planData);
  }

  // Update loan plan
  Future<Response> updateLoanPlan(int id, Map<String, dynamic> updatedData) async {
    return await apiClient.putData('/dplans/$id/update', updatedData);
  }

  // Delete loan plan
  Future<Response> deleteLoanPlan(int id) async {
    return await apiClient.deleteData('/dplans/$id/destroy');
  }

  // Get today's loan installments
  // Future<List<LoanInstallment>> getTodaysInstallments() async {
  //   final response = await apiClient.getData('/dinstallments/today');
  //   if (response.statusCode == 200) {
  //     List<LoanInstallment> installments = (response.body['data'] as List)
  //         .map((instJson) => LoanInstallment.fromJson(instJson))
  //         .toList();
  //     return installments;
  //   } else {
  //     return [];
  //   }
  // }

  // Get total amount for agent on a specific date
  Future<Map<String, dynamic>?> getTotalAmountForAgentOnDate(int agentId, {DateTime? date}) async {
    final response = await apiClient.postData(
      '/dagents/$agentId/total-amount',
      {'date': date?.toIso8601String() ?? DateTime.now().toIso8601String()},
    );
    if (response.statusCode == 200) {
      return response.body['data'];
    } else {
      return null;
    }
  }

  // Get agent's clients with running loans
  Future<List<ClientData>> getAgentsClientsWithRunningLoans(int agentId) async {
    final response = await apiClient.getData('/dagents/$agentId/clients-running-loans');
    if (response.statusCode == 200) {
      List<ClientData> clients = (response.body['data'] as List)
          .map((clientJson) => ClientData.fromJson(clientJson))
          .toList();
      return clients;
    } else {
      return [];
    }
  }

  // Get agent's clients with pending loans
  Future<List<ClientData>> getAgentsClientsWithPendingLoans(int agentId) async {
    final response = await apiClient.getData('/dagents/$agentId/clients-pending-loans');
    if (response.statusCode == 200) {
      List<ClientData> clients = (response.body['data'] as List)
          .map((clientJson) => ClientData.fromJson(clientJson))
          .toList();
      return clients;
    } else {
      return [];
    }
  }

  // Get agent's clients with paid loans
  Future<List<ClientData>> getAgentsClientsWithPaidLoans(int agentId) async {
    final response = await apiClient.getData('/dagents/$agentId/clients-paid-loans');
    if (response.statusCode == 200) {
      List<ClientData> clients = (response.body['data'] as List)
          .map((clientJson) => ClientData.fromJson(clientJson))
          .toList();
      return clients;
    } else {
      return [];
    }
  }

  // Get today's schedule for an agent
  // Future<List<LoanInstallment>> getTodaysSchedule(int agentId) async {
  //   final response = await apiClient.getData('/dagents/$agentId/schedule/today');
  //   if (response.statusCode == 200) {
  //     List<LoanInstallment> schedule = (response.body['data'] as List)
  //         .map((instJson) => LoanInstallment.fromJson(instJson))
  //         .toList();
  //     return schedule;
  //   } else {
  //     return [];
  //   }
  // }

  // Update loan payment
  Future<Response> updateLoanPayment(int loanId, Map<String, dynamic> paymentData) async {
    return await apiClient.putData('/dloans/$loanId/update-payment', paymentData);
  }

  // Store client loan
  Future<Response> storeClientLoan(Map<String, dynamic> loanData) async {
    return await apiClient.postData('/dclients/loan/store', loanData);
  }
// Get client loan payment history
Future<ClientLoanspayHistory?> getClientLoanPaymentHistory(int clientId) async {
  final response = await apiClient.getData('/d/dclients/$clientId/loan-history');
  if (response.statusCode == 200) {
    ClientLoanspayHistory paymentHistory = ClientLoanspayHistory.fromJson(response.body);
    return paymentHistory;
  } else {
    return null;
  }
}


  // Get client QR code
  Future<String?> getClientQr(int clientId) async {
    final response = await apiClient.getData('/dclients/$clientId/qr');
    if (response.statusCode == 200) {
      return response.body['qr_code'];
    } else {
      return null;
    }
  }

  // Additional methods can be added here following the same pattern
}
