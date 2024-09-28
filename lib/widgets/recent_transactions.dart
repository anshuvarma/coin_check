// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class RecentTransactions extends StatelessWidget {
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
    // {
    //   'icon': Icons.fastfood,
    //   'name': 'Zomato',
    //   'category': 'Food',
    //   'amount': '-₹150',
    //   'time': '02:07 pm',
    //   'color': Colors.brown.shade100,
    // },
    // {
    //   'icon': Icons.fastfood,
    //   'name': 'Zomato',
    //   'category': 'Food',
    //   'amount': '-₹150',
    //   'time': '02:07 pm',
    //   'color': Colors.blue.shade100,
    // },
    // {
    //   'icon': Icons.fastfood,
    //   'name': 'Zomato',
    //   'category': 'Food',
    //   'amount': '-₹150',
    //   'time': '02:07 pm',
    //   'color': Colors.deepOrange.shade200,
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    child: Icon(transaction['icon'], color: Colors.black),
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
    );
  }
}
