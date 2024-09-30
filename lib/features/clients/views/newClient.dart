import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanaa_fi_saas/features/clients/controller/add_client_controller.dart';

class AddClientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddClientController controller = Get.put(AddClientController(clientRepo: Get.find()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Client'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name field
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Please enter the name' : null,
              ),
              SizedBox(height: 10),

              // Phone field
              TextFormField(
                controller: controller.phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) => value!.isEmpty ? 'Please enter the phone number' : null,
              ),
              SizedBox(height: 10),

              // Address field
              TextFormField(
                controller: controller.addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 10),

              // Status field
              TextFormField(
                controller: controller.statusController,
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) => value!.isEmpty ? 'Please enter the status' : null,
              ),
              SizedBox(height: 10),

              // KYC Verified At date field
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'KYC Verified At',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    controller.kycVerifiedAt = pickedDate;
                    controller.update();
                  }
                },
                controller: TextEditingController(
                  text: controller.kycVerifiedAt != null
                      ? "${controller.kycVerifiedAt!.toLocal()}".split(' ')[0]
                      : '',
                ),
              ),
              SizedBox(height: 10),

              // Date of Birth date field
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    controller.dob = pickedDate;
                    controller.update();
                  }
                },
                controller: TextEditingController(
                  text: controller.dob != null
                      ? "${controller.dob!.toLocal()}".split(' ')[0]
                      : '',
                ),
              ),
              SizedBox(height: 10),

              // Business field
              TextFormField(
                controller: controller.businessController,
                decoration: InputDecoration(labelText: 'Business'),
              ),
              SizedBox(height: 10),

              // NIN field
              TextFormField(
                controller: controller.ninController,
                decoration: InputDecoration(labelText: 'NIN'),
              ),
              SizedBox(height: 10),

              // Credit Balance field
              TextFormField(
                controller: controller.creditBalanceController,
                decoration: InputDecoration(labelText: 'Credit Balance'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter the credit balance' : null,
              ),
              SizedBox(height: 10),

              // Savings Balance field
              TextFormField(
                controller: controller.savingsBalanceController,
                decoration: InputDecoration(labelText: 'Savings Balance'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter the savings balance' : null,
              ),
              SizedBox(height: 10),

              // Added By Dropdown
              DropdownButtonFormField<String>(
                value: controller.selectedAddedBy,
                decoration: InputDecoration(labelText: 'Added By'),
                items: controller.agents.map((String agent) {
                  return DropdownMenuItem<String>(
                    value: agent,
                    child: Text(agent),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedAddedBy = value;
                  controller.update();
                },
                validator: (value) => value == null ? 'Please select an agent' : null,
              ),
              SizedBox(height: 10),

              // Client Photo Upload
              Row(
                children: [
                  Text('Client Photo:'),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => controller.pickImage(ImageSource.gallery, (file) {
                      controller.clientPhoto = file;
                    }),
                    child: Text(controller.clientPhoto == null ? 'Upload' : 'Uploaded'),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Next of Kin field
              TextFormField(
                controller: controller.nextOfKinController,
                decoration: InputDecoration(labelText: 'Next of Kin'),
              ),
              SizedBox(height: 10),

              // National ID Photo Upload
              Row(
                children: [
                  Text('National ID Photo:'),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => controller.pickImage(ImageSource.gallery, (file) {
                      controller.nationalIdPhoto = file;
                    }),
                    child: Text(controller.nationalIdPhoto == null ? 'Upload' : 'Uploaded'),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Submit and Reset buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: controller.resetForm,
                    child: Text('Reset'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: controller.submitForm,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
