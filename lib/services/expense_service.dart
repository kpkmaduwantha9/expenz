import 'dart:convert';

import 'package:expenz/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  //Expense List
  List<Expense> expensesList = [];

  //define the key for storing expenses in shared preferences
  static const String _expenseKey = 'expenses';

//save the expenses to shared preferences
  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      //convert the existing expenses to a list of expense objects
      List<Expense> existingExpenseObjects = [];

      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map(
              (e) => Expense.fromJSON(json.decode(e)),
            )
            .toList();
      }

      //add the new expense to the list
      existingExpenseObjects.add(expense);

      //convert thr list of Expense objects back to a list of string
      List<String> updatedExpenses = existingExpenseObjects
          .map(
            (e) => json.encode(e.toJSON()),
          )
          .toList();

      //save the updated list of expenses to shared preferences
      await prefs.setStringList(_expenseKey, updatedExpenses);

      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense added successflully !"),
            duration: Duration(
              seconds: 2,
            ),
          ),
        );
      }
    } catch (error) {
      /*print(error.toString());*/
      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on adding Expense !!"),
            duration: Duration(
              seconds: 2,
            ),
          ),
        );
      }
    }
  }

  //load the expenses from shared preferences

  Future<List<Expense>> loadExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExpenses = pref.getStringList(_expenseKey);

    //convert the existing expenses to a list of Expense object
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map(
            (e) => Expense.fromJSON(
              json.decode(e),
            ),
          )
          .toList();
    }
    return loadedExpenses;
  }
}
