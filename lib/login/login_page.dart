import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/login/login_cubit/login_cubit.dart';
import 'package:quicklab/user_profile/cubit/profile_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginSuccessful) {
            if (state.isEmail == true) {
              bool isAdmin= await context.read<LoginCubit>().isAdmin(state.result!);
              isAdmin ? Navigator.pushNamed(context, '/users') :
              Navigator.pushNamed(context, '/home');
            } else {
              bool check = await context.read<LoginCubit>().fetchUserProfile();
              if (check == false) {
                if (context.mounted) {
                  Navigator.pushNamed(context, '/subLogin');
                }
              } else {
                if (context.mounted) {
                  Navigator.pushNamed(context, '/home');
                }
              }
            }
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.black,
                  content: Text(
                    state.error,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildTopIcon(),
                  SizedBox(height: 50.h),
                  _buildLoginTitle(),
                  SizedBox(height: 30.h),
                  _buildEmailTextField(context),
                  SizedBox(height: 20.h),
                  _buildPasswordTextField(context),
                  SizedBox(height: 10.h),
                  _buildForgotPasswordButton(),
                  SizedBox(height: 20.h),
                  _buildLoginButton(context),
                  SizedBox(height: 30.h),
                  _buildOrLoginWith(),
                  SizedBox(height: 40.h),
                  _buildSocialLoginButtons(context),
                  SizedBox(height: 50.h),
                  _buildSignUpText(context),
                ],
              ),
            ),
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

  Widget _buildLoginTitle() {
    return Column(
      children: [
        Text(
          'Log In',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          'Use your credentials and login to your account',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return TextField(
      controller: context.read<LoginCubit>().emailController,
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

  Widget _buildPasswordTextField(BuildContext context) {
    return TextField(
      controller: context.read<LoginCubit>().passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        filled: true,
        fillColor: const Color(0xFFF3F5F7),
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        suffixIcon: const Icon(Icons.visibility, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.cyan,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.read<LoginCubit>().login();
          context.read<ProfileCubit>().fetchUserProfile();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan,
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 120.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            }
            return Text(
              'Log In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ));
  }

  Widget _buildOrLoginWith() {
    return Text(
      'Or Log in with',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 14.sp,
      ),
    );
  }

  Widget _buildSocialLoginButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildSocialBtn(
          'assets/images/facebook.png',
          context,
          () {
            context.read<LoginCubit>().signInWithFaceBook();
          },
        ), // Facebook Icon
        _buildSocialBtn(
          'assets/images/google.png',
          context,
          () {
            context.read<LoginCubit>().signInWithGoogle();
          },
        ), // Google Icon
      ],
    );
  }

  Widget _buildSignUpText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('If you are new', style: TextStyle(fontSize: 14.sp)),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signup'); // Navigate to Sign Up Page
          },
          child: Text(
            'Create New Account',
            style: TextStyle(fontSize: 14.sp, color: Colors.cyan),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(
      String imagePath, BuildContext context, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        width: 60.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            height: 30.h,
            width: 30.h,
          ),
        ),
      ),
    );
  }
}
