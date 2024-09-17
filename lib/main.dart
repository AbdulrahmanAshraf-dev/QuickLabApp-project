import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/signup/signup_page.dart';
import 'login/login_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // Base size for responsive design
      minTextAdapt: true, // Ensures text adapts to screen size
      splitScreenMode: true, // Ensures it works for split screen
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/signup',
          routes: {
            '/login': (context) => LoginScreen(),
            '/signup': (context) => SignUpScreen(),
          },
        );
      },
    );
  }
}