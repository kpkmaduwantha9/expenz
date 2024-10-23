import 'package:flutter/material.dart';

void main() {
  runApp(const KpApp());
}

class KpApp extends StatelessWidget {
  const KpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expenz",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            "Data",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
