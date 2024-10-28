import 'package:flutter/material.dart';

//enum for expense categories
enum IncomeCategory {
  food,
  transport,
  health,
  shopping,
  subscriptions,
}

//category images
final Map<IncomeCategory, String> expenseCategoriesImages = {
  IncomeCategory.food: "assets/images/restaurant.png",
  IncomeCategory.transport: "assets/images/car.png",
  IncomeCategory.health: "assets/images/health.png",
  IncomeCategory.shopping: "assets/images/bag.png",
  IncomeCategory.subscriptions: "assets/images/bill.png",
};

//category colors
final Map<IncomeCategory, Color> expenseCategoryColors = {
  IncomeCategory.food: const Color(0xFFE57373),
  IncomeCategory.transport: const Color(0xFF81C784),
  IncomeCategory.health: const Color(0xFF64B5F6),
  IncomeCategory.shopping: const Color(0xFFFFD54F),
  IncomeCategory.subscriptions: const Color(0xFF9575CD),
};

//model
class Expense {
  final int id;
  final String title;
  final double amount;
  final IncomeCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });

  // convert the Expense object to a JSON object  \\serialization//  DART -> JSON
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.index,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'description': description,
    };
  }

  //create an Expense object from a JSON object  \\deserialization//  JSON -> DART
  factory Expense.fromJSON(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      category: IncomeCategory.values[json['category']],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      description: json['description'],
    );
  }
}
