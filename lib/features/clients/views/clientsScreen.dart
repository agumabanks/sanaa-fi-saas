import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/clients/controller/ClientController.dart';
import 'package:sanaa_fi_saas/features/clients/data/client.dart';
import 'package:sanaa_fi_saas/features/clients/views/client_profile_screen.dart';

class ClientsPage extends StatelessWidget {
  final ClientController clientController = Get.find<ClientController>();
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  ClientsPage({Key? key}) : super(key: key) {
    // Infinite scroll listener to load more clients when reaching the bottom
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !clientController.isLoading.value &&
          clientController.currentPage.value <
              (clientController.pagination.value.totalPages ?? 1)) {
        clientController.loadMoreClients();
      }
    });
  }

  // Build client list
  Widget buildClientList(List<Datum> clients) {
    return ListView.builder(
      controller: scrollController,
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final clientData = clients[index];
        final client = clientData.client; // Access the Client object
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
                        client?.name ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Phone: ${client?.phone ?? 'N/A'}'),
                      Text('Credit Balance: ${client?.creditBalance ?? '0'}'),
                      Text('Business: ${client?.business ?? 'N/A'}'),
                      Text('Added By: ${clientData.addedByName ?? 'N/A'}'),
                    ],
                  ),
                ),
                Row(
                  children: [
                    // Pay Action Button
                    IconButton(
                      icon: const Icon(Icons.credit_card),
                      onPressed: () {
                        if (client?.id != null) {
                          Get.to(() => ClientPayScreen(clientId: client!.id!));
                        }
                      },
                      tooltip: 'Pay Loan',
                    ),
                    // View Action Button
                    IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        if (client?.id != null) {
                          Get.to(() => ClientProfileScreen(clientId: client!.id!));
                        }
                      },
                      tooltip: 'View Profile',
                    ),
                    // Edit Action Button
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        if (client?.id != null) {
                          Get.to(() => ClientEditScreen(clientId: client!.id!));
                        }
                      },
                      tooltip: 'Edit Client',
                    ),
                    // Delete Action Button
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        if (client?.id != null) {
                          _confirmDelete(context, client!.id!);
                        }
                      },
                      tooltip: 'Delete Client',
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

  // Confirm client deletion
  void _confirmDelete(BuildContext context, int clientId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this client?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                clientController.deleteClient(clientId);
                Navigator.pop(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Management'),
      ),
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
                      labelText: 'Search by Name',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      clientController.searchClients(value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    clientController.searchClients(searchController.text);
                  },
                  child: const Text('Search'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    searchController.clear();
                    clientController.clearSearch();
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Client List or Loading Indicator
            Expanded(
              child: Obx(() {
                if (clientController.isLoading.value &&
                    clientController.clients.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else if (clientController.clients.isEmpty) {
                  return const Center(child: Text('No clients found.'));
                } else {
                  return buildClientList(clientController.clients);
                }
              }),
            ),
            // Pagination Loading Indicator
            Obx(() {
              if (clientController.isLoading.value &&
                  clientController.clients.isNotEmpty) {
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

// Dummy placeholder for ClientPayScreen
class ClientPayScreen extends StatelessWidget {
  final int clientId;

  ClientPayScreen({required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pay Loan for Client ID: $clientId')),
      body: Center(child: Text('Pay Loan Screen for Client ID: $clientId')),
    );
  }
}

// Dummy placeholder for ClientEditScreen
class ClientEditScreen extends StatelessWidget {
  final int clientId;

  ClientEditScreen({required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Client ID: $clientId')),
      body: Center(child: Text('Edit Screen for Client ID: $clientId')),
    );
  }
}
