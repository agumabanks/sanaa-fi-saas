import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/home/controllers/DateController.dart';

class DateAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;

  DateAppBar({
    required this.title,
    this.actions,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the DateController
    final DateController dateController = Get.put(DateController());

    return AppBar(
      backgroundColor: Colors.white, // Set background to white
      elevation: 0, // Remove shadow
      title: Text(
        title,
        style: TextStyle(color: Colors.black), // Set title text color to black
      ),
      centerTitle: false,
      actions: [
        // Display the date on the AppBar
        Obx(
          () => Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                dateController.todayDate.value,
                style: TextStyle(fontSize: 16, color: Colors.black), // Set date text color to black
              ),
            ),
          ),
        ),
        // Include any additional actions
        if (actions != null) ...actions!,
      ],
      iconTheme: IconThemeData(color: Colors.black), // Set icon colors to black
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0), // Adjust the height of the bottom border
        child: Container(
          color: Colors.black, // Set the color of the bottom border
          height: 1.0, // Thickness of the bottom border
        ),
      ),
    );
  }

  // Required for PreferredSizeWidget
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
