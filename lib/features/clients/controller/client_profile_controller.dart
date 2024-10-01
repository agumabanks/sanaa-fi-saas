// // lib/controllers/client_profile_controller.dart

// import 'package:get/get.dart';
// import 'package:sanaa_fi_saas/features/clients/data/client_profile.dart';
// import 'package:sanaa_fi_saas/features/clients/data/client_repo.dart';

// class ClientProfileController extends GetxController {
//   final ClientRepo clientRepo;

//   ClientProfileController({required this.clientRepo});

//   var clientProfile = Rxn<Data>();
//   var isLoading = false.obs;
//   var isError = false.obs;
//   var errorMessage = ''.obs;

//   Future<void> fetchClientProfile(int clientId) async {
//     try {
//       isLoading(true);
//       isError(false);
//       errorMessage('');

//       final response = await clientRepo.getClientById(clientId);

//       if (response != null && response.success == true && response.data != null) {
//         clientProfile.value = response.data;
//       } else {
//         isError(true);
//         errorMessage('Failed to load client profile.');
//       }
//     } catch (e) {
//       isError(true);
//       errorMessage('An unexpected error occurred.');
//       print('Error fetching client profile: $e');
//     } finally {
//       isLoading(false);
//     }
//   }

//   void clearProfile() {
//     clientProfile.value = null;
//     isError(false);
//     errorMessage('');
//   }

//    // Method to clear client profile data
//   void clearClientProfile() {
//     clientProfile.value = null;
//     isError.value = false;
//     errorMessage.value = '';
//   }
// }


import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/clients/data/client_profile.dart';
import 'package:sanaa_fi_saas/features/clients/data/client_repo.dart';

class ClientProfileController extends GetxController {
  final ClientRepo clientRepo;

  ClientProfileController({required this.clientRepo});

  var clientId = Rxn<int>(); // Added variable to track current client ID
  var clientProfile = Rxn<Data>();
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchClientProfile(int clientId) async {
    // Check if the profile for the requested clientId is already loaded
    if (this.clientId.value != clientId || clientProfile.value == null) {
      try {
        isLoading(true);
        isError(false);
        errorMessage('');

        final response = await clientRepo.getClientById(clientId);

        if (response != null && response.success == true && response.data != null) {
          this.clientId.value = clientId; // Update the current clientId
          clientProfile.value = response.data;
        } else {
          isError(true);
          errorMessage('Failed to load client profile.');
        }
      } catch (e) {
        isError(true);
        errorMessage('An unexpected error occurred.');
        print('Error fetching client profile: $e');
      } finally {
        isLoading(false);
      }
    } else {
      // Profile is already loaded for the requested clientId
      print('Client profile already fetched for clientId: $clientId');
    }
  }

  void clearProfile() {
    clientId.value = null;
    clientProfile.value = null;
    isError(false);
    errorMessage('');
  }

  void clearClientProfile() {
    clientId.value = null;
    clientProfile.value = null;
    isError.value = false;
    errorMessage.value = '';
  }
}
