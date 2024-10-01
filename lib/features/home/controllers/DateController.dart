// date_controller.dart

import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For formatting the date

class DateController extends GetxController {
  // Observable variable to hold the date string
  var todayDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the date when the controller is first created
    updateDate();
    // Optionally, set up a timer to update the date at midnight
  }

  // Method to update the date
  void updateDate() {
    todayDate.value = DateFormat('EEEE, MMMM d, y').format(DateTime.now());
  }
}
