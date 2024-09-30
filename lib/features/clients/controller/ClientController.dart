import 'package:get/get.dart';
import 'package:sanaa_fi_saas/data/api/api_client.dart';
import 'package:sanaa_fi_saas/features/clients/data/client.dart';
import 'package:sanaa_fi_saas/features/clients/data/client_profile.dart';
import 'package:sanaa_fi_saas/features/clients/data/client_repo.dart';
import 'package:sanaa_fi_saas/features/clients/views/clientsScreen.dart';
import 'package:sanaa_fi_saas/features/home/views/home.dart';

class ClientController extends GetxController {
  final ClientRepo clientRepo;

  ClientController({required this.clientRepo});

  var clients = <Datum>[].obs; // Observable list of clients
  var isLoading = false.obs; // Loading state
  var isError = false.obs; // Error state
  var errorMessage = ''.obs; // Error message
  
  var pagination = Pagination().obs; // For pagination data
  var currentPage = 1.obs; // Current page
  var searchQuery = ''.obs; // Search query string

  @override
  void onInit() {
    super.onInit();
    fetchClients(); // Fetch clients when the controller is initialized
  }

  // Fetch Clients with Pagination and Search
  Future<void> fetchClients({String? search, int page = 1}) async {
    try {
      isLoading(true); // Show loading
      isError(false); // Reset error state
      errorMessage('');

      final response = await clientRepo.getClients(search: search, page: page);

      if (response != null && response.success == true) {
        if (page == 1) {
          clients.assignAll(response.data ?? []); // Assign new list if it's the first page
        } else {
          clients.addAll(response.data ?? []); // Append new data to the list for other pages
        }

        pagination.value = response.pagination ?? Pagination();
        currentPage.value = page;
        searchQuery.value = search ?? '';
      } else {
        isError(true);
        errorMessage('Failed to load clients.');
      }
    } catch (e) {
      isError(true);
      errorMessage('An unexpected error occurred: $e');
      print('Error fetching clients: $e');
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Search Clients with a query
  Future<void> searchClients(String query) async {
    currentPage.value = 1; // Reset to page 1 for new search
    await fetchClients(search: query, page: 1);
  }

  // Load more clients for infinite scroll
  Future<void> loadMoreClients() async {
    if (currentPage.value < (pagination.value.totalPages ?? 1)) {
      int nextPage = currentPage.value + 1;
      await fetchClients(search: searchQuery.value, page: nextPage);
    }
  }

  // Clear search results and reset to the full list
  void clearSearch() {
    searchQuery.value = '';
    currentPage.value = 1;
    fetchClients(page: 1);
  }

  // Delete a client by ID
  Future<void> deleteClient(int clientId) async {
    try {
      isLoading(true);
      isError(false);

      final response = await clientRepo.deleteClient(clientId);
      if (response.statusCode == 200) {
        clients.removeWhere((client) => client.client?.id == clientId);

      } else {
        isError(true);
        errorMessage('Failed to delete the client.');
      }
    } catch (e) {
      isError(true);
      errorMessage('An unexpected error occurred while deleting the client.');
    } finally {
      isLoading(false);
    }
  }

  // Add a new client
  Future<void> addClient(Map<String, dynamic> clientData) async {
    try {
      isLoading(true);
      isError(false);

      final response = await clientRepo.addClient(clientData);
      if (response.statusCode == 201) {
        fetchClients(); // Refresh the client list after adding a new client
        Get.to(HomePage());
      } else {
        isError(true);
        errorMessage('Failed to add the client.');
      }
    } catch (e) {
      isError(true);
      errorMessage('An unexpected error occurred while adding the client.');
    } finally {
      isLoading(false);
    }
  }

  // Update an existing client by ID
  Future<void> updateClient(int clientId, Map<String, dynamic> updatedData) async {
    try {
      isLoading(true);
      isError(false);

      final response = await clientRepo.updateClient(clientId, updatedData);
      if (response.statusCode == 200) {
        fetchClients(); // Refresh the list after updating
      } else {
        isError(true);
        errorMessage('Failed to update the client.');
      }
    } catch (e) {
      isError(true);
      errorMessage('An unexpected error occurred while updating the client.');
    } finally {
      isLoading(false);
    }
  }

  // Get client details by ID
// Get client details by ID
Future<ClientData?> getClientById(int clientId) async {
  try {
    isLoading(true);
    isError(false);

    // Call the repository to fetch client data by ID (assuming the repository returns ClientData directly)
    final clientData = await clientRepo.getClientById(clientId);

    // Check if clientData is not null and was successfully returned
    if (clientData != null && clientData.success == true) {
      // Return the client data if success is true
      return clientData;
    } else {
      isError(true);
      errorMessage('Client not found or API returned an error.');
      return null;
    }
  } catch (e) {
    isError(true);
    errorMessage('An error occurred while fetching client details: $e');
    return null;
  } finally {
    isLoading(false);
  }
}


  // Upload client photos
  Future<void> uploadClientPhotos(Map<String, String> body, List<MultipartBody> files) async {
    try {
      isLoading(true);
      isError(false);

      final response = await clientRepo.uploadClientPhotos(body, files);
      if (response.statusCode == 200) {
        // Handle successful upload (e.g., refresh client profile if needed)
      } else {
        isError(true);
        errorMessage('Failed to upload client photos.');
      }
    } catch (e) {
      isError(true);
      errorMessage('An unexpected error occurred while uploading photos.');
    } finally {
      isLoading(false);
    }
  }
}
