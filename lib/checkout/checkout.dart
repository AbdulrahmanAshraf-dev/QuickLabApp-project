import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'cubit/checkout_cubit.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.total});

  final int total;

  @override
  CheckoutPageState createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  static DateTime? _selectedDateTime;
  static String? _paymentMethod;
  static String? _getTestMethod;
  int totalP = 0;

  @override
  void initState() {
    totalP = widget.total;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: _buildTitle(),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.cyan),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTextField('Enter full name', false, (value) {
                }),
                SizedBox(height: 20.h),
                _buildPhoneNumberField(),
                SizedBox(height: 20.h),
                _buildDateTimePicker(),
                SizedBox(height: 20.h),
                _buildMethodPaymentDropdown(),
                SizedBox(height: 20.h),
                _buildDropdown(),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$totalP\$',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Complete Your Checkout',
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: Colors.cyan,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTextField(
      String hintText, bool isPassword, Function(String?) onSaved) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
      ),
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneNumberField() {
    return InternationalPhoneNumberInput(
      initialValue: PhoneNumber(isoCode: "EG"),
      onInputChanged: (PhoneNumber number) {
      },
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
        showFlags: true,
      ),
      ignoreBlank: false,
      formatInput: true,
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

  Widget _buildDateTimePicker() {
    return ListTile(
      title: Text(
        _selectedDateTime == null
            ? 'Select Appointment Date & Time'
            : 'Appointment: ${_selectedDateTime!.toLocal()}'.split('.')[0],
        style: TextStyle(fontSize: 16.sp),
      ),
      trailing: const Icon(Icons.calendar_today, color: Colors.cyan),
      onTap: _pickDateTime,
    );
  }

  Future<void> _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Widget _buildMethodPaymentDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: 'Select Payment Method',
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
      ),
      items: ['Credit Card', 'Cash', 'Bank Transfer']
          .map((method) => DropdownMenuItem(
                value: method,
                child: Text(method),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _paymentMethod = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a payment method';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: 'Select How To Get Your Test',
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
      ),
      items: ['In Home ( + 25\$)', 'In Lab']
          .map((method) => DropdownMenuItem(
                value: method,
                child: Text(method),
              ))
          .toList(),
      onChanged: (value) {
        _getTestMethod = value;
        if (_getTestMethod == 'In Home ( + 25\$)') {
          totalP == widget.total ? totalP += 25 : null;
        } else {
          totalP != widget.total ? totalP -= 25 : null;
        }
        setState(() {});
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select How to get your test';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccessState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Success'),
              content:
                  const Text('Your appointment has been booked successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );

        }
        if (state is CheckoutErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(state.error),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CheckoutLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          );
        }
        return ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              context.read<CheckoutCubit>().addCheckout(
                  isCash: _paymentMethod == 'Cash',
                  isInHome: _getTestMethod == 'In Home ( + 25\$)',
                  date: _selectedDateTime!,
                  context: context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan,
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 120.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          child: Text(
            'Confirm',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
