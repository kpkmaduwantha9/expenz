import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotal;
  final Map<IncomeCategory, double> incomeCategoryTotal;
  final bool isExpense;
  const PieChartWidget({
    super.key,
    required this.expenseCategoryTotal,
    required this.incomeCategoryTotal,
    required this.isExpense,
  });

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  //sections data
  List<PieChartSectionData> getSections() {
    if (widget.isExpense) {
      return [
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.food],
          value: widget.expenseCategoryTotal[ExpenseCategory.food] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.health],
          value: widget.expenseCategoryTotal[ExpenseCategory.health] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.shopping],
          value: widget.expenseCategoryTotal[ExpenseCategory.shopping] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.subscriptions],
          value:
              widget.expenseCategoryTotal[ExpenseCategory.subscriptions] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.transport],
          value: widget.expenseCategoryTotal[ExpenseCategory.transport] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.freelance],
          value: widget.incomeCategoryTotal[IncomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.passive],
          value: widget.incomeCategoryTotal[IncomeCategory.passive] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.salary],
          value: widget.incomeCategoryTotal[IncomeCategory.salary] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.sales],
          value: widget.incomeCategoryTotal[IncomeCategory.sales] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 50,
      startDegreeOffset: -90,
      sections: getSections(),
      borderData: FlBorderData(show: false),
    );
    return Container(
      height: 250,
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        //color: kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        //for add total expenses text in front of pie chart
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "70%",
                style: TextStyle(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "of 100%",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
