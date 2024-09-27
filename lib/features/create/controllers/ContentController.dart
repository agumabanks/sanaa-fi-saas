import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/Loans/views/loansScreen.dart';
import 'package:sanaa_fi_saas/features/Savings/views/SavingsScreen.dart';
import 'package:sanaa_fi_saas/features/clients/views/clientsScreen.dart';
import 'package:sanaa_fi_saas/features/home/views/Dashboard.dart';

class ContentController extends GetxController {
  var currentPage = 0.obs; // Observable variable to track the current page

  final List<Widget> pages = [
    Dashboard(),
    LoansPage(),
    SavingsPage(),
    ClientsPage(),
    
  ];

  // Method to change the page
  void changePage(int index) {
    currentPage.value = index;
  }
}
