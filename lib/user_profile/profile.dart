import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/helpers/hive_helper.dart';

import '../login/login_page.dart';
import 'cubit/profile_cubit.dart';
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
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileSuccessful) {
                    return Column(
                      children: [
                        buildProfileHeader(state.userData.name,
                            state.userData.phoneNumber, context),
                        SizedBox(height: 24.h),
                        buildPersonalInfoCard(
                            state.userData.age, state.userData.gender),
                      ],
                    );
                  } else if (state is ProfileFailure) {
                    return Center(child: Text(state.error));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              SizedBox(height: 16.h),
              buildMedicalHistorySection(),
              SizedBox(height: 16.h),
              buildUpdateContactButton(context),
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
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: Icon(
            Icons.edit,
            size: 24.sp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditProfilePage()),
            );
          },
        )
      ],
    );
  }

  Widget buildProfileHeader(String? name, String? phone, BuildContext context) {
    return Column(
      children: [
        context.read<ProfileCubit>().image == null
            ? CircleAvatar(
                radius: 50.r,
                backgroundColor: const Color(0xFF6C5DD3),
                child: Icon(
                  Icons.person,
                  size: 50.r,
                  color: Colors.white,
                ),
              )
            : CircleAvatar(
                radius: 50.r,
                backgroundColor: const Color(0xFF6C5DD3),
                backgroundImage:
                    FileImage(File(context.read<ProfileCubit>().image!)),
              ),
        SizedBox(height: 16.h),
        Text(
          name ?? "",
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4A4A58)),
        ),
        SizedBox(height: 8.h),
        Text(
          'Phone: $phone',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget buildPersonalInfoCard(String? age, String? gender) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: const Color(0xFFF3E5F5),
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
                  color: const Color(0xFF6A1B9A)),
            ),
            SizedBox(height: 16.h),
            buildInfoRow('Age', age ?? ""),
            buildInfoRow('Gender', gender ?? ""),
          ],
        ),
      ),
    );
  }

  Widget buildMedicalHistorySection() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: const Color(0xFFE1F5FE),
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
                  color: const Color(0xFF0277BD)),
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

  Widget buildUpdateContactButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          HiveHelper.removeId();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: Text('Sign Out',
            style: TextStyle(fontSize: 16.sp, color: Colors.white)),
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
                  color: const Color(0xFF6A1B9A))),
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
          Icon(Icons.history, color: const Color(0xFF0277BD), size: 24.r),
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
