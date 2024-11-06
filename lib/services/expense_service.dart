import 'dart:convert';

import 'package:expenz/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  //Expense List
  // List<Expense> expensesList = [];

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

  //delete the expense from shared preferences from the id
  Future<void> deleteExpense(int id, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingExpenses = pref.getStringList(_expenseKey);

      // Convert the existing expenses to a list of Expense objects
      List<Expense> existingExpenseObjects = [];
      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map(
              (e) => Expense.fromJSON(
                json.decode(e),
              ),
            )
            .toList();

        // Remove the expense with the specified id from the list
        existingExpenseObjects.removeWhere(
          (expense) => expense.id == id,
        );

        // Convert the list of Expense objects back to a list of strings
        List<String> updatedExpenses = existingExpenseObjects
            .map(
              (e) => json.encode(
                e.toJSON(),
              ),
            )
            .toList();

        // Save the updated list of expenses to shared preferences
        await pref.setStringList(_expenseKey, updatedExpenses);

        //show snack bar
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Expense deleted Successfully!"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (error) {
      print(error.toString());
      //show snack bar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("ERROR deleting Expense!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //delete all expenses from shared preferences

  Future<void> deleteAllExpence(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(_expenseKey);

      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("All expenses deleted"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      SnackBar(
        content: Text("ERROR deleting Expenses!"),
        duration: Duration(seconds: 2),
      );
    }
  }
}
