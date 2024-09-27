import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/clients/views/clientsScreen.dart';
// import 'package:sanaa_fi_saas/features/a_field_office/home/screens/fo-home.dart';
// import 'package:sanaa_fi_saas/features/history/screens/history_screen.dart';
// import 'package:sanaa_fi_saas/features/setting/screens/profile_screen.dart';
// import '../../a_field_office/clients/screens/ClientsPage.dart';

class ContentController extends GetxController {
  var currentPage = 0.obs; // Observable variable to track the current page

  final List<Widget> pages = [
    ClientsPage(),
    ClientsPage(),
    // HistoryScreen(),
    // ProfileScreen(),
  ];

  void changePage(int index) {
    currentPage.value = index;
  }
}
