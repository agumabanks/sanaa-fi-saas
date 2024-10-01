import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/Loans/controllers/LoanController.dart';
import 'package:sanaa_fi_saas/features/home/views/date_app_bar.dart';
// import 'package:sanaa_fi_saas/features/Loans/controllers/LoanController.dart'; // Import your LoanController

class LoansPage extends StatelessWidget {
  const LoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color.fromARGB(255, 255, 255, 255),
      width: double.infinity,
      height: double.infinity,
      child:  Center(
        child: LoanDashboard(),
      ),
    );
  }
}

class LoanDashboard extends StatelessWidget {
  final LoanController loanController  =  Get.find<LoanController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DateAppBar(
        title: 'Loans Dashboard',
        centerTitle: true, // Optional: centers the title
         
      ),
      body: Row(
        children: [
          // Sidebar
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 8),
              child: Container(
                decoration: BoxDecoration(
                   
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(188, 237, 237, 237), 
                ),
                // Light grey background
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    _buildSidebarItem(
                      title: 'Home',
                      selectedIndex: 0,
                      controller: loanController,
                    ),
                    _buildSidebarItem(
                      title: 'All Loans',
                      selectedIndex: 1,
                      controller: loanController,
                    ),
                    _buildSidebarItem(
                      title: 'Pending Loans',
                      selectedIndex: 2,
                      controller: loanController,
                    ),
                     _buildSidebarItem(
                      title: 'Running Loans',
                      selectedIndex: 3,
                      controller: loanController,
                    ),
                    _buildSidebarItem(
                      title: 'Rejected Loans',
                      selectedIndex: 4,
                      controller: loanController,
                    ),
              
                    _buildSidebarItem(
                      title: 'Paid Loans',
                      selectedIndex: 5,
                      controller: loanController,
                    ),
                   
                    _buildSidebarItem(
                      title: 'Loan Plans',
                      selectedIndex: 6,
                      controller: loanController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Main Content Area
          Expanded(
            flex: 8,
            child: Obx(() => loanController.pages[loanController.currentPage.value]), // Dynamically loads the selected page
          ),
        ],
      ),
    );
  }

  // Helper method to create sidebar items without icons and highlight selected page
  Widget _buildSidebarItem({
    required String title,
    required int selectedIndex,
    required LoanController controller,
  }) {
    return Obx(() {
      bool isSelected = controller.currentPage.value == selectedIndex;
      return Container(
        color: isSelected ? Colors.blueAccent.withOpacity(0.1) : Colors.transparent, // Highlight selected page
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.blueAccent : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          selected: isSelected,
          onTap: () => controller.changePage(selectedIndex),
        ),
      );
    });
  }
}
