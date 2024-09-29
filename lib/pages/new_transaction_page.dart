import 'package:flutter/material.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({super.key});

  @override
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  final TextEditingController _amountController = TextEditingController();
  bool isExpense = true;
  String selectedCategory = '';
  String selectedSource = '';
  DateTime selectedDate = DateTime.now();
  String selectedAccount = '';
  Text hintString = Text('');

  final List<String> expenseCategories = [
    'Food',
    'Health',
    'Entertainment',
    'Transport',
    'Shopping',
    'Others'
  ];
  final List<String> _incomeSources = [
    'Salary',
    'Freelance',
    'Investment',
    'Rental',
    'Business',
    'Others',
  ];
  final List<String> _accounts = ['Cash', 'Bank', 'UPI'];

  final Map<String, Color> _categoryColors = {
    'Food': Colors.redAccent,
    'Health': Colors.blueAccent,
    'Entertainment': Colors.orangeAccent,
    'Transport': Colors.purpleAccent,
    'Shopping': Colors.greenAccent,
    'Others': Colors.grey,
  };

  final Map<String, Color> _sourceColors = {
    'Salary': Colors.redAccent,
    'Freelance': Colors.blueAccent,
    'Investment': Colors.orangeAccent,
    'Rental': Colors.purpleAccent,
    'Business': Colors.greenAccent,
    'Others': Colors.grey.shade700,
  };

  final Map<String, Color> _accountColors = {
    'Cash': Colors.pinkAccent,
    'Bank': Colors.indigoAccent,
    'UPI': Colors.cyanAccent,
  };

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
      return;
    }
    final amount = _amountController.text;
    final date =
        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
    final account = isExpense ? selectedAccount : 'N/A';
    final categoryOrSource = isExpense ? selectedCategory : selectedSource;

    print('Amount: $amount');
    print('Date: $date');
    print('Type: ${isExpense ? 'Expense' : 'Income'}');
    print('Category/Source: $categoryOrSource');
    print('Account: $account');

    _amountController.clear();
    setState(() {
      selectedCategory = '';
      selectedSource = '';
      selectedAccount = '';
    });
  }

  // Custom Dropdown Menu with Colorful Options
  Widget buildCustomDropdown({
    required Text hintString,
    required List<String> items,
    required String value,
    required ValueChanged<String?> onChanged,
    required Map<String, Color> colorMap,
    required String label,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(label),
            content: Container(
              height: 110,
              width: double.maxFinite,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () {
                      onChanged(item);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorMap[item],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          item,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16), // Added padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black54),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Icon(icon),
            ),
            SizedBox(width: 8),
            Expanded(
              child: value == ''
                  ? hintString // Show the hint string if no selection is made
                  : Text(
                      value,
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 189, 241),
        elevation: 0,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle between Expense and Income
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpense = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isExpense ? Colors.redAccent : Colors.grey[200],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.remove_circle_outline,
                              color: isExpense ? Colors.white : Colors.black),
                          SizedBox(height: 8),
                          Text('Expense',
                              style: TextStyle(
                                  color:
                                      isExpense ? Colors.white : Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpense = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color:
                            isExpense ? Colors.grey[200] : Colors.greenAccent,
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.add_circle_outline,
                              color: isExpense ? Colors.black : Colors.white),
                          SizedBox(height: 8),
                          Text('Income',
                              style: TextStyle(
                                  color:
                                      isExpense ? Colors.black : Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Amount Input Field
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '0.00',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 36),
              ),
            ),
            SizedBox(height: 24),

            // Category or Source Dropdown
            buildCustomDropdown(
              items: isExpense ? expenseCategories : _incomeSources,
              value: isExpense ? selectedCategory : selectedSource,
              onChanged: (newValue) {
                setState(() {
                  if (isExpense) {
                    selectedCategory = newValue!;
                  } else {
                    selectedSource = newValue!;
                  }
                });
              },
              colorMap: isExpense
                  ? _categoryColors
                  : _sourceColors, // Use same for now
              label: isExpense ? 'Category' : 'Source',
              icon: isExpense ? Icons.category : Icons.attach_money,
              hintString: Text(
                'Select',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16),

            // Date Picker
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Account Dropdown for Expense
            if (isExpense)
              buildCustomDropdown(
                items: _accounts,
                value: selectedAccount,
                onChanged: (newValue) {
                  setState(() {
                    selectedAccount = newValue!;
                  });
                },
                colorMap: _accountColors,
                label: 'Account',
                icon: Icons.account_balance_wallet,
                hintString: Text(
                  'Select',
                  style: TextStyle(color: Colors.black),
                ),
              ),

            Spacer(),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveTransaction,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Color.fromARGB(255, 250, 189, 241),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('SAVE',
                    style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
