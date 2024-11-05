import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _SelectedOption = 0;
  @override
  Widget build(BuildContext context) {
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
                              _SelectedOption = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _SelectedOption == 1 ? kWhite : kRed,
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
                                        _SelectedOption == 1 ? kBlack : kWhite,
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
                              _SelectedOption = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _SelectedOption == 0 ? kWhite : kGreen,
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
                                        _SelectedOption == 0 ? kBlack : kWhite,
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
            ],
          ),
        ),
      ),
    );
  }
}
