// lib/controllers/client_controller.dart

import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/clients/data/api_service.dart'; 
import 'package:get_storage/get_storage.dart';
import 'package:sanaa_fi_saas/features/clients/data/client.dart';

class ClientController extends GetxController {
  final ApiService _apiService = ApiService();
  final GetStorage _storage = GetStorage();

  var clients = <Datum>[].obs;
  var isLoading = false.obs;
  var pagination = Rxn<Pagination>();
  var searchQuery = ''.obs;
  var currentPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    loadClientsFromLocalStorage();
    fetchClients();
  }

  Future<void> fetchClients({String? search, int page = 1}) async {
    isLoading.value = true;
    final response = await _apiService.getClients(search: search, page: page);

    if (response != null && response.success == true) {
      if (page == 1) {
        clients.assignAll(response.data ?? []);
      } else {
        clients.addAll(response.data ?? []);
      }
      pagination.value = response.pagination;
      searchQuery.value = search ?? '';
      currentPage.value = page;

      // Save to local storage
      await saveClientsToLocalStorage();
    } else {
      // Handle error accordingly, e.g., show a message to the user
      Get.snackbar('Error', 'Failed to fetch clients.');
    }

    isLoading.value = false;
  }

  Future<void> searchClients(String query) async {
    currentPage.value = 1;
    await fetchClients(search: query, page: 1);
  }

  Future<void> loadNextPage() async {
    if (pagination.value != null &&
        currentPage.value < (pagination.value!.totalPages ?? 1)) {
      int nextPage = currentPage.value + 1;
      currentPage.value = nextPage;
      final response =
          await _apiService.getClients(search: searchQuery.value, page: nextPage);

      if (response != null && response.success == true) {
        clients.addAll(response.data ?? []);
        pagination.value = response.pagination;

        // Update local storage
        await saveClientsToLocalStorage();
      } else {
        Get.snackbar('Error', 'Failed to load more clients.');
      }
    }
  }

  void clearClients() {
    clients.clear();
    pagination.value = null;
    searchQuery.value = '';
    currentPage.value = 1;
    _storage.remove('clients');
  }

  Future<void> saveClientsToLocalStorage() async {
    List<Map<String, dynamic>> clientsJson =
        clients.map((client) => client.toJson()).toList();
    await _storage.write('clients', clientsJson);
  }

  void loadClientsFromLocalStorage() {
    List<dynamic>? storedClients = _storage.read<List<dynamic>>('clients');
    if (storedClients != null) {
      clients.assignAll(
          storedClients.map((json) => Datum.fromJson(json)).toList());
    }
  }
}
