
import 'package:flutter/material.dart';




class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTopIcon(),
              const SizedBox(height: 50),
              _buildLoginTitle(),
              const SizedBox(height: 30),
              _buildEmailTextField(),
              const SizedBox(height: 20),
              _buildPasswordTextField(),
              const SizedBox(height: 10),
              _buildForgotPasswordButton(),
              const SizedBox(height: 20),
              _buildLoginButton(),
              const SizedBox(height: 30),
              _buildOrLoginWith(),
              const SizedBox(height: 40),
              _buildSocialLoginButtons(),
              const SizedBox(height: 100),
              _buildSignUpText(context),
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
            'assets/image/logo.jpg',
            height: 100,
          ),
          const Text(
            'Quick Lap',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginTitle() {
    return const Column(
      children: [
        Text(
          'Log In',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Use your credentials and login to your account',
          style: TextStyle(
            fontSize: 14,
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
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        filled: true,
        fillColor: const Color(0xFFF3F5F7),
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        suffixIcon: const Icon(Icons.visibility, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
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
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.purple,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6C5DD3),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text(
        'Log In',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOrLoginWith() {
    return const Text(
      'Or Log in with',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildSocialBtn('assets/image/apple.png'), // Phone Icon
        _buildSocialBtn('assets/image/facebook.png'), // Facebook Icon
        _buildSocialBtn('assets/image/google.png'), // Google Icon
      ],
    );
  }

  Widget _buildSignUpText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('if you are new', style: TextStyle(fontSize: 14)),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signup'); // Navigate to Sign Up Page
          },
          child: const Text('Create New Account', style: TextStyle(fontSize: 14, color: Color(0xFF9B51E0))),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(String imagePath) {
    return GestureDetector(
      onTap: () {
        print('Social button pressed');
      },
      child: Container(
        height: 60,
        width: 60,
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
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}