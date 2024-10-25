import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
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
