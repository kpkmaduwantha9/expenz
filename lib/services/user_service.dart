import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///services

class UserServices {
  //method to store the user name and email in shared pref.
  static Future<void> storeUserDetails({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      //check whether the user entered password and and the confirm password are same
      if (password != confirmPassword) {
        //show the message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password and Confirm password do not match"),
          ),
        );
        return;
      }
      //if the users pw and c pw are same, then store username and email
      //create an instance from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // store the username and email as key value pairs
      await prefs.setString("userName", userName);
      await prefs.setString("email", email);

      //show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User Details Stored Successfully"),
        ),
      );
    } catch (err) {
      err.toString();
    }
  }

  //method to check whether the username is saved in the shared pref
  static Future<bool> checkUsername() async {
    //create an instance for shared pref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString("userName");
    return userName != null;
  }

  //get the username and email
  static Future<Map<String, String>> getUserData() async {
    //create an instance for shared pref
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userName = pref.getString("userName");
    String? email = pref.getString("email");

    return {
      "userName": userName!,
      "email": email!,
    };
  }

  //remove the username and email from shared preferences
  static Future<void> ClearUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('userName');
    await pref.remove('email');
  }
}
