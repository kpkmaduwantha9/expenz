import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/expense_model.dart';
import '../models/income_model.dart';
import '../widgets/pie_chart_widget.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotal;
  final Map<IncomeCategory, double> incomeCategoryTotal;
  const BudgetScreen({
    super.key,
    required this.expenseCategoryTotal,
    required this.incomeCategoryTotal,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _selectedOption = 0;

  //method to find category color from the category
  Color getCategoryColor(dynamic category) {
    if (category is ExpenseCategory) {
      return expenseCategoryColors[category]!;
    } else {
      return incomeCategoryColor[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _selectedOption == 0
        ? widget.expenseCategoryTotal
        : widget.incomeCategoryTotal;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Financial Report",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: kBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),

                ///expense and income toggle
                child: Container(
                  //height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(
                        color: kBlack.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ///Expense button
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedOption = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _selectedOption == 1 ? kWhite : kRed,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Text(
                                  "Expense",
                                  style: TextStyle(
                                    color:
                                        _selectedOption == 1 ? kBlack : kWhite,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// - Expense button

                      /// Income Button
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedOption = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _selectedOption == 0 ? kWhite : kGreen,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Text(
                                  "Income",
                                  style: TextStyle(
                                    color:
                                        _selectedOption == 0 ? kBlack : kWhite,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// - Income Button
                    ],
                  ),
                ),

                /// - expense and income toggle
              ),
              SizedBox(
                height: 10,
              ),
              //Pie Chart
              PieChartWidget(
                expenseCategoryTotal: widget.expenseCategoryTotal,
                incomeCategoryTotal: widget.incomeCategoryTotal,
                isExpense: _selectedOption == 0,
              ),
              SizedBox(
                height: 10,
              ),
              //list of categories
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final category = data.keys.toList()[index];
                    final total = data.values.toList()[index];
                    return CategoryCard(
                      title: category.name,
                      amount: total,
                      total: data.values.reduce(
                        (value, element) => value + element,
                      ),
                      progressColor: getCategoryColor(category),
                      isExpense: _selectedOption == 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
