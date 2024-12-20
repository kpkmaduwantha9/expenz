import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/income_expence_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/income_model.dart';
import '../widgets/expense_card.dart';
import '../widgets/line_chart.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<Income> incomeList;
  const HomeScreen({
    super.key,
    required this.expenseList,
    required this.incomeList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the username
  String userName = "";

  double expenseTotal = 0;
  double incomeTotal = 0;

  @override
  void initState() {
    // TODO: implement initState
    //get the username from the shared pref
    UserServices.getUserData().then(
      (value) {
        if (value["userName"] != null) {
          setState(() {
            userName = value["userName"]!;
            /*print(userName);*/
          });
        }
      },
    );

    setState(() {
      //total amount of expenses
      for (var i = 0; i < widget.expenseList.length; i++) {
        expenseTotal += widget.expenseList[i].amount;
      }

      //total amount of income
      for (var k = 0; k < widget.incomeList.length; k++) {
        incomeTotal += widget.incomeList[k].amount;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          //main column
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //colored column
              Container(
                // height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment.bottomLeft,
                    begin: Alignment.topRight,
                    colors: [
                      kMainDarkColor.withOpacity(1),
                      kMainColor.withOpacity(1),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  border: Border.all(
                                    color: kWhite,
                                    width: 3,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.r),
                                  child: Image.asset(
                                    "assets/images/user.jpg",
                                    width: 60.sp,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "WELCOME",
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w800,
                                      color: kLightGrey,
                                    ),
                                  ),
                                  Text(
                                    userName.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w500,
                                      color: kWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications,
                              color: kWhite,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IncomeExpenseCard(
                              title: "Income    ",
                              amount: incomeTotal,
                              imageUrl: "assets/images/income.png",
                              bgColor: kGreen,
                            ),
                            IncomeExpenseCard(
                              title: "Expenses",
                              amount: expenseTotal,
                              imageUrl: "assets/images/expense.png",
                              bgColor: kRed,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //lineChart
              Padding(
                padding: REdgeInsets.all(
                  kDefaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Spend frequency",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    LineChartSample(),
                  ],
                ),
              ),

              //recent transaction
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Recent Transaction",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        widget.expenseList.isEmpty
                            ? Text(
                                "No expenses added yet, add some expenses to see here\n ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: kGrey,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget.expenseList.length,
                                itemBuilder: (context, index) {
                                  final expense = widget.expenseList[index];

                                  return ExpenseCard(
                                    title: expense.title,
                                    date: expense.date,
                                    amount: expense.amount,
                                    category: expense.category,
                                    description: expense.description,
                                    time: expense.time,
                                  );
                                },
                              )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
