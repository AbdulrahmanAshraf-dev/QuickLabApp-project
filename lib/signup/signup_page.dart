import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/signup/cubit/signup_cubit.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isChecked = false;
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'US');
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          // Navigate to another screen or show success message
        } else if (state is SignupErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLogo(),
                SizedBox(height: 50.h),
                _buildTitle(),
                SizedBox(height: 5.h),
                _buildSubtitle(),
                SizedBox(height: 30.h),
                _buildTextField('Enter full name', false, _nameController),
                SizedBox(height: 20.h),
                _buildTextField('Enter your email', false, _emailController),
                SizedBox(height: 20.h),
                _buildPhoneNumberField(),
                SizedBox(height: 20.h),
                _buildTextField('Enter your password', true, _passwordController),
                SizedBox(height: 12.h),
                _buildTermsCheckbox(),
                SizedBox(height: 12.h),
                _buildSignUpButton(),
                SizedBox(height: 12.h),
                _buildLoginText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/images/lap.png', // Ensure this path is correct
          height: 100.h,
        ),
        Text(
          'QuickLap',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'Sign Up',
      style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Use your details to create a new account!',
      style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTextField(String hintText, bool isPassword, TextEditingController controller) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
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
        showFlags: true
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
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
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
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: _isChecked ? () {
        context.read<SignupCubit>().signUpWithEmailPassword(
            _emailController.text,
            _passwordController.text,
            _nameController.text,
            _phoneNumber.phoneNumber! // Pass the formatted phone number
        );
      } : null, // Disable if checkbox is not checked
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF6C5DD3),
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 120.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Text(
        'Sign Up',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLoginText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?', style: TextStyle(fontSize: 14.sp)),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login'); // Navigate to Login Page
          },
          child: Text('Login', style: TextStyle(fontSize: 14.sp, color: Color(0xFF9B51E0))),
        ),
      ],
    );
  }
}