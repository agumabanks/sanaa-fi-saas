// lib/pages/transactions_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/transaction_history_controller.dart';
import 'package:sanaa_fi_saas/features/Loans/views/transaction_item.dart';
// import 'package:sanaa_fi_saas/controllers/transaction_history_controller.dart';
// import 'package:sanaa_fi_saas/widgets/transaction_item.dart';

class TransactionsPage extends StatelessWidget {
  final TransactionHistoryController controller = Get.find<TransactionHistoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          // Search Icon
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              showSearch(context: context, delegate: TransactionSearchDelegate(controller));
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.transactions.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.isError.value && controller.transactions.isEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.transactions.isEmpty) {
          return Center(child: Text('No transactions found.'));
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoading.value &&
                  scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                  controller.currentPage.value < controller.lastPage.value) {
                controller.loadMore();
              }
              return false;
            },
            child: Container(
               decoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(18)
                          ),
              child: ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: controller.transactions.length + 1,
                separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[300]),
                itemBuilder: (context, index) {
                  if (index < controller.transactions.length) {
                    final transaction = controller.transactions[index];
                    return TransactionItem(transaction: transaction);
                  } else {
                    return controller.isLoading.value
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : SizedBox.shrink();
                  }
                },
              ),
            ),
          );
        }
      }),
    );
  }
}

// **Search Delegate for Transactions**
class TransactionSearchDelegate extends SearchDelegate {
  final TransactionHistoryController controller;

  TransactionSearchDelegate(this.controller);

  @override
  String get searchFieldLabel => 'Search Transactions';

  @override
  TextStyle? get searchFieldStyle => TextStyle(color: Colors.black);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear, color: Colors.black),
          onPressed: () {
            query = '';
            controller.setSearchQuery('');
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        close(context, null); // Close the search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    controller.setSearchQuery(query);
    return Obx(() {
      if (controller.isLoading.value && controller.transactions.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else if (controller.isError.value && controller.transactions.isEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      } else if (controller.transactions.isEmpty) {
        return Center(child: Text('No transactions found for "$query".'));
      } else {
        return ListView.separated(
          padding: EdgeInsets.all(16),
          itemCount: controller.transactions.length,
          separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[300]),
          itemBuilder: (context, index) {
            final transaction = controller.transactions[index];
            return TransactionItem(transaction: transaction);
          },
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Optionally, implement suggestions based on the query
    return Container();
  }
}
