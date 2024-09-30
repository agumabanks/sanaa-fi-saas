import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/LoanController.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/allLoansControllers.dart';

class AllLoansPage extends StatelessWidget {
  //  late LoanController loanController;// = Get.put(LoanController(loanRepo: Get.find()));
  final AllLoansController loanController =  Get.find<AllLoansController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Loans'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        if (loanController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (loanController.loans.isEmpty) {
          return const Center(
            child: Text('No loans available'),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 30.0,
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromARGB(255, 0, 178, 118)), // Green Header
              columns: const [
                DataColumn(
                  label: Text(
                    'AGENT',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'PLAN',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'AMOUNT',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'STATUS',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ACTION',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: _buildLoanRows(),
            ),
          );
        }
      }),
    );
  }

  // Helper method to build loan rows for the DataTable
  List<DataRow> _buildLoanRows() {
    return loanController.loans.map((loan) {
      return DataRow(cells: [
        DataCell(Text(loan.userId.toString())),  // Agent - replace with agent name if available
        DataCell(Text(loan.planId.toString())),  // Plan - replace with actual plan name
        DataCell(Text('${loan.amount}')),  // Amount
        DataCell(
          Text(loan.status == 1 ? 'Active' : 'Not Active'),  // Inline status check for Active or Not Active
        ),
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(Icons.visibility, color: Colors.green),
              onPressed: () {
                // Implement view functionality here
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Implement edit functionality here
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Implement delete functionality here
              },
            ),
          ],
        )),
      ]);
    }).toList();
  }

  // Helper method to convert loan status to readable text
  String _getLoanStatus(int status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Running';
      case 2:
        return 'Paid';
      case 3:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }
}
