import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sanaa_fi_saas/data/api/api_client.dart';
import 'package:sanaa_fi_saas/features/clients/data/client.dart';
import 'package:sanaa_fi_saas/features/clients/data/client_profile.dart';

class ClientRepo {
  final ApiClient apiClient;
  final GetStorage storage = GetStorage();

  ClientRepo({required this.apiClient});

  // Fetch paginated list of clients with optional search query
  Future<AllClients?> getClients({String? search, int page = 1}) async {
    final response = await apiClient.getData(
      '/dclients',
      query: {
        if (search != null && search.isNotEmpty) 'search': search,
        'page': page.toString(),
      },
    );

    if (response.statusCode == 200) {
      AllClients allClients = AllClients.fromJson(response.body);
      // Cache the data for offline access
      storage.write('clients_page_$page', response.body);
      return allClients;
    } else {
      // Attempt to retrieve cached data
      final cachedData = storage.read('clients_page_$page');
      if (cachedData != null) {
        return AllClients.fromJson(cachedData);
      }
      return null;
    }
  }

  // Create a new client
  Future<Response> addClient(Map<String, dynamic> clientData) async {
    return await apiClient.postData('/dclients', clientData);
  }

  // Get client details by ID
Future<ClientData?> getClientById(int id) async {
  final response = await apiClient.getData('/dclients/$id');

  // Check if the request was successful
  if (response.statusCode == 200) {
    // Parse the JSON response into ClientData
    return ClientData.fromJson(response.body);
  } else {
    // Handle non-200 responses
    return null;
  }
}

  // Update an existing client by ID
  Future<Response> updateClient(int id, Map<String, dynamic> updatedData) async {
    return await apiClient.putData('/dclients/$id', updatedData);
  }

  // Delete a client by ID
  Future<Response> deleteClient(int id) async {
    return await apiClient.deleteData('/dclients/$id');
  }

  // Search clients by name, phone, or other details
  Future<AllClients?> searchClients(String query) async {
    final response = await apiClient.getData('/dclients/search', query: {'q': query});
    if (response.statusCode == 200) {
      return AllClients.fromJson(response.body);
    } else {
      return null;
    }
  }

  // Get client loans by client ID
  Future<Response> getClientLoans(int clientId) async {
    return await apiClient.getData('/dclients/$clientId/loans');
  }

  // Upload client photo and national ID photo
  Future<Response> uploadClientPhotos(Map<String, String> body, List<MultipartBody> multipartFiles) async {
    return await apiClient.postMultipartData('/dclients/upload-photos', body, multipartFiles);
  }
}


// import 'package:get/get_connect/http/src/response/response.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:sanaa_fi_saas/data/api/api_client.dart';
// import 'package:sanaa_fi_saas/features/clients/data/client.dart';
// import 'package:sanaa_fi_saas/features/clients/data/client_profile.dart';
// // ... (Other imports)

// class ClientRepo {
//   final ApiClient apiClient;
//   final GetStorage storage = GetStorage();

//   ClientRepo({required this.apiClient});


//   Future<AllClients?> getClients({String? search, int page = 1}) async {
//     final response = await apiClient.getData(
//       '/dclients',
//       query: {
//         if (search != null && search.isNotEmpty) 'search': search,
//         'page': page.toString(),
//       },
//     );

//     if (response.statusCode == 200) {
//       AllClients allClients = AllClients.fromJson(response.body);
      
//       // Cache the data for offline access
//       storage.write('clients_page_$page', response.body);

//       return allClients;
//     } else {
//       // Attempt to retrieve cached data
//       final cachedData = storage.read('clients_page_$page');
//       if (cachedData != null) {
//         return AllClients.fromJson(cachedData);
//       }
//       return null;
//     }
//   }

//   Future<Response> addClient(Map<String, dynamic> clientData) async {
//     return await apiClient.postData('/dclients', clientData);
//   }


//    Future<ClientProfile?> getClientById(int id) async {
//     final response = await apiClient.getData('/dclients/$id');

//     if (response.statusCode == 200) {
//       return ClientProfile.fromJson(response.body);
//     } else {
//       // Handle API-level errors
//       return null;
//     }
//   }
// }
