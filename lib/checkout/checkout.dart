import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Checkout App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: CheckoutPage(),
        );
      },
    );
  }
}

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  DateTime? _selectedDateTime;
  String? _paymentMethod;
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'EG');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTitle(),
              SizedBox(height: 30.h),
              _buildTextField('Enter full name', false, (value) {
                _name = value;
              }),
              SizedBox(height: 20.h),
              _buildPhoneNumberField(),
              SizedBox(height: 20.h),
              _buildDateTimePicker(),
              SizedBox(height: 20.h),
              _buildDropdown(),
              SizedBox(height: 30.h),
              _buildSubmitButton(),
            ],
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

  Widget _buildTextField(String hintText, bool isPassword, Function(String?) onSaved) {
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
        _phoneNumber = number;
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

  // عنصر واجهة المستخدم لاختيار التاريخ والوقت
  Widget _buildDateTimePicker() {
    return ListTile(
      title: Text(
        _selectedDateTime == null
            ? 'Select Appointment Date & Time'
            : 'Appointment: ${_selectedDateTime!.toLocal()}'.split('.')[0],
        style: TextStyle(fontSize: 16.sp),
      ),
      trailing: Icon(Icons.calendar_today, color: Colors.cyan),
      onTap: _pickDateTime,
    );
  }

  // دالة لاختيار التاريخ والوقت معًا
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

  Widget _buildDropdown() {
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

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
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
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle the submission (e.g., send data to backend)
      print('Name: $_name');
      print('Phone: ${_phoneNumber.phoneNumber}');
      print('Date & Time: $_selectedDateTime');
      print('Payment Method: $_paymentMethod');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Your appointment has been booked successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
