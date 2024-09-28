import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ExpensePage extends StatefulWidget {
  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final List<Map<String, dynamic>> transactions = [
    {
      'icon': Icons.fastfood,
      'name': 'Zomato',
      'category': 'Food',
      'amount': '-₹150',
      'time': '02:10 pm',
      'color': Colors.deepOrange.shade200,
    },
    {
      'icon': Icons.account_balance_wallet,
      'name': 'GPay',
      'category': 'Banking',
      'amount': '-₹150',
      'time': '02:09 pm',
      'color': Colors.blue.shade100,
    },
    {
      'icon': Icons.shopping_cart,
      'name': 'D-mart',
      'category': 'Grocery',
      'amount': '-₹150',
      'time': '02:08 pm',
      'color': Colors.teal.shade100,
    },
    {
      'icon': Icons.fastfood,
      'name': 'Zomato',
      'category': 'Food',
      'amount': '-₹150',
      'time': '02:07 pm',
      'color': Colors.brown.shade100,
    },
    {
      'icon': Icons.fastfood,
      'name': 'Zomato',
      'category': 'Food',
      'amount': '-₹150',
      'time': '02:07 pm',
      'color': Colors.blue.shade100,
    },
    {
      'icon': Icons.fastfood,
      'name': 'Zomato',
      'category': 'Food',
      'amount': '-₹150',
      'time': '02:07 pm',
      'color': Colors.deepOrange.shade200,
    },
  ];

  // List of categories for filters
  final List<String> categories = [
    'Food & Drink',
    'Banking',
    'Grocery',
    "Movie"
  ];

  // State variable to keep track of the selected category
  String selectedCategory = 'Food & Drink';

  @override
  Widget build(BuildContext context) {
    // Filter transactions based on selected category
    // ignore: unused_local_variable
    List<Map<String, dynamic>> filteredTransactions = transactions
        .where((transaction) => transaction['category'] == selectedCategory)
        .toList();
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
          'Expense',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 229, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search for any expense',
                  hintStyle: TextStyle(color: Colors.blueGrey.shade200),
                  icon: Icon(Icons.search, color: Colors.blueGrey.shade200),
                ),
              ),
            ),
            SizedBox(height: 20),

            // SizedBox(height: 8),
            Text(
              'Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                // color: Color.fromARGB(255, 241, 229, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    bool isSelected = selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: ChoiceChip(
                        label: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        selectedColor: Colors.purple,
                        showCheckmark: false,
                        // backgroundColor: Colors.grey.shade200,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Expenses title
            SizedBox(height: 15),
            // Expenses title
            Text(
              'Expenses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            // Expenses list
            Expanded(
              child: ListView.builder(
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 2, // Number of columns
                //   crossAxisSpacing: 15, // Horizontal spacing between grid items
                //   mainAxisSpacing: 15, // Vertical spacing between grid items
                //   childAspectRatio: 1.5, // Aspect ratio of each grid item
                // ),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: transaction[
                            'color'], // Use the color from the transaction data
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child:
                                Icon(transaction['icon'], color: Colors.black),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      transaction['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      transaction['category'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      transaction['time'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                                Text(
                                  transaction['amount'],
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
