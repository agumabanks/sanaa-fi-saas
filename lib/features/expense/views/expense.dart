// finance_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sanaa_fi_saas/features/expense/controllers/CashflowsController.dart';
import 'package:sanaa_fi_saas/features/expense/controllers/ExpensesController.dart';
// import 'package:your_project_name/features/Finance/controllers/expenses_controller.dart';
// import 'package:your_project_name/features/Finance/controllers/cashflows_controller.dart';
// import 'package:your_project_name/features/Finance/data/ExpensesModal.dart';
// import 'package:your_project_name/features/Finance/data/CashFlowModal.dart';

class ExpensePage extends StatelessWidget {
  final ExpensesController expensesController = Get.put(ExpensesController(
    expenseRepo: Get.find(),
  ));
  final CashflowsController cashflowsController = Get.put(CashflowsController(
    expenseRepo: Get.find(),
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finance'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              expensesController.refreshExpenses();
              cashflowsController.fetchCashflows();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header with search and add buttons
            _buildHeader(context),

            SizedBox(height: 20),

            // Cashflows Table
            _buildCashflowsTable(),

            SizedBox(height: 20),

            // Expenses Table
            _buildExpensesTable(),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingButtons(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        TextField(
          onChanged: (value) {
            expensesController.searchExpenses(value);
            cashflowsController.searchQuery.value = value;
            cashflowsController.fetchCashflows();
          },
          decoration: InputDecoration(
            labelText: 'Search by Name',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        // Add Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: () => _showAddCashflowDialog(context),
              icon: Icon(Icons.add),
              label: Text('Add Cash Flow'),
            ),
            SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () => _showAddExpenseDialog(context),
              icon: Icon(Icons.add),
              label: Text('Add Expense'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCashflowsTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cashflows',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Obx(() {
          if (cashflowsController.isLoading.value && cashflowsController.cashflows.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (cashflowsController.isError.value) {
            return Center(child: Text(cashflowsController.errorMessage.value));
          } else if (cashflowsController.cashflows.isEmpty) {
            return Center(child: Text('No cashflows found.'));
          } else {
            return DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Balance Before')),
                DataColumn(label: Text('Capital Added')),
                DataColumn(label: Text('Cash Banked')),
                DataColumn(label: Text('Date')),
              ],
              rows: cashflowsController.cashflows.map((cashflow) {
                return DataRow(
                  cells: [
                    DataCell(Text('${cashflow.id}')),
                    DataCell(Text('${cashflow.balanceBf ?? '0.00'}')),
                    DataCell(Text('${cashflow.capitalAdded ?? '0.00'}')),
                    DataCell(Text('${cashflow.cashBanked ?? '0.00'}')),
                    DataCell(Text(
                        '${cashflow.createdAt?.toLocal().toString().split(' ')[0] ?? ''}')),
                  ],
                );
              }).toList(),
            );
          }
        }),
      ],
    );
  }

  Widget _buildExpensesTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expenses',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Obx(() {
          if (expensesController.isLoading.value && expensesController.expenses.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (expensesController.isError.value) {
            return Center(child: Text(expensesController.errorMessage.value));
          } else if (expensesController.expenses.isEmpty) {
            return Center(child: Text('No expenses found.'));
          } else {
            return DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Description')),
                DataColumn(label: Text('Amount')),
                DataColumn(label: Text('Date')),
              ],
              rows: expensesController.expenses.map((expense) {
                return DataRow(
                  cells: [
                    DataCell(Text('${expense.id}')),
                    DataCell(Text('${expense.description ?? ''}')),
                    DataCell(Text('${expense.amount ?? '0.00'}')),
                    DataCell(Text(
                        '${expense.createdAt?.toLocal().toString().split(' ')[0] ?? ''}')),
                  ],
                );
              }).toList(),
            );
          }
        }),
      ],
    );
  }

  Widget _buildFloatingButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'addCashflow',
          onPressed: () => _showAddCashflowDialog(context),
          child: Icon(Icons.add),
          tooltip: 'Add Cash Flow',
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          heroTag: 'addExpense',
          onPressed: () => _showAddExpenseDialog(context),
          child: Icon(Icons.add),
          tooltip: 'Add Expense',
        ),
      ],
    );
  }

  void _showAddCashflowDialog(BuildContext context) {
    TextEditingController balanceBfController = TextEditingController();
    TextEditingController capitalAddedController = TextEditingController();
    TextEditingController cashBankedController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Cash Flow',
      content: Column(
        children: [
          TextField(
            controller: balanceBfController,
            decoration: InputDecoration(labelText: 'Balance Before'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: capitalAddedController,
            decoration: InputDecoration(labelText: 'Capital Added'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: cashBankedController,
            decoration: InputDecoration(labelText: 'Cash Banked'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      textConfirm: 'Submit',
      onConfirm: () {
        Map<String, dynamic> cashflowData = {
          'balance_bf': balanceBfController.text,
          'capital_added': capitalAddedController.text,
          'cash_banked': cashBankedController.text,
          // Add other necessary fields
        };
        // Call create cashflow method
        cashflowsController.createCashflow(cashflowData);
        Get.back();
      },
      textCancel: 'Cancel',
    );
  }
void _showAddExpenseDialog(BuildContext context) {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  Get.defaultDialog(
    title: 'Add Expense',
    content: SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: timeController,
            decoration: InputDecoration(
              labelText: 'Time',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () async {
              // Show date picker
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), 
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                // Show time picker
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  DateTime fullDateTime = DateTime(
                    pickedDate.year, 
                    pickedDate.month, 
                    pickedDate.day, 
                    pickedTime.hour, 
                    pickedTime.minute,
                  );
                  String formattedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm").format(fullDateTime);
                  timeController.text = formattedDateTime;
                }
              }
            },
          ),
          TextField(
            controller: categoryController,
            decoration: InputDecoration(labelText: 'Category'),
          ),
          TextField(
            controller: paymentMethodController,
            decoration: InputDecoration(labelText: 'Payment Method'),
          ),
          TextField(
            controller: notesController,
            decoration: InputDecoration(labelText: 'Notes'),
            maxLines: 3,
          ),
        ],
      ),
    ),
    textConfirm: 'Submit',
    onConfirm: () {
      // Validate required fields
      if (descriptionController.text.isEmpty ||
          amountController.text.isEmpty ||
          timeController.text.isEmpty) {
        Get.snackbar('Error', 'Please fill in all required fields.');
        return;
      }

      Map<String, dynamic> expenseData = {
        'description': descriptionController.text,
        'amount': amountController.text,
        'time': timeController.text,
        'category': categoryController.text,
        'payment_method': paymentMethodController.text,
        'notes': notesController.text,
        // Add any other necessary fields
      };

      // Call create expense method
      expensesController.createExpense(expenseData);
      Get.back();
    },
    textCancel: 'Cancel',
  );
}
  void _showAddExpenseDialog2(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Expense',
      content: Column(
        children: [
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      textConfirm: 'Submit',
      onConfirm: () {
        Map<String, dynamic> expenseData = {
          'description': descriptionController.text,
          'amount': amountController.text,
          // Add other necessary fields
        };
        // Call create expense method
        expensesController.createExpense(expenseData);
        Get.back();
      },
      textCancel: 'Cancel',
    );
  }
}
