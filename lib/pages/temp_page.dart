import 'package:flutter/material.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({super.key});

  @override
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  final TextEditingController _amountController = TextEditingController();
  bool isExpense = true;
  String selectedCategory = 'Select'; // For expense categories
  String selectedSource = 'Select'; // For income sources
  DateTime selectedDate = DateTime.now();
  String selectedAccount = 'Select'; // Tracks selected account
  bool isRecurring = false; // For recurring income

  // List of expense categories
  final List<String> _expenseCategories = [
    'Select',
    'Food',
    'Groceries',
    'Entertainment',
    'Travel',
    'Shopping'
  ];

  // List of income sources
  final List<String> _incomeSources = [
    'Select',
    'Salary',
    'Freelance',
    'Investment',
    'Gift'
  ];

  // Method to select date using date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _saveTransaction() {
    if (_amountController.text.isEmpty) {
      // Handle validation here
      return;
    }

    final amount = _amountController.text;
    final date =
        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
    final account =
        isExpense ? selectedAccount : 'N/A'; // Only applicable for expenses
    final categoryOrSource = isExpense ? selectedCategory : selectedSource;

    // Log the details for now (replace with your saving logic)
    print('Amount: $amount');
    print('Date: $date');
    print('Type: ${isExpense ? 'Expense' : 'Income'}');
    print('Category/Source: $categoryOrSource');
    print('Account: $account');
    if (!isExpense) print('Recurring Income: $isRecurring');

    // Clear inputs after save
    _amountController.clear();
    setState(() {
      selectedCategory = 'Select';
      selectedSource = 'Select';
      selectedAccount = 'Select';
      isRecurring = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 189, 241),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'New Transaction',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: Color.fromARGB(255, 244, 241, 245),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Expense and Income Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isExpense = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isExpense ? Colors.redAccent : Colors.white,
                        foregroundColor:
                            isExpense ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.redAccent),
                        ),
                      ),
                      child: Text('EXPENSE'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isExpense = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isExpense ? Colors.white : Colors.green,
                        foregroundColor:
                            isExpense ? Colors.black : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.green),
                        ),
                      ),
                      child: Text('INCOME'),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Dynamic input for the amount
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Category or Source Dropdown based on type (Expense/Income)
                ListTile(
                  title: Text(isExpense ? 'Category' : 'Source'),
                  trailing: DropdownButton<String>(
                    value: isExpense ? selectedCategory : selectedSource,
                    onChanged: (String? newValue) {
                      setState(() {
                        if (isExpense) {
                          selectedCategory = newValue!;
                        } else {
                          selectedSource = newValue!;
                        }
                      });
                    },
                    items: (isExpense ? _expenseCategories : _incomeSources)
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Divider(),

                // Date Selection
                ListTile(
                  title: Text('Date'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                      SizedBox(width: 8),
                      Icon(Icons.calendar_today, size: 20),
                    ],
                  ),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                Divider(),

                // Account selection for expense only
                if (isExpense)
                  ListTile(
                    title: Text('Account'),
                    trailing: DropdownButton<String>(
                      value: selectedAccount,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedAccount = newValue!;
                        });
                      },
                      items: <String>['Select', 'Cash', 'Bank', 'UPI']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                if (!isExpense)
                  // Recurring income toggle for income
                  SwitchListTile(
                    title: Text('Recurring Income'),
                    value: isRecurring,
                    onChanged: (bool value) {
                      setState(() {
                        isRecurring = value;
                      });
                    },
                  ),

                Spacer(),
                // Save Button
                ElevatedButton(
                  onPressed: _saveTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 250, 189, 241),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('SAVE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
