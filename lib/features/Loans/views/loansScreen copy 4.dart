import 'package:flutter/material.dart';

class LoansPage extends StatelessWidget {
  const LoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: const Color.fromARGB(255, 255, 255, 255),
      width: double.infinity, // This ensures the container fills all remaining space
      height: double.infinity,
      child: Center(child: LoanDashboard(),), 
    );
  }
}

// import 'package:flutter/material.dart';

class LoanDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loans Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Row(
        children: [
          // Sidebar
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              child: ListView(
                children: [
                  ListTile(
                    title: Text('All Loans'),
                    onTap: () {
                      // Navigate to All Loans Page
                    },
                  ),
                  ListTile(
                    title: Text('Pending Loans'),
                    onTap: () {
                      // Navigate to Pending Loans Page
                    },
                  ),
                  ListTile(
                    title: Text('Running Loans'),
                    onTap: () {
                      // Navigate to Running Loans Page
                    },
                  ),
                  ListTile(
                    title: Text('Loan Plans'),
                    onTap: () {
                      // Navigate to Loan Plans Page
                    },
                  ),
                  // Add other sections as needed
                ],
              ),
            ),
          ),
          // Dashboard Content
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Metrics Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DashboardMetric(
                        title: 'New Clients',
                        value: '123',
                      ),
                      DashboardMetric(
                        title: 'Total Loans',
                        value: '456',
                      ),
                      DashboardMetric(
                        title: 'Total Payments',
                        value: '\$89,000',
                      ),
                      DashboardMetric(
                        title: 'Total Profit',
                        value: '\$12,500',
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Recent Transactions
                  Text(
                    'Recent Transactions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListView.builder(
                        itemCount: 10, // Number of transactions
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Transaction #${index + 1}'),
                            subtitle: Text('Date: 2024-09-29'),
                            trailing: Text('\$100'),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
