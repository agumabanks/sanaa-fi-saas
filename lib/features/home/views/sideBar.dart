import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/home/controllers/ContentController.dart';
import 'package:sanaa_fi_saas/features/home/views/SidebarItem.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ContentController sidebarController = Get.put(ContentController()); // Initialize controller

    return Container(
      width: 250,
      color: Color.fromARGB(188, 237, 237, 237), // Muted grey background to match first screen
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(224, 210, 210, 210), // White background for the search bar
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color.fromARGB(255, 196, 196, 196)), // Light border
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Use Obx to listen to selected index changes
            Obx(() => SidebarItem(
                icon: Icons.dashboard, 
                title: 'Dashboard', 
                isSelected: sidebarController.currentPage.value == 0, 
                onTap: () => sidebarController.changePage(0)
            )),
            Obx(() => SidebarItem(
                icon: Icons.account_balance_wallet, 
                title: 'Loans', 
                isSelected: sidebarController.currentPage.value == 1, 
                onTap: () => sidebarController.changePage(1)
            )),
            Obx(() => SidebarItem(
                icon: Icons.savings, 
                title: 'Savings', 
                isSelected: sidebarController.currentPage.value == 2, 
                onTap: () => sidebarController.changePage(2)
            )),
            Obx(() => SidebarItem(
                icon: Icons.people, 
                title: 'Clients', 
                isSelected: sidebarController.currentPage.value == 3, 
                onTap: () => sidebarController.changePage(3)
            )),
            Obx(() => SidebarItem(
                icon: Icons.add_circle_outline, 
                title: 'Create', 
                isSelected: sidebarController.currentPage.value == 4, 
                onTap: () => sidebarController.changePage(4)
            )),
            Obx(() => SidebarItem(
                icon: Icons.assessment, 
                title: 'Performance', 
                isSelected: sidebarController.currentPage.value == 5, 
                onTap: () => sidebarController.changePage(5)
            )),
            Obx(() => SidebarItem(
                icon: Icons.pie_chart, 
                title: 'Reports', 
                isSelected: sidebarController.currentPage.value == 6, 
                onTap: () => sidebarController.changePage(6)
            )),
            Obx(() => SidebarItem(
                icon: Icons.money_off, 
                title: 'Expenses', 
                isSelected: sidebarController.currentPage.value == 7, 
                onTap: () => sidebarController.changePage(7)
            )),
            Obx(() => SidebarItem(
                icon: Icons.settings, 
                title: 'Settings', 
                isSelected: sidebarController.currentPage.value == 8, 
                onTap: () => sidebarController.changePage(8)
            )),
            Spacer(),
            Divider(color: Colors.grey[300]), // Thin divider
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Replace with user's image
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Banks Ibrah',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('USD 0.00',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
