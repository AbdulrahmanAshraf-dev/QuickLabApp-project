
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'edit_profile_page.dart';

class PatientProfilePage extends StatelessWidget {
  const PatientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildProfileHeader(),
              SizedBox(height: 24.h),
              buildPersonalInfoCard(),
              SizedBox(height: 16.h),
              buildMedicalHistorySection(),
              buildUpdateContactButton(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: const SizedBox(),
      centerTitle: true,
      toolbarHeight: 60,
      title: Text(
        'Patient Profile',
        style: TextStyle(
          fontSize: 24.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFF6C5DD3),
      actions: [
        IconButton(
          icon: Icon(
            Icons.edit,
            size: 24.sp,
            color: Colors.white,
          ),
          onPressed: () {
            // Navigate to Edit Profile Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfilePage()),
            );
          },
        )
      ],
    );
  }

  Widget buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50.r,
          backgroundColor: Colors.purpleAccent,
          child: Icon(
            Icons.person,
            size: 50.r,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'John Doe',
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A4A58)),
        ),
        SizedBox(height: 8.h),
        Text(
          'Phone: +1234567890\nEmail: john.doe@example.com',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget buildPersonalInfoCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: Color(0xFFF3E5F5),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',

              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A)),

            ),
            SizedBox(height: 16.h),
            buildInfoRow('Age', '30'),
            buildInfoRow('Gender', 'Male'),
            buildInfoRow('Address', '123 Main Street, City, Country'),
          ],
        ),
      ),
    );
  }

  Widget buildMedicalHistorySection() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: Color(0xFFE1F5FE),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medical History',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0277BD)),

            ),
            SizedBox(height: 16.h),
            buildMedicalHistoryItem('Blood Test - 12/08/2024'),
            buildMedicalHistoryItem('Chest X-Ray - 10/07/2024'),
            buildMedicalHistoryItem('Urine Test - 05/05/2024'),
          ],
        ),
      ),
    );
  }

  Widget buildUpdateContactButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Action for updating contact information
        },

        child: Text('Update Contact Info',
            style: TextStyle(fontSize: 16.sp, color: Colors.white)),

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

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6A1B9A))),
          Text(value,
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[600])),

        ],
      ),
    );
  }

  Widget buildMedicalHistoryItem(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(Icons.history, color: Color(0xFF0277BD), size: 24.r),
          SizedBox(width: 16.w),
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

