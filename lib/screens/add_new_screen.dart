import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';

class AddNewScreen extends StatefulWidget {
  final Function(Expense) addExpense;
  const AddNewScreen({
    super.key,
    required this.addExpense,
  });

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  //state to track the expense or income
  int _selectedMethod = 0;

  ExpenseCategory _expenseCategory = ExpenseCategory.food;
  IncomeCategory _incomeCategory = IncomeCategory.salary;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethod == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Stack(
              children: [
                ///expense and income toggle
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: kDefaultPadding),
                            child: Container(
                              // height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedMethod = 0;
                                        });
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12),
                                          child: Text(
                                            "Expense",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: _selectedMethod == 0
                                                  ? kWhite
                                                  : kBlack,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: _selectedMethod == 0
                                              ? kRed
                                              : kWhite,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedMethod = 1;
                                        });
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12),
                                          child: Text(
                                            "Income",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: _selectedMethod == 1
                                                  ? kWhite
                                                  : kBlack,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: _selectedMethod == 1
                                              ? kGreen
                                              : kWhite,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          ///Amount field
                          Container(
                            margin: EdgeInsets.only(
                                // top: 100,
                                ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "How Much?",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: kLightGrey,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                TextField(
                                  style: TextStyle(
                                    fontSize: 60,
                                    color: kWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "0",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: kWhite,
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //user data form
                    Container(
                      // height: 600,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Form(
                          child: Column(
                            children: [
                              //category elector dropdown
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding,
                                    horizontal: 20,
                                  ),
                                ),
                                items: _selectedMethod == 0
                                    ? ExpenseCategory.values.map(
                                        (category) {
                                          return DropdownMenuItem(
                                            value: category,
                                            child: Text(category.name),
                                          );
                                        },
                                      ).toList()
                                    : IncomeCategory.values.map(
                                        (category) {
                                          return DropdownMenuItem(
                                            value: category,
                                            child: Text(category.name),
                                          );
                                        },
                                      ).toList(),
                                value: _selectedMethod == 0
                                    ? _expenseCategory
                                    : _incomeCategory,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedMethod == 0
                                        ? _expenseCategory =
                                            value as ExpenseCategory
                                        : _incomeCategory =
                                            value as IncomeCategory;
                                    /* print(_selectedMethod == 0
                                        ? _expenseCategory.name
                                        : _incomeCategory.name);*/
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //title field
                              TextFormField(
                                controller: _titleController,
                                decoration: InputDecoration(
                                  hintText: "Title",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding,
                                    horizontal: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //description field
                              TextFormField(
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                  hintText: "Description",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding,
                                    horizontal: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //Amount field
                              TextFormField(
                                controller: _amountController,
                                keyboardType:
                                    TextInputType.number, //change keyboard type

                                decoration: InputDecoration(
                                  hintText: "Amount",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding,
                                    horizontal: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //date picker
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2025),
                                      ).then((value) {
                                        if (value != null) {
                                          setState(() {
                                            _selectedDate = value;
                                          });
                                          /*print(_selectedDate);*/
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: kMainColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 15),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_month_outlined,
                                              color: kWhite,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Text(
                                                "Select date",
                                                style: TextStyle(
                                                  color: kWhite,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    // DateFormat.yMMMd().format(_selectedDate),
                                    DateFormat.yMMMMd().format(_selectedDate),
                                    style: TextStyle(
                                      color: kGrey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              //time picker
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then(
                                        (value) {
                                          if (value != null) {
                                            setState(() {
                                              _selectedTime = DateTime(
                                                _selectedDate.year,
                                                _selectedDate.month,
                                                _selectedDate.day,
                                                value.hour,
                                                value.minute,
                                              );
                                            });
                                          }
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: kYellow,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 15),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.access_time_outlined,
                                              color: kWhite,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Text(
                                                "Select Time",
                                                style: TextStyle(
                                                  color: kWhite,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateFormat.jm().format(_selectedTime),
                                    style: TextStyle(
                                      color: kGrey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Divider(
                                color: kLightGrey,
                                thickness: 5,
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              //submit button
                              GestureDetector(
                                onTap: () async {
                                  //save the expense or the income data into shared pref
                                  List<Expense> loadedExpenses =
                                      await ExpenseService().loadExpenses();
                                  /*print(loadedExpenses.length);*/
                                  //create the expense to store
                                  Expense expense = Expense(
                                    id: loadedExpenses.length + 1,
                                    title: _titleController.text,
                                    amount: _amountController.text.isEmpty
                                        ? 0
                                        : double.parse(_amountController.text),
                                    category: _expenseCategory,
                                    date: _selectedDate,
                                    time: _selectedTime,
                                    description: _descriptionController.text,
                                  );
                                  //add expense
                                  widget.addExpense(expense);
                                },
                                child: CustomButton(
                                  buttonName: "Add",
                                  buttonColor:
                                      _selectedMethod == 0 ? kRed : kGreen,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
