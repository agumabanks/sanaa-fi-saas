import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sanaa_fi_saas/data/api/api_client.dart';
import 'package:sanaa_fi_saas/features/Reports/data/AgentsRoportModal.dart';
import 'package:sanaa_fi_saas/features/Reports/data/ClientsModel.dart';
import 'package:sanaa_fi_saas/features/Reports/data/financialSummaryModal.dart';
import 'package:sanaa_fi_saas/features/Reports/data/loan-statistics.dart'; 

class ReportRepo {
  final ApiClient apiClient;
  final GetStorage storage = GetStorage();

  ReportRepo({required this.apiClient});

  /// Fetch daily loan statistics
  Future<LoanStatisticsModal?> getLoanStatistics() async {
    try {
      final response = await apiClient.getData('/reports/loan-statistics');

      if (response.statusCode == 200) {
        LoanStatisticsModal loanStatistics =
            LoanStatisticsModal.fromJson(response.body);
        storage.write('loan_statistics', response.body); // Cache data
        return loanStatistics;
      } else {
        // Fallback to cache if API call fails
        final cachedData = storage.read('loan_statistics');
        if (cachedData != null) {
          return LoanStatisticsModal.fromJson(cachedData);
        }
      }
    } catch (e) {
      print("Error fetching loan statistics: $e");
    }
    return null;
  }

  /// Fetch financial summary report
  Future<FinancialSummaryModal?> getFinancialSummary() async {
    try {
      final response = await apiClient.getData('/reports/financial-summary');

      if (response.statusCode == 200) {
        FinancialSummaryModal financialSummary =
            FinancialSummaryModal.fromJson(response.body);
        storage.write('financial_summary', response.body); // Cache data
        return financialSummary;
      } else {
        // Fallback to cache if API call fails
        final cachedData = storage.read('financial_summary');
        if (cachedData != null) {
          return FinancialSummaryModal.fromJson(cachedData);
        }
      }
    } catch (e) {
      print("Error fetching financial summary: $e");
    }
    return null;
  }

  /// Fetch agents report
  Future<AgentsRoportModal?> getAgentsReport() async {
    try {
      final response = await apiClient.getData('/reports/agents');

      if (response.statusCode == 200) {
        AgentsRoportModal agentsReport = AgentsRoportModal.fromJson(response.body);
        storage.write('agents_report', response.body); // Cache data
        return agentsReport;
      } else {
        // Fallback to cache if API call fails
        final cachedData = storage.read('agents_report');
        if (cachedData != null) {
          return AgentsRoportModal.fromJson(cachedData);
        }
      }
    } catch (e) {
      print("Error fetching agents report: $e");
    }
    return null;
  }

  /// Fetch clients report
  Future<ClientsRoportModal?> getClientsReport() async {  // Added Clients Report Method
    try {
      final response = await apiClient.getData('/reports/clients');

      if (response.statusCode == 200) {
        ClientsRoportModal clientsReport = ClientsRoportModal.fromJson(response.body);
        storage.write('clients_report', response.body); // Cache data
        return clientsReport;
      } else {
        // Fallback to cache if API call fails
        final cachedData = storage.read('clients_report');
        if (cachedData != null) {
          return ClientsRoportModal.fromJson(cachedData);
        }
      }
    } catch (e) {
      print("Error fetching clients report: $e");
    }
    return null;
  }

  /// Fetch cashflow report
  Future<Response> getCashflowReport() async {
    try {
      return await apiClient.getData('/reports/cashflow');
    } catch (e) {
      print("Error fetching cashflow report: $e");
      rethrow;
    }
  }

  /// Fetch new loans report
  Future<Response> getNewLoansReport() async {
    try {
      return await apiClient.getData('/reports/new-loans');
    } catch (e) {
      print("Error fetching new loans report: $e");
      rethrow;
    }
  }
}
