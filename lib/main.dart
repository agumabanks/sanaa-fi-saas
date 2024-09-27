import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/clients/controller/ClientController.dart';
import 'package:sanaa_fi_saas/features/home/views/content_view.dart';
import 'package:sanaa_fi_saas/features/home/views/home.dart';
import 'package:sanaa_fi_saas/features/home/views/sideBar.dart';
// import 'package:window_size/window_size.dart'; // Add window size package
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/home/controllers/ContentController.dart';
// import 'content_controller.dart'; // Import the ContentController
// import 'sideBar.dart'; // Import the Sidebar

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Get screen size to calculate the minimum width
  final screenWidth = WidgetsBinding.instance.window.physicalSize.width;

  // setWindowMinSize(Size(screenWidth / 2, 600)); // Minimum width to 1/2 of the screen, height 600px

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    final ClientController clientController = Get.put(ClientController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sanaa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}