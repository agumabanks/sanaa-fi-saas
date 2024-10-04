import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/Reports/data/AgentsRoportModal.dart';
import 'package:sanaa_fi_saas/features/Reports/data/ClientsModel.dart';
import 'package:sanaa_fi_saas/features/Reports/data/financialSummaryModal.dart';
import 'package:sanaa_fi_saas/features/Reports/data/loan-statistics.dart';
import 'package:sanaa_fi_saas/features/Reports/data/reportsRepo.dart'; // Added Clients Report Model

class ReportController extends GetxController {
  final ReportRepo reportRepo;

  ReportController({required this.reportRepo});

  var loanStatistics = LoanStatisticsModal().obs;
  var financialSummary = FinancialSummaryModal().obs;
  var agentsReport = AgentsRoportModal().obs;
  var clientsReport = ClientsRoportModal().obs;  // Added Clients Report Observable
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLoanStatistics();
    fetchFinancialSummary();
    fetchAgentsReport();
    fetchClientsReport();  // Added call to fetch clients report
  }

  /// Fetch Loan Statistics from the Repo
  void fetchLoanStatistics() async {
    try {
      isLoading(true);
      LoanStatisticsModal? stats = await reportRepo.getLoanStatistics();
      if (stats != null) {
        loanStatistics(stats);
      }
    } catch (e) {
      print("Error fetching loan statistics: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Fetch Financial Summary from the Repo
  void fetchFinancialSummary() async {
    try {
      isLoading(true);
      FinancialSummaryModal? summary = await reportRepo.getFinancialSummary();
      if (summary != null) {
        financialSummary(summary);
      }
    } catch (e) {
      print("Error fetching financial summary: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Fetch Agents Report from the Repo
  void fetchAgentsReport() async {
    try {
      isLoading(true);
      AgentsRoportModal? report = await reportRepo.getAgentsReport();
      if (report != null) {
        agentsReport(report);
      }
    } catch (e) {
      print("Error fetching agents report: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Fetch Clients Report from the Repo
  void fetchClientsReport() async {   // Added method to fetch clients report
    try {
      isLoading(true);
      ClientsRoportModal? report = await reportRepo.getClientsReport();
      if (report != null) {
        clientsReport(report);
      }
    } catch (e) {
      print("Error fetching clients report: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Fetch Cashflow Report
  Future<void> fetchCashflowReport() async {
    try {
      isLoading(true);
      await reportRepo.getCashflowReport();
    } catch (e) {
      print("Error fetching cashflow report: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Fetch New Loans Report
  Future<void> fetchNewLoansReport() async {
    try {
      isLoading(true);
      await reportRepo.getNewLoansReport();
    } catch (e) {
      print("Error fetching new loans report: $e");
    } finally {
      isLoading(false);
    }
  }
}
