import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicklab/helpers/hive_helper.dart';
import 'package:quicklab/home/homescreen.dart';
import 'package:quicklab/signup/signup_page.dart';

import '../user_profile/cubit/profile_cubit.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()
  {
    context.read<ProfileCubit>().fetchUserProfile();
    Future.delayed(const Duration(seconds: 4),(){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HiveHelper.isLoggedIn()?Homescreen(): SignUpScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset('assets/images/logo.jpg',height: 291,width: 291,),
        ),
            ),
            const Column(
              children: [
                Text(
                  "Qucik Lab",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,height: -20
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 80.0),
              child: CircularProgressIndicator(),
            ),
            const Text("developed by Codroid Team",style: TextStyle(color: Colors.grey),),
          ],
            ),

      ),
    );
  }
}