import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/data/api/api_client.dart';
import 'package:sanaa_fi_saas/features/Reports/controllers/report_controller.dart';
import 'package:sanaa_fi_saas/features/Reports/data/AgentsRoportModal.dart';
import 'package:sanaa_fi_saas/features/Reports/data/ClientsModel.dart';
import 'package:sanaa_fi_saas/features/Reports/data/financialSummaryModal.dart';
import 'package:sanaa_fi_saas/features/Reports/data/loan-statistics.dart';
import 'package:sanaa_fi_saas/features/Reports/data/reportsRepo.dart';

class ReportsPage extends StatelessWidget {
  final ReportController reportController = Get.put(ReportController(reportRepo: ReportRepo(apiClient: Get.find())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Reports',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            _buildReportSection('Loan Statistics', Icons.analytics, reportController.loanStatistics.value),
            SizedBox(height: 20),
            _buildReportSection('Financial Summary', Icons.monetization_on_outlined, reportController.financialSummary.value),
            SizedBox(height: 20),
            _buildReportSection('Agents Report', Icons.people_alt_outlined, reportController.agentsReport.value),
            SizedBox(height: 20),
            _buildReportSection('Clients Report', Icons.person_outline, reportController.clientsReport.value),
          ],
        ),
      ),
    );
  }

  Widget _buildReportSection(String title, IconData icon, dynamic reportData) {
    return Obx(() {
      final isLoading = reportController.isLoading.value;
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.black, size: 30),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : reportData != null
                    ? _buildReportData(reportData)
                    : Center(
                        child: Text(
                          'No data available',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
          ],
        ),
      );
    });
  }

  /// Function to display report data
  Widget _buildReportData(dynamic reportData) {
    if (reportData is LoanStatisticsModal) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDataRow('Loans Disbursed', reportData.loansDisbursed.toString()),
          _buildDataRow('Loans Repaid', reportData.loansRepaid.toString()),
          _buildDataRow('Overdue Loans', reportData.overdueLoansAmount.toString()),
        ],
      );
    } else if (reportData is FinancialSummaryModal) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDataRow('Total Assets', reportData.balanceSheet!.assets!.totalAssets.toString()  ?? 'N/A'),
          _buildDataRow('Equity', reportData.balanceSheet?.equity.toString() ?? 'N/A'),
          _buildDataRow('Net Income', reportData.incomeStatement?.netIncome.toString() ?? 'N/A'),
        ],
      );
    } else if (reportData is AgentsRoportModal) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: reportData.agents
                ?.map((agent) => _buildDataRow('${agent.agentName}', 'Loans: ${agent.loansDisbursed}, Collected: ${agent.paymentsCollected}'))
                .toList() ??
            [],
      );
    } else if (reportData is ClientsRoportModal) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDataRow('New Clients', reportData.newClients.toString()),
          _buildDataRow('Active Clients', reportData.totalActiveClients.toString()),
        ],
      );
    }
    return SizedBox.shrink();
  }

  /// Widget to format data rows
  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
