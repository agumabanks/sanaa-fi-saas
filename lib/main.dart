import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_saas/features/home/views/content_view.dart';
import 'package:sanaa_saas/features/home/views/sideBar.dart';
// import 'package:window_size/window_size.dart'; // Add window size package

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Get screen size to calculate the minimum width
  final screenWidth = WidgetsBinding.instance.window.physicalSize.width;

  // setWindowMinSize(Size(screenWidth / 2, 600)); // Minimum width to 1/2 of the screen, height 600px

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

class HomePage extends StatelessWidget {
  @override

      final ContentController contentController = Get.put(ContentController());

  Widget build(BuildContext context) {
    return HomePage();
    // Scaffold(
    //   body: Row(
    //     children: [
    //       Sidebar(), // Sidebar Widget
    //       Expanded(
    //         child: Dashboard(), // Content based on selection
    //       ),
    //     ],
    //   ),
    // );
  }
}




// import 'dart:async';
// import 'dart:io' show Platform; // Correct import for platform check

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sanaa_saas/utils/theme_controller.dart'; // Ensure this path is correct




// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize ThemeController and any other controllers or services
//   // Get.put(ThemeController(sharedPreferences: null));

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {

  
// @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'GetX GetBuilder Demo',
//       home: Scaffold(
//         // appBar: AppBar(
//         //   title: Text('GetX GetBuilder Demo'),
//         // ),
//         body: FinanceDashboardUI()
        
//       ),
//     );
//   }
// }

// class FinanceDashboardUI extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           // Side Menu
//           Container(
//             width: 250,
//             color: Colors.grey[200],
//             child: Column(
//               children: [
//                 SizedBox(height: 50),
//                 _buildMenuItem(Icons.dashboard, "Dashboard"),
//                 _buildMenuItem(Icons.report, "Reports"),
//                 _buildMenuItem(Icons.account_balance, "Accounts"),
//                 _buildMenuItem(Icons.credit_card, "Cards"),
//                 _buildMenuItem(Icons.savings, "Savings"),
//                 _buildMenuItem(Icons.person, "Clients"),
//               ],
//             ),
//           ),
//           // Main Content Area
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header
//                   Text(
//                     'Welcome, Kabalaga.',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Metrics Cards
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //   children: [
//                   //     _buildMetricCard("Total Balance", "192,735,117.90 UGX"),
//                   //     _buildMetricCard("Used Balance", "124,996,458.90 UGX"),
//                   //     _buildMetricCard("Unused Balance", "67,738,659.00 UGX"),
//                   //   ],
//                   // ),
//                   SizedBox(height: 40),
//                   // Transactions Statistics Section
//                   _buildTransactionsChart(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper widget to build menu items
//   Widget _buildMenuItem(IconData icon, String title) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.black),
//       title: Text(
//         title,
//         style: TextStyle(fontSize: 16),
//       ),
//     );
//   }

//   // Helper widget to build metric cards
//   Widget _buildMetricCard(String title, String amount) {
//     return Container(
//       width: 200,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 14,
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             amount,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper widget to build transaction chart (placeholder)
//   Widget _buildTransactionsChart() {
//     return Container(
//       height: 200,
//       width: double.infinity,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Center(child: Text('Transaction Chart Placeholder')),
//     );
//   }
// }
