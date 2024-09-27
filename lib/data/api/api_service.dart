// // lib/services/api_service.dart

// import 'package:get/get.dart';
// import '../models/all_clients.dart';
// import '../config/app_config.dart';

// class ApiService extends GetConnect {
//   ApiService() {
//     httpClient.baseUrl = AppConfig.apiBaseUrl;
//     httpClient.defaultContentType = 'application/json';
//     // Add headers if needed, e.g., authorization
//     // httpClient.addRequestModifier<void>((request) {
//     //   request.headers['Authorization'] = 'Bearer YOUR_TOKEN';
//     //   return request;
//     // });
//   }

//   Future<AllClients?> getClients({String? search, int page = 1}) async {
//     try {
//       final response = await get(
//         '/dclients',
//         query: {
//           if (search != null && search.isNotEmpty) 'search': search,
//           'page': page.toString(),
//         },
//       );

//       if (response.status.hasError) {
//         print('HTTP Error: ${response.statusCode} - ${response.statusText}');
//         return null;
//       } else {
//         final body = response.body;
//         if (body['success']) {
//           return AllClients.fromJson(body);
//         } else {
//           // Handle API-level errors
//           print('API Error: ${body}');
//           return null;
//         }
//       }
//     } catch (e) {
//       // Handle network or parsing errors
//       print('Error fetching clients: $e');
//       return null;
//     }
//   }
// }
