import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/allLoansControllers.dart';
import 'package:sanaa_fi_saas/features/Loans/views/transactions_page.dart';
 

class PendingLoansPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Loans'),
      ),
      body: const Center(
        child: Text('Display Pending Loans Here'),
      ),
    );
  }
}








class  LoansPlansPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RejectedLoansPage Loans'),
      ),
      body: const Center(
        child: Text('Plans Loans Here'),
      ),
    );
  }
}

 
class LoansPlansPage extends StatelessWidget {
  final AllLoansController loanPlanController = Get.put(AllLoansController(loanRepo:Get.find())); // Inject the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Plans'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (loanPlanController.isLoading.value) {
            return const Center(child: CircularProgressIndicator()); // Show loading indicator
          } else if (loanPlanController.isError.value) {
            return Center(child: Text(loanPlanController.errorMessage.value)); // Show error message
          } else if (loanPlanController.loanPlans.value == null || loanPlanController.loanPlans.value!.isEmpty) {
            return const Center(child: Text('No loan plans available.')); // No data message
          } else {
            // Display the loan plans
            return ListView.builder(
              itemCount: loanPlanController.loanPlans.value!.length,
              itemBuilder: (context, index) {
                final plan = loanPlanController.loanPlans.value![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: ListTile(
                    title: Text(plan.planName ?? 'No Plan Name'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Min Amount: ${plan.minAmount ?? 'N/A'}'),
                        Text('Max Amount: ${plan.maxAmount ?? 'N/A'}'),
                        Text('Installments: ${plan.totalInstallments ?? 'N/A'}'),
                        Text('Installment Interval: ${plan.installmentInterval} days'),
                        Text('Instructions: ${plan.instructions ?? 'No Instructions'}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}



class LoansHome extends StatelessWidget {
  const LoansHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom:0),
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(188, 237, 237, 237), 
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Metrics Section
                      GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 2.0, // Adjust as needed
                          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const DashboardMetric(
                              title: 'Loan Clients',
                              value: '123',
                            ),
                            const DashboardMetric(
                              title: 'Total Loans',
                              value: '456',
                            ),
                            const DashboardMetric(
                              title: 'Total Payments',
                              value: '\$89,000',
                            ),const DashboardMetric(
                              title: 'Total Payments',
                              value: '\$89,000',
                            ),
                            const DashboardMetric(
                              title: 'Total Profit',
                              value: '\$12,500',
                            ),
                          ],
                        ),

                      const SizedBox(height: 20),
                      // Recent Transactions
                      // const Text(
                      //   'Recent Transactions',
                      //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      // ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
    border: Border.all(color: Colors.grey, ), // Set border color and width
                            borderRadius: BorderRadius.circular(18),
                          ),
                            clipBehavior: Clip.antiAlias, // Ensures child content respects the rounded corners

                          child: ClipRRect(
                                borderRadius: BorderRadius.circular(18), // Apply the same rounding to child content

                            child: TransactionsPage()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      );
  }
}



// DashboardMetric Widget
class DashboardMetric extends StatelessWidget {
  final String title;
  final String value;

  const DashboardMetric({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
