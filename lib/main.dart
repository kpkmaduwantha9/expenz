import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/wrapper.dart';
import 'package:flutter/material.dart';
/*import 'package:flutter/services.dart'; //1 Import this for SystemChrome*/
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

/*  //1 Set the status bar color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: kMainDarkColor, //1 status bar color
      statusBarBrightness:
          Brightness.light, //1 For iOS (text color on status bar)
      statusBarIconBrightness:
          Brightness.light, //1 For Android (icon color on status bar)
    ),
  );
//1*/
  runApp(const KpApp());
}

class KpApp extends StatelessWidget {
  const KpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: FutureBuilder(
        future: UserServices.checkUsername(),
        builder: (context, snapshot) {
          //if the snapshot is still waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            //here the has userName will be set to true if the data is there in the snapshot and otherwise false
            bool hasUserName = snapshot.data ?? false;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: "Inter",
              ),
              home: Wrapper(showMainScreen: hasUserName),
            );
          }
        },
      ),
    );
  }
}
