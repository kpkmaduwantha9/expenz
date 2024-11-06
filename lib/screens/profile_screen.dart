import 'package:expenz/constants/constants.dart';
import 'package:expenz/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String email = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserServices.getUserData().then(
      (value) {
        if (value['userName'] != null && value['email'] != null) {
          setState(() {
            userName = value['userName']!;
            email = value['email']!;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                              color: kMainColor,
                              width: 3,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: Image.asset(
                              "assets/images/user.jpg",
                              width: 70.sp,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName.toUpperCase(),
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w500,
                                color: kBlack,
                              ),
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: kGrey,
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
                      icon: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: kMainColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.edit,
                          color: kMainColor,
                          size: 25,
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
