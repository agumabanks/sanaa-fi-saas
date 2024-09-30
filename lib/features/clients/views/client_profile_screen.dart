import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sanaa_fi_saas/features/clients/controller/client_profile_controller.dart';
import 'package:sanaa_fi_saas/features/clients/data/client_profile.dart';

class ClientProfileScreen extends StatelessWidget {
  final int clientId;

  ClientProfileScreen({required this.clientId});

  final ClientProfileController controller = Get.find<ClientProfileController>();

  @override
  Widget build(BuildContext context) {
    controller.fetchClientProfile(clientId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.isError.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.redAccent, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      controller.fetchClientProfile(clientId);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (controller.clientProfile.value == null) {
            return const Center(child: Text('No data available.'));
          } else {
            Data clientData = controller.clientProfile.value!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                          clientData.client?.clientPhoto ?? 
                          'https://lendsup.sanaa.co/public/assets/admin/img/160x160/img1.jpg',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clientData.client?.name ?? 'N/A',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(clientData.client?.email ?? 'N/A'),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("Balance:", style: TextStyle(color: Colors.grey)),
                          Text(
                            "${clientData.client?.creditBalance ?? '0.00'}",
                            style: const TextStyle(fontSize: 28, color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle New Loan
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("New Loan"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Button color
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle Pay Loan
                        },
                        icon: const Icon(Icons.payment),
                        label: const Text("Pay Loan"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Button color
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Basic Information Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Basic Information", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const Divider(),
                          _buildInfoRow("Phone", clientData.client?.phone ?? 'N/A'),
                          _buildInfoRow("Address", clientData.client?.address ?? 'N/A'),
                          _buildInfoRow("Business", clientData.client?.business ?? 'N/A'),
                          _buildInfoRow("National ID Number", clientData.client?.nin ?? 'N/A'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Client Loan History Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("All Client Loan History", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const Divider(),
                          if (clientData.clientLoans != null && clientData.clientLoans!.isNotEmpty)
                            ...clientData.clientLoans!.map((loan) => _buildLoanHistory(loan)).toList()
                          else
                            const Text("No loans found."),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Agent Information
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Agent Information", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const Divider(),
                          if (clientData.agent != null)
                            _buildAgentInfo(clientData.agent!)
                          else
                            const Text("No agent found."),
                        ],
                      ),
                    ),
                  ),

                  // Account Activity
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Account Activity", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const Divider(),
                          _buildInfoRow(
                            "Created At",
                            clientData.client?.createdAt != null
                                ? DateFormat.yMMMd().add_jm().format(clientData.client!.createdAt!)
                                : 'N/A',
                          ),
                          _buildInfoRow(
                            "Updated At",
                            clientData.client?.updatedAt != null
                                ? DateFormat.yMMMd().add_jm().format(clientData.client!.updatedAt!)
                                : 'N/A',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 16, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildLoanHistory(ClientLoan loan) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Loan ID: ${loan.id}"),
          Text("Amount: ${loan.amount}"),
          Text("Status: ${loan.status == 1 ? 'Running' : 'N/A'}"),
          Text("Create Date: ${DateFormat.yMMMd().add_jm().format(loan.createdAt!)}"),
          Text("Payable in: ${loan.installmentInterval} days"),
        ],
      ),
    );
  }

  Widget _buildAgentInfo(Agent agent) {
    return Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
            agent.imageFullpath ?? 'https://lendsup.sanaa.co/public/assets/admin/img/160x160/img1.jpg',
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(agent.fName ?? 'N/A', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(agent.occupation ?? 'N/A'),
            Text(agent.phone ?? 'N/A'),
          ],
        ),
      ],
    );
  }
}
