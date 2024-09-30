import 'package:flutter/material.dart';

class PendingLoansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Loans'),
      ),
      body: Center(
        child: Text('Display Pending Loans Here'),
      ),
    );
  }
}


class RunningLoansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ran Loans'),
      ),
      body: Center(
        child: Text('Display rannnn Loans Here'),
      ),
    );
  }
}




class RejectedLoansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RejectedLoansPage Loans'),
      ),
      body: Center(
        child: Text('Display RejectedLoansPage Loans Here'),
      ),
    );
  }
}



class LoansHome extends StatelessWidget {
  const LoansHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Expanded(
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
