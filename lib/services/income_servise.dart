import 'dart:convert';

import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  //define the key for storing incomes in shared preferences
  static const String _incomeKey = 'income';

  //save the income to shared preferences
  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      //convert the existing income to a list of income objects
      List<Income> existingIncomeObjects = [];

      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map(
              (e) => Income.fromJson(
                json.decode(e),
              ),
            )
            .toList();
      }

      //add the new to the list
      existingIncomeObjects.add(income);

      // Convert the list of Income objects back to a list of strings
      List<String> updatedIncome = existingIncomeObjects
          .map(
            (e) => json.encode(
              e.toJson(),
            ),
          )
          .toList();

      // Save the updated list of incomes to shared preferences

      await prefs.setStringList(_incomeKey, updatedIncome);

      //show snackBar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income Added Successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on adding income!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

//Load the income from shared preferences
  Future<List<Income>> loadIncomes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingIncomes = pref.getStringList(_incomeKey);

    // Convert the existing incomes to a list of income objects
    List<Income> loadedIncomes = [];
    if (existingIncomes != null) {
      loadedIncomes = existingIncomes
          .map(
            (e) => Income.fromJson(
              json.decode(e),
            ),
          )
          .toList();
    }

    // Return the list of loaded incomes
    return loadedIncomes;
  }
}
