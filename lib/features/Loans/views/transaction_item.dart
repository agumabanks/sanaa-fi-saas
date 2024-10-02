// lib/widgets/transaction_item.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanaa_fi_saas/features/Loans/data/latestPaymentTransactions.dart';

class TransactionItem extends StatelessWidget {
  final Datum transaction;

  TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final clientName = transaction.client?.name ?? 'Unknown Client';
    final amount = transaction.amount ?? '0';
    final paymentDate = transaction.paymentDate != null
        ? DateFormat.yMMMd().format(transaction.paymentDate!)
        : 'Unknown Date';
    final transactionId = transaction.id?.toString() ?? 'N/A';
    final agentName = transaction.agent != null
        ? '${transaction.agent!.fName?.name ?? ''} ${transaction.agent!.lName?.name ?? ''}'
        : 'Unknown Agent';

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: Color(0xFF003E47),
        child: Icon(Icons.payment, color: Colors.white),
      ),
      title: Text(
        'UGX $amount',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Text(
            'Client: $clientName',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          Text(
            'Agent: $agentName',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          Text(
            'Date: $paymentDate',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          Text(
            'Transaction ID: $transactionId',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      onTap: () {
        // Navigate to transaction details if needed
        // For example:
        // Get.to(TransactionDetailPage(transaction: transaction));
      },
    );
  }
}
