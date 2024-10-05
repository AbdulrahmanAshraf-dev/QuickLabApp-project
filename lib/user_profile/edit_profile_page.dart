import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfilePage extends StatelessWidget {

  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              _buildProfileAvatar(),
              SizedBox(height: 24.h),
              _buildProfileForm(),
              SizedBox(height: 32.h),
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar with title
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Edit Profile',
        style: TextStyle(fontSize: 18.sp, color: Colors.white),
      ),
      backgroundColor: Color(0xFF6C5DD3),
    );
  }

  // Profile avatar
  Widget _buildProfileAvatar() {
    return Center(
      child: CircleAvatar(
        radius: 50.r,
        backgroundColor: Colors.purpleAccent,
        child: Icon(
          Icons.person,
          size: 50.r,
          color: Colors.white,
        ),
      ),
    );
  }

  // Profile form fields for Name, Phone, Email, and Address
  Widget _buildProfileForm() {
    return Column(
      children: [
        _buildTextField(Icons.person, 'Name', 'John Doe'),
        SizedBox(height: 16.h),
        _buildTextField(Icons.phone, 'Phone Number', '+1234567890'),
        SizedBox(height: 16.h),
        _buildTextField(Icons.email, 'Email', 'john.doe@example.com'),
        SizedBox(height: 16.h),
        _buildTextField(Icons.home, 'Address', '123 Main Street, City, Country'),
      ],
    );
  }

  // Save Changes button
  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Action to save profile edits and return to the previous page
          Navigator.pop(context);
        },
        child: Text('Save Changes', style: TextStyle(fontSize: 18.sp, color: Colors.white),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF6C5DD3),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
      ),
    );
  }

  // Helper function to build a reusable text field with icons
  Widget _buildTextField(IconData icon, String label, String hint) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xFF6C5DD3)),
        labelText: label,
        labelStyle: TextStyle(fontSize: 16.sp),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14.sp),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}