import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanaa_fi_saas/features/clients/controller/ClientController.dart';
import 'package:sanaa_fi_saas/features/clients/data/client_repo.dart';
import 'package:sanaa_fi_saas/features/clients/views/clientsScreen.dart';
// import 'package:six_cash/features/clients/repository/client_repo.dart';

class AddClientController extends GetxController {
  final ClientRepo clientRepo;

  AddClientController({required this.clientRepo});

  final formKey = GlobalKey<FormState>();

  // Text Editing Controllers for each form field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController businessController = TextEditingController();
  final TextEditingController ninController = TextEditingController();
  final TextEditingController creditBalanceController = TextEditingController();
  final TextEditingController savingsBalanceController = TextEditingController();
  final TextEditingController nextOfKinController = TextEditingController();

  // Dropdown selection
  String? selectedAddedBy;
  List<String> agents = ['Agent 1', 'Agent 2', 'Agent 3']; // Example agents

  // DateTime fields
  DateTime? kycVerifiedAt;
  DateTime? dob;

  // File uploads
  File? clientPhoto;
  File? nationalIdPhoto;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Image picker function
  Future<void> pickImage(ImageSource source, Function(File?) callback) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      callback(File(pickedFile.path));
      update();
    }
  }

  // Form submission function
  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    _setLoadingState(true);

    try {
      // Prepare the data from form fields
      final Map<String, dynamic> clientData = {
        'name': nameController.text.trim(),
        'email': _generateEmail(nameController.text.trim()),
        'phone': phoneController.text.trim(),
        'address': addressController.text.trim(),
        'status': statusController.text.trim(),
        'kyc_verified_at': kycVerifiedAt?.toIso8601String(),
        'dob': dob?.toIso8601String(),
        'business': businessController.text.trim(),
        'nin': ninController.text.trim().toUpperCase(),
        'recommenders': null, // Handle recommenders as needed
        'credit_balance': double.tryParse(creditBalanceController.text) ?? 0.0,
        'savings_balance': double.tryParse(savingsBalanceController.text) ?? 0.0,
        'added_by': selectedAddedBy,
        'next_of_kin': nextOfKinController.text.trim(),
        // Include photo file paths or upload logic as per your API handling
        'client_photo': clientPhoto?.path,
        'national_id_photo': nationalIdPhoto?.path,
      };

      // Call the repository to add the client
      final response =  await clientRepo.addClient(clientData);

      // Handle response from the server
      if (response.isOk) {
        Get.snackbar('Success', 'Client created successfully');
        resetForm();
        Get.find<ClientController>().fetchClients();
        Get.to(ClientsPage());
        
      } else {
        Get.snackbar('Error', 'Failed to create client');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      _setLoadingState(false);
    }
  }

  // Generate email from name if not provided
  String _generateEmail(String name) {
    return '${name.replaceAll(' ', '').toLowerCase()}@sanaa.co';
  }

  // Reset form function
  void resetForm() {
    formKey.currentState?.reset();
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    statusController.clear();
    businessController.clear();
    ninController.clear();
    creditBalanceController.clear();
    savingsBalanceController.clear();
    nextOfKinController.clear();
    clientPhoto = null;
    nationalIdPhoto = null;
    selectedAddedBy = null;
    kycVerifiedAt = null;
    dob = null;
    update();
  }

  // Set loading state and update UI
  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    update(); // Notify GetBuilder to update the UI
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    statusController.dispose();
    businessController.dispose();
    ninController.dispose();
    creditBalanceController.dispose();
    savingsBalanceController.dispose();
    nextOfKinController.dispose();
    super.onClose();
  }
}
