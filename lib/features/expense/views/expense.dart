import 'package:flutter/material.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: const Color.fromARGB(255, 255, 255, 255),
      width: double.infinity, // This ensures the container fills all remaining space
      height: double.infinity,
      child: Center(child: Text("Expenses"),), 
    );
  }
}