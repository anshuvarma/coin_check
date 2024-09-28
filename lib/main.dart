// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:temp_app/pages/error_page.dart';
import 'package:temp_app/pages/expense_page.dart';
import 'package:temp_app/pages/new_transaction_page.dart';
import 'package:temp_app/pages/temp.dart';
import 'package:temp_app/widgets/balance_card.dart';
import 'package:temp_app/widgets/recent_transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExpenseTracker(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final Map<String, WidgetBuilder> routes = {
          '/': (context) => MyApp(),
          '/newtransaction': (context) => NewTransactionPage(),
          '/temp': (context) => Temp(),
        };
        final WidgetBuilder? builder = routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(builder: builder);
        }
        return MaterialPageRoute(builder: (context) => ErrorPage());
      },
    );
  }
}

class ExpenseTracker extends StatefulWidget {
  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });

    if (index == 1) {
      // Navigate to ExpensePage when "Expense" is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ExpensePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 189, 241),
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Coin Check",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(1, 153, 159, 198),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BalanceCard(),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 12.5),
                child: Text(
                  'Recent Transactions',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              ),
              SizedBox(height: 10),
              RecentTransactions(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Expense',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 250, 189, 241),
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, '/newtransaction');
          // Navigator.pushNamed(context, '/temp');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
