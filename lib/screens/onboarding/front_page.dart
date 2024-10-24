import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo.png",
          width: 120.w,
          fit: BoxFit.cover,
        ),
        // SizedBox(
        //   height: 5.h,
        // ),
        Center(
          child: Text(
            "Expenz",
            style: TextStyle(
              fontSize: 40.sp,
              color: kMainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
