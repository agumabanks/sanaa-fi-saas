import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_fi_saas/features/clients/views/newClient.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Clean, simple background
      appBar: AppBar(
        title: const Text(
          'Operations Hub',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat', // Modern, elegant font
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Minimalistic black bar
        elevation: 0, // Flat, clean design
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 6,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildGridButton(Icons.person_add, 'New Client', AddClientPage()),
            _buildGridButton(Icons.attach_money, 'New Loan', NewLoanScreen()),
            _buildGridButton(Icons.report, 'Report', ReportScreen()),
            _buildGridButton(Icons.document_scanner, 'Document', DocumentScreen()),
            _buildGridButton(Icons.account_circle, 'Agent', AgentScreen()),
            _buildGridButton(Icons.receipt_long, 'Invoice', InvoiceScreen()),
            _buildGridButton(Icons.analytics, 'Analytics', AnalyticsScreen()),
            _buildGridButton(Icons.settings, 'Settings', SettingsScreen()),
          ],
        ),
      ),
    );
  }

  // Updated _buildGridButton to take the target screen as an argument
  Widget _buildGridButton(IconData icon, String label, Widget targetScreen) {
    return GestureDetector(
      onTap: () {
        Get.to(() => targetScreen); // Navigates to the provided screen using GetX
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black, // Sleek black background for the buttons
          borderRadius: BorderRadius.circular(12), // Smooth rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Soft shadow for depth
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white), // Clean white icons
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Montserrat', // Modern font choice
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white, // White text for contrast
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Define the screens for each button
class NewClientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Client")),
      body: Center(child: Text("New Client Screen")),
    );
  }
}

class NewLoanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Loan")),
      body: Center(child: Text("New Loan Screen")),
    );
  }
}

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Report")),
      body: Center(child: Text("Report Screen")),
    );
  }
}

class DocumentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Document")),
      body: Center(child: Text("Document Screen")),
    );
  }
}

class AgentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agent")),
      body: Center(child: Text("Agent Screen")),
    );
  }
}

class InvoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Invoice")),
      body: Center(child: Text("Invoice Screen")),
    );
  }
}

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analytics")),
      body: Center(child: Text("Analytics Screen")),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Center(child: Text("Settings Screen")),
    );
  }
}
