import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/LoanController.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/allLoansControllers.dart';
import 'package:intl/intl.dart';

class AllLoansPage extends StatelessWidget {
  final AllLoansController loanController = Get.find<AllLoansController>();
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  double value = 300000.00000000;
  // String formattedValue = NumberFormat("#,##0.00").format(value); 

  AllLoansPage({Key? key}) : super(key: key) {
    // Infinite scroll listener to load more loans when reaching the bottom
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !loanController.isLoading.value &&
          loanController.currentPage.value < loanController.totalPages.value) {
        loanController.loadMoreLoans();
      }
    });
  }

  // Build loan list
  Widget buildLoanList() {
    return ListView.builder(
      controller: scrollController,
      itemCount: loanController.loans.length,
      itemBuilder: (context, index) {
        final loan = loanController.loans[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loan.client?.name ?? 'Unknown Agent',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Agent: ${loan.agent?.name ?? 'Unknown Client'}'),
                      Text('Amount: ${(loan.amount != null) ? NumberFormat("#,##0").format(double.parse(loan.amount.toString())) : 'N/A'}'),

                      Text('Status: ${_getLoanStatus(loan.status)}'),
                    ],
                  ),
                ),
                Row(
                  children: [
                    // View Action Button
                    IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        // Implement view functionality
                        // currentPage
                        loanController.viewLoan(loan.id!);
                        // Get.find<LoanController>().changePage(4);
                      },
                      tooltip: 'View Loan',
                    ),
                    // Edit Action Button
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Implement edit functionality
                      },
                      tooltip: 'Edit Loan',
                    ),
                    // Delete Action Button
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Implement delete functionality
                      },
                      tooltip: 'Delete Loan',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper to convert loan status to readable text
  String _getLoanStatus(int? status) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search by Agent Name',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      loanController.searchLoans(value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    loanController.searchLoans(searchController.text);
                  },
                  child: const Text('Search'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    searchController.clear();
                    loanController.clearSearch();
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Loan List or Loading Indicator
            Expanded(
              child: Obx(() {
                if (loanController.isLoading.value && loanController.loans.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else if (loanController.loans.isEmpty) {
                  return const Center(child: Text('No loans found.'));
                } else {
                  return buildLoanList();
                }
              }),
            ),
            // Pagination Loading Indicator
            Obx(() {
              if (loanController.isLoading.value && loanController.loans.isNotEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
