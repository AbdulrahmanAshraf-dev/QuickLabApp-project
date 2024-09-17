import 'package:flutter/material.dart';
import 'package:quicklab/signup/signup_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()
  {
    Future.delayed(const Duration(seconds: 10),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset('assets/image/logo.jpg'),
        ),
            ),
            const Text("developed by Codroid Team",style: TextStyle(color: Colors.grey),)
          ],
            ),
      ),
    );
  }
}