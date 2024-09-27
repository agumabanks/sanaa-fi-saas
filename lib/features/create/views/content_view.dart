import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      width: double.infinity, // This ensures the container fills all remaining space
      height: double.infinity, // Ensures the content takes full height as well
          
      child: Center(
        child: GetBuilder<ContentController>(
          builder: (controller) {
            return Text(
              'Current Section: ${controller.currentSection}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: const Color.fromARGB(255, 31, 221, 170),
      width: double.infinity, // This ensures the container fills all remaining space
      height: double.infinity,
      child: Center(child: Text("hello"),), 
    );
  }
}

class ContentController extends GetxController {
  var currentSection = 'Dashboard';

  void updateSection(String newSection) {
    currentSection = newSection;
    update(); // Trigger UI update
  }
}
