import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/home/controllers/ContentController.dart';
// import 'content_controller.dart'; // Import the ContentController
import 'sideBar.dart'; // Import the Sidebar

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
      final ContentController contentController = Get.put(ContentController()); 
 // Initialize the controller once
  @override
  Widget build(BuildContext context) {
    final ContentController contentController = Get.put(ContentController()); // Initialize the controller

    return Scaffold(
      body: Row(
        children: [
          Sidebar(), // Sidebar widget
          Expanded(
            child: Obx(() {
              return contentController.pages[contentController.currentPage.value]; // Display the selected page
            }),
          ),
        ],
      ),
    );
  }
}
