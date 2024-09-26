import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_saas/features/home/controllers/ContentController.dart';
// import 'content_controller.dart'; // Import the ContentController

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ContentController contentController = Get.find(); // Access the controller

    return Container(
      width: 250,
      color: Color(0xFFEDEDED), // Sidebar background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSidebarItem(
            icon: Icons.account_balance_wallet,
            title: 'Loans',
            index: 0,
            contentController: contentController,
          ),
          _buildSidebarItem(
            icon: Icons.people,
            title: 'Clients',
            index: 1,
            contentController: contentController,
          ),
          _buildSidebarItem(
            icon: Icons.history,
            title: 'History',
            index: 2,
            contentController: contentController,
          ),
          _buildSidebarItem(
            icon: Icons.settings,
            title: 'Profile',
            index: 3,
            contentController: contentController,
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required int index,
    required ContentController contentController,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        contentController.changePage(index); // Change the page when tapped
      },
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sanaa_saas/features/clients/views/clientsScreen.dart';

// class Sidebar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 250,
//       color: Color(0xFFEDEDED), // Muted grey background to match first screen
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(224, 210, 210, 210), // White background for the search bar
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Color.fromARGB(255, 196, 196, 196)), // Light border
//                 ),
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Icon(Icons.search, color: Colors.grey),
//                     ),
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                           hintText: 'Search',
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SidebarItem(
//               icon: Icons.account_balance_wallet, 
//               title: 'Loans', 
//               isSelected: true,
//               onTap: () {
//                 print("Loans tapped");
//                 // Add navigation or logic for "Loans" here
//               },
//             ),
//             SidebarItem(
//               icon: Icons.savings, 
//               title: 'Savings',
//               onTap: () {
//                 print("Savings tapped");
//                 // Add navigation or logic for "Savings" here
//               },
//             ),
//             SidebarItem(
//               icon: Icons.people, 
//               title: 'Clients',
//               onTap: () {
//                   Get.to(ClientsPage());       // Add navigation or logic for "Clients" here
//               },
//             ),
//             SidebarItem(
//               icon: Icons.add_circle_outline, 
//               title: 'Create',
//               onTap: () {
//                 print("Create tapped");
//                 // Add navigation or logic for "Create" here
//               },
//             ),
//             SidebarItem(
//               icon: Icons.assessment, 
//               title: 'Performance',
//               onTap: () {
//                 print("Performance tapped");
//                 // Add navigation or logic for "Performance" here
//               },
//             ),
//             SidebarItem(
//               icon: Icons.pie_chart, 
//               title: 'Reports',
//               onTap: () {
//                 print("Reports tapped");
//                 // Add navigation or logic for "Reports" here
//               },
//             ),
//             SidebarItem(
//               icon: Icons.money_off, 
//               title: 'Expenses',
//               onTap: () {
//                 print("Expenses tapped");
//                 // Add navigation or logic for "Expenses" here
//               },
//             ),
//             SidebarItem(
//               icon: Icons.settings, 
//               title: 'Settings',
//               onTap: () {
//                 print("Settings tapped");
//                 // Add navigation or logic for "Settings" here
//               },
//             ),
//             Spacer(),
//             Divider(color: Colors.grey[300]), // Thin divider
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundImage: NetworkImage(
//                         'https://via.placeholder.com/150'), // Replace with user's image
//                   ),
//                   SizedBox(width: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Banks Ibrah',
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       Text('USD 0.00',
//                           style: TextStyle(
//                               color: Colors.grey, fontWeight: FontWeight.w400)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SidebarItem extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final bool isSelected;
//   final VoidCallback onTap; // Add onTap callback

//   SidebarItem({required this.icon, required this.title, this.isSelected = false, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: isSelected
//           ? BoxDecoration(
//               color: Color(0xFFDADADA), // Highlighted background for selected
//               borderRadius: BorderRadius.circular(8),
//             )
//           : null,
//       child: ListTile(
//         leading: Icon(icon, color: isSelected ? Colors.blue : Colors.black87),
//         title: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? Colors.blue : Colors.black87,
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//         onTap: onTap, // Assign the onTap callback
//       ),
//     );
//   }
// }
