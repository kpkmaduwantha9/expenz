import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncomeExpenseCard extends StatefulWidget {
  final String title;
  final double amount;
  final String imageUrl;
  final Color bgColor;
  const IncomeExpenseCard({
    super.key,
    required this.title,
    required this.amount,
    required this.imageUrl,
    required this.bgColor,
  });

  @override
  State<IncomeExpenseCard> createState() => _IncomeExpenseCardState();
}

class _IncomeExpenseCardState extends State<IncomeExpenseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.45,
      // width: 160.sp,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              // width: MediaQuery.of(context).size.width * 0.15,
              // height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: Image.asset(
                    widget.imageUrl,
                    width: 32.w,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: kWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "\$ ${widget.amount.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: kWhite,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
