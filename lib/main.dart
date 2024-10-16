import 'package:flutter/material.dart';
import 'package:lms_project/pages/login.dart';
import 'package:lms_project/pages/navs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),

    );
  }
}
