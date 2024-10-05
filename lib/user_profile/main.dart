import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/profile_cubit.dart';
import 'profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Adjust according to base design
      builder: (context, child) {
        return BlocProvider(
          create: (context) => ProfileCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: PatientProfilePage(),
          ),
        );
      },
    );
  }
}