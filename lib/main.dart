import 'package:expenz/screens/onboarding_screen.dart';
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
      child: MaterialApp(
        title: "Expenz",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Inter",
        ),
        home: const OnboardingScreen(),
      ),
    );
  }
}
