import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../login/login_page.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isChecked = false;
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'US');

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLogo(),
              SizedBox(height: 50),
              _buildTitle(),
              SizedBox(height: 5),
              _buildSubtitle(),
              SizedBox(height: 30),
              _buildTextField('Enter full name', false),
              SizedBox(height: 20),
              _buildTextField('Enter your email', false),
              SizedBox(height: 20),
              _buildPhoneNumberField(),
              SizedBox(height: 20),
              _buildTextField('Enter your password', true),
              SizedBox(height: 12),
              _buildTermsCheckbox(),
              SizedBox(height: 12),
              _buildSignUpButton(),
              SizedBox(height: 12),
              _buildLoginText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/image/logo.jpg', // Ensure this path is correct
          height: 100,
        ),
        Text(
          'Quick Lap',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'Sign Up',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Use your details to create a new account!',
      style: TextStyle(color: Colors.grey[600], fontSize: 14),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTextField(String hintText, bool isPassword) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        suffixIcon: isPassword ? Icon(Icons.visibility_off) : null,
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        setState(() {
          _phoneNumber = number;
        });
      },
      onInputValidated: (bool value) {
        // Handle validation result
      },
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
        showFlags: true,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      formatInput: false,
      cursorColor: Colors.black,
      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
      inputDecoration: InputDecoration(
        hintText: 'Enter phone number',
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.green, // Change the color when checked
        ),
        Expanded(
          child: Text(
            'I agree with Terms & Privacy',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: _isChecked ? () {} : null, // Disable if checkbox is not checked
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF6C5DD3),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 120),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        'Sign Up',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLoginText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?', style: TextStyle(fontSize: 14)),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login'); // Navigate to Login Page
          },
          child: Text('Login', style: TextStyle(fontSize: 14, color: Color(0xFF9B51E0))),
        ),
      ],
    );
  }
}