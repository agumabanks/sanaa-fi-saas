import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/allLoansControllers.dart';

class ViewLoan extends StatelessWidget {
  final AllLoansController loanController = Get.find<AllLoansController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Details'),
        backgroundColor: Color(0xFF003E47),
      ),
      body: Obx(() {
        if (loanController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (loanController.selectedLoan.value == null) {
          return const Center(
            child: Text('Loan details not available'),
          );
        } else {
          final loan = loanController.selectedLoan.value!.data!.loan;
          final agent = loanController.selectedLoan.value!.data!.agent;
          final client = loanController.selectedLoan.value!.data!.client;
          final loanSlots = loanController.selectedLoan.value!.data!.loanSlots ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(client, loan),  // Build the header with client and loan status
                  const SizedBox(height: 20),
                  _buildClientDetails(client),  // Client details section
                  const SizedBox(height: 20),
                  _buildLoanDetails(loan, agent),  // Loan details section
                  const SizedBox(height: 20),
                  if (loanSlots.isNotEmpty) _buildLoanSlots(loanSlots),  // Loan slots section
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  // Build header with client image and buttons (edit, approve, pay)
  Widget _buildHeader(client, loan) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: client.clientPhoto != null
                  ? NetworkImage(client.clientPhoto)  // Client's photo
                  : const NetworkImage('https://lendsup.sanaa.co/public/assets/admin/img/160x160/img1.jpg'),
            ),
            const SizedBox(width: 10),
            Text(client.name ?? 'Client', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            if (loan.status == 0) _buildButton('Edit Loan', Colors.blue, Icons.edit, () {}),
            if (loan.status == 0) _buildButton('Approve', Colors.green, Icons.check, () {}),
            if (loan.status != 0) _buildButton('Pay Loan', Colors.orange, Icons.payment, () {}),
          ],
        ),
      ],
    );
  }

  // Build the button for Edit/Approve/Pay functionality
  Widget _buildButton(String label, Color color, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(label),
        style: ElevatedButton.styleFrom(backgroundColor: color),
      ),
    );
  }

  // Build client details
  Widget _buildClientDetails(client) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Client Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildDetailRow('NIN', client.nin ?? 'N/A'),
            _buildDetailRow('Phone', client.phone ?? 'N/A'),
            _buildDetailRow('Address', client.address ?? 'N/A'),
            _buildDetailRow('Credit Balance', numberFormat(client.creditBalance ?? 0)),
            _buildDetailRow('Savings Balance', numberFormat(client.savingsBalance ?? 0)),
          ],
        ),
      ),
    );
  }

  // Build loan details
  Widget _buildLoanDetails(loan, agent) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Loan Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildDetailRow('Agent', '${agent.fName} ${agent.lName}'),
            _buildDetailRow('Amount', numberFormat(loan.amount ?? 0)),
            _buildDetailRow('Installment Amount', numberFormat(loan.perInstallment ?? 0)),
            _buildDetailRow('Installment Interval (Days)', loan.installmentInterval.toString()),
            _buildDetailRow('Total Installments', loan.totalInstallment.toString()),
            _buildDetailRow('Paid Amount', numberFormat(loan.paidAmount ?? 0)),
            _buildDetailRow('Final Amount (with Interest)', numberFormat(loan.finalAmount ?? 0)),
            _buildDetailRow('Processing Fee', loan.processingFee ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  // Build a row for details with label and value
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
// Build loan slots
Widget _buildLoanSlots(List loanSlots) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Client Pay Slots', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
      const SizedBox(height: 10),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: loanSlots.asMap().entries.map<Widget>((entry) {
          int index = entry.key;
          var slot = entry.value;
          return _buildSlotCard(slot, index);  // Pass index to the card
        }).toList(),
      ),
    ],
  );
}

 // Build a slot card
Widget _buildSlotCard(slot, int index) {
  Color borderColor;
  if (slot.status == 'paid') {
    borderColor = Colors.green;
  } else if (slot.status == 'pending' && DateTime.now().isAfter(slot.date)) {
    borderColor = Colors.red;
  } else {
    borderColor = Colors.grey;
  }

  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: borderColor, width: 2),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Installment ${index + 1}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text('Amount: ${numberFormat(slot.installAmount)}'),
          Text('Date: ${slot.date}'),
          Text('Status: ${slot.status!}'),
        ],
      ),
    ),
  );
}

  // Format numbers with commas
  String numberFormat(dynamic value) {
    return value.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}
