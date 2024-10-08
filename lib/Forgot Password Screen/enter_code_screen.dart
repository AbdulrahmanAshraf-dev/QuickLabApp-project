import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'reset_password_screen.dart'; // Import the Reset Password Screen

class EnterCodeScreen extends StatelessWidget {
  const EnterCodeScreen({super.key});

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
              _buildEnterCodeTitle(),
              SizedBox(height: 30.h),
              _buildCodeTextField(),
              SizedBox(height: 20.h),
              _buildVerifyCodeButton(context),
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
            'assets/images/lap.png',
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

  Widget _buildEnterCodeTitle() {
    return Column(
      children: [
        Text(
          'Enter Code',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          'Enter the code sent to your email',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCodeTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Enter your code',
        filled: true,
        fillColor: const Color(0xFFF3F5F7),
        prefixIcon: const Icon(Icons.vpn_key, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildVerifyCodeButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to Reset Password Screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6C5DD3),
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 80.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Text(
        'Verify Code',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
