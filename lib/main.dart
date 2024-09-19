
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/login/login_cubit/login_cubit.dart';
import 'package:quicklab/signup/signup_page.dart';
import 'login/login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Base size for responsive design
      minTextAdapt: true, // Ensures text adapts to screen size
      splitScreenMode: true, // Ensures it works for split screen
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginCubit(),
            ),

          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/splash',
            routes: {
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/splash': (context) => SplashScreen(),
            },
          ),
        );
      },
    );
  }
}