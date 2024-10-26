import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/income_expence_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the username
  String userName = "";
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          //main column
          child: Column(
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
                              amount: 25,
                              imageUrl: "assets/images/income.png",
                              bgColor: kGreen,
                            ),
                            IncomeExpenseCard(
                              title: "Expenses",
                              amount: 20,
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
            ],
          ),
        ),
      ),
    );
  }
}
