import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/Loans/views/loansScreen.dart';
import 'package:sanaa_fi_saas/features/Reports/views/reportsScreen.dart';
import 'package:sanaa_fi_saas/features/Savings/views/SavingsScreen.dart';
import 'package:sanaa_fi_saas/features/clients/views/ClientProfile.dart';
import 'package:sanaa_fi_saas/features/clients/views/client_profile_screen.dart';
import 'package:sanaa_fi_saas/features/clients/views/clientsScreen.dart';
import 'package:sanaa_fi_saas/features/create/views/Dashboard.dart';
import 'package:sanaa_fi_saas/features/expense/views/expense.dart';
import 'package:sanaa_fi_saas/features/home/views/Dashboard.dart';
import 'package:sanaa_fi_saas/features/performance/views/performance.dart';
import 'package:sanaa_fi_saas/features/setting/views/setting.dart';

class ContentController extends GetxController {
  var currentPage = 0.obs; // Observable variable to track the current page

  final List<Widget> pages = [
    Dashboard(),
    LoansPage(),
    SavingsPage(),
    ClientsPage(),
    CreatePage(),
    Perfomance(),
    ReportsPage(),
    ExpensePage(),
    SettingPage(),
    ClientProfile()
    // ClientProfileScreen(clientId: client!.id!),
    
  ];

  // Method to change the page
  void changePage(int index) {
    currentPage.value = index;
  }
}
