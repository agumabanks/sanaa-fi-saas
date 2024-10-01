
import 'package:flutter/material.dart';

// class RunningLoansPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ran Loans'),
//       ),
//       body: Center(
//         child: Text('Display rannnn Loans Here'),
//       ),
//     );
//   }
// }



// running_loans_page.dart

import 'package:flutter/material.dart';
// import 'loan_model.dart'; // Import the model
// import 'loan_detail_page.dart'; // Page to display loan details

class RunningLoansPage extends StatelessWidget {
  final List<Loan> loans;

  RunningLoansPage({required this.loans});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Running Loans',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.separated(
        itemCount: loans.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: Colors.grey[300],
        ),
        itemBuilder: (context, index) {
          final loan = loans[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              'UGX ${loan.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${loan.client.name} • ${loan.createdAt.toLocal().toShortDateString()}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
            onTap: () {
              // Navigate to loan detail page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoanDetailPage(loan: loan),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
