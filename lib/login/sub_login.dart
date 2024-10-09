import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quicklab/login/sub_login_cubit/sub_login_cubit.dart';

import '../helpers/hive_helper.dart';

class SubLoginScreen extends StatefulWidget {
  const SubLoginScreen({super.key});

  @override
  State<SubLoginScreen> createState() => _SubLoginScreenState();
}

class _SubLoginScreenState extends State<SubLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<SubLoginCubit, SubLoginState>(
          listener: (context, state) {
            if (state is SubLoginSuccessful) {
              Navigator.pushNamed(context, '/home');
            } else if (state is SubLoginFailure) {
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
                    _buildTextField('Enter full name', false),
                    SizedBox(height: 20.h),
                    _buildPhoneNumberField(),
                    SizedBox(height: 20.h),
                    _buildMaleOrFemale(),
                    SizedBox(height: 20.h),
                    _buildSelectedAge(context),
                    SizedBox(height: 20.h),
                    _buildFinishButton(context),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }

  DropdownButton<String> _buildSelectedAge(BuildContext context) {
    return DropdownButton<String>(
      hint: const Text('Select Age'),
      value: context.read<SubLoginCubit>().selectedAge,
      items: List.generate(100, (index) => (index + 1).toString())
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          context.read<SubLoginCubit>().selectedAge = newValue!;
        });
      },
    );
  }

  Row _buildMaleOrFemale() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Expanded(
        child: ListTile(
          title: const Text('Male'),
          leading: Radio<String>(
            value: 'Male',
            groupValue: context.read<SubLoginCubit>().selectedGender,
            onChanged: (String? value) {
              setState(() {
                context.read<SubLoginCubit>().selectedGender = value!;
              });
            },
          ),
        ),
      ),
      Expanded(
        child: ListTile(
          title: const Text('Female'),
          leading: Radio<String>(
            value: 'Female',
            groupValue: context.read<SubLoginCubit>().selectedGender,
            onChanged: (String? value) {
              setState(() {
                context.read<SubLoginCubit>().selectedGender = value!;
              });
            },
          ),
        ),
      ),
    ]);
  }

  Widget _buildTopIcon() {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo.jpg',
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
          'Complete your Profile',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5.h),
      ],
    );
  }

  Widget _buildTextField(String hintText, bool isPassword) {
    return TextField(
      obscureText: isPassword,
      controller:  context.read<SubLoginCubit>().nameEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
        suffixIcon: isPassword ? const Icon(Icons.visibility_off) : null,
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return InternationalPhoneNumberInput(
      textFieldController: context.read<SubLoginCubit>().phoneEditingController,
      initialValue: PhoneNumber(isoCode: "EG"),
      onInputChanged: (PhoneNumber number) {
        setState(() {
        });
      },
      onInputValidated: (bool value) {
        // Handle validation result
      },
      selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.DROPDOWN, showFlags: true),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      formatInput: false,
      cursorColor: Colors.black,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
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

  Widget _buildFinishButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
            context.read<SubLoginCubit>().updateUserProfile();
            HiveHelper.checkLogin(true);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C5DD3),
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 120.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: BlocBuilder<SubLoginCubit, SubLoginState>(
          builder: (context, state) {
            if (state is SubLoginLoading) {
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            }
            return Text(
              'Finish',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ));
  }
}
