import 'package:get/get.dart';

class SidebarController extends GetxController {
  var selectedSection = 'Dashboard'.obs;

  void changeSection(String section) {
    selectedSection.value = section;
  }
}
