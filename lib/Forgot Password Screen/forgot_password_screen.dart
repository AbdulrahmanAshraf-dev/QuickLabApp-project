import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'enter_code_screen.dart'; // Import the Enter Code Screen

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTopIcon(),
              SizedBox(height: 50.h),
              _buildForgotPasswordTitle(),
              SizedBox(height: 30.h),
              _buildEmailTextField(),
              SizedBox(height: 20.h),
              _buildSendResetLinkButton(context), // Pass context to navigate
              SizedBox(height: 50.h),
              _buildBackToLoginText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopIcon() {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo2.jpg',
            height: 100.h,
          ),
          Text(
            'QuickLap',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordTitle() {
    return Column(
      children: [
        Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          'Enter your email to receive a reset link',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Enter your email',
        filled: true,
        fillColor: const Color(0xFFF3F5F7),
        prefixIcon: const Icon(Icons.email, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSendResetLinkButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to Enter Code Screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EnterCodeScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyan,
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 80.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Text(
        'Send Reset Link',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBackToLoginText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Remember your password?', style: TextStyle(fontSize: 14.sp)),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Go back to Login Page
          },
          child: Text(
            'Log In',
            style: TextStyle(fontSize: 14.sp, color: Colors.cyan),
          ),
        ),
      ],
    );
  }
}
