import 'package:flutter/material.dart';

// class ClientsPage extends StatelessWidget {
//   const ClientsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       color: const Color.fromARGB(255, 255, 255, 255),
//       width: double.infinity, // This ensures the container fills all remaining space
//       height: double.infinity,
//       child: Center(child: Text("clients"),), 
//     );
//   }
// }



// lib/screens/client_management_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/clients/controller/ClientController.dart';
import 'package:sanaa_fi_saas/features/clients/data/client.dart';
// import '../controllers/client_controller.dart';
// import '../models/all_clients.dart';

class ClientsPage extends StatelessWidget {
  final ClientController controller = Get.find<ClientController>();
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  ClientsPage({Key? key}) : super(key: key) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !controller.isLoading.value &&
          controller.currentPage.value < (controller.pagination.value?.totalPages ?? 1)) {
        controller.loadNextPage();
      }
    });
  }

  Widget buildClientList(List<Datum> clients) {
    return ListView.builder(
      controller: scrollController,
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(client.name != null && client.name!.isNotEmpty
                  ? client.name![0]
                  : '?'),
            ),
            title: Text(client.name ?? 'Unnamed Client'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${client.email ?? 'N/A'}'),
                Text('Phone: ${client.phone ?? 'N/A'}'),
                Text('NIN: ${client.nin ?? 'N/A'}'),
                Text('Added By: ${client.addedBy != null ? client.addedBy.toString().split('.').last.replaceAll('_', ' ') : 'N/A'}'),
                Text('Created At: ${client.createdAt != null ? client.createdAt!.toLocal().toString().split('.').first : 'N/A'}'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPagination() {
    return Obx(() {
      if (controller.pagination.value == null) return SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: controller.currentPage.value > 1 && !controller.isLoading.value
                  ? () => controller.fetchClients(
                        search: controller.searchQuery.value,
                        page: controller.currentPage.value - 1,
                      )
                  : null,
              child: Text('Previous'),
            ),
            SizedBox(width: 20),
            Text('Page ${controller.currentPage.value} of ${controller.pagination.value!.totalPages}'),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed:(){} ,
              // (
              //   controller.pagination.value != null &&
              //         controller.currentPage.value < controller.pagination.value!.totalPages
              //         ) &&
              //         !controller.isLoading.value
              //     ? () => controller.fetchClients(
              //           search: controller.searchQuery.value,
              //           page: controller.currentPage.value + 1,
              //         )
              //     : null,
              child: Text('Next'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Management'),
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
                    decoration: InputDecoration(
                      labelText: 'Search Clients',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      controller.searchClients(value);
                    },
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    controller.searchClients(searchController.text);
                  },
                  child: Text('Search'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    searchController.clear();
                    controller.clearClients();
                    controller.fetchClients();
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Client List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.clients.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.clients.isEmpty) {
                  return Center(child: Text('No clients found.'));
                } else {
                  return buildClientList(controller.clients);
                }
              }),
            ),
            // Pagination Controls
            buildPagination(),
            // Loading Indicator for Pagination
            Obx(() {
              if (controller.isLoading.value && controller.clients.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
