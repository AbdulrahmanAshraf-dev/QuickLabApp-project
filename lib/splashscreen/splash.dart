import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/helpers/hive_helper.dart';
import 'package:quicklab/home/homescreen.dart';
import 'package:quicklab/signup/signup_page.dart';
import 'package:quicklab/users_in_admin/admin_screen.dart';

import '../user_profile/cubit/profile_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().fetchUserProfile();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HiveHelper.isLoggedIn()
                  ? HiveHelper.isAdmin()!
                      ? const AdminScreen()
                      : const Homescreen()
                  : const SignUpScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(bottom: 20.0.h),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/logo2.jpg',
                  height: 291.h,
                  width: 291.w,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  "Qucik Lab",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      height: -22.h),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 80.0.h),
              child: const CircularProgressIndicator(
                color: Colors.cyan,
              ),
            ),
            const Text(
              "developed by Codroid Team",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
