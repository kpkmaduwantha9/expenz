import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  //for the checkbox
  bool _rememberMe = false;

  //form key for the form validation
  final _formKey = GlobalKey<FormState>();

  //controller for the text from fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your \nPersonal Details",
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                //form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //form field for user name
                      TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          //check whether the user entered a valid username
                          if (value!.isEmpty) {
                            return "Please Enter Your Name";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.h,
                            horizontal: 20.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      //form field for email
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          //check whether the user entered a valid username
                          if (value!.isEmpty) {
                            return "Please Enter Your Email";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.h,
                            horizontal: 20.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      //form field for user pw
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          //check whether the user entered a valid username
                          if (value!.isEmpty) {
                            return "Please Enter Your Password";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.h,
                            horizontal: 20.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      //form field for user confirm pw
                      TextFormField(
                        controller: _confirmPasswordController,
                        validator: (value) {
                          //check whether the user entered a valid username
                          if (value!.isEmpty) {
                            return "Please Enter Your Password Again";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.h,
                            horizontal: 20.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      //remember me for the next time
                      Row(
                        children: [
                          Text(
                            "Remember Me for the next time",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: kGrey,
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              activeColor: kMainColor,
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                  /*print(_rememberMe);*/
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      //submit button
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            //form is valid, process data
                            String userName = _usernameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String confirmPassword =
                                _confirmPasswordController.text;

                            /*print(
                              "$userName $email $password $confirmPassword",
                            );*/
                          }
                        },
                        child: CustomButton(
                          buttonName: "Next",
                          buttonColor: kMainColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
