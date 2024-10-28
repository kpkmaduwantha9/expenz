import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transaction_screens.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //current page index
  int _currentPageIndex = 0;

  List<Expense> expenseList = [];

  //function to fetch expenses
  void fetchAllExpenses() async {
    List<Expense> loadedExpenses = await ExpenseService().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
      print(expenseList.length);
    });
  }

  //Function to add a new expense
  void addNewExpense(Expense newExpense) {
    ExpenseService().saveExpenses(newExpense, context);

    //Update the list of expenses
    setState(() {
      expenseList.add(newExpense);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchAllExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    // screen List
    final List<Widget> pages = [
      HomeScreen(),
      const TransactionScreen(),
      AddNewScreen(
        addExpense: addNewExpense,
      ),
      const BudgetScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
            /*print(_currentPageIndex);*/
          });
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: kWhite,
                size: 20
                    .sp
                    .clamp(20, 30), // Ensures the size is between 30 and 40
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: "Budget",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
