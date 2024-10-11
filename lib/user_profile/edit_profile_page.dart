import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/user_profile/cubit/profile_cubit.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  _buildAppBar(),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileSuccessful) {
            return  Padding(
                  padding: EdgeInsets.all(16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        _buildProfileAvatar(),
                        SizedBox(height: 24.h),
                        _buildProfileForm(
                            state.userData.name,
                            state.userData.phone_number,
                            state.userData.email,
                            context),
                        SizedBox(height: 32.h),
                        _buildSaveButton(context),
                      ],
                    ),
                  ),
                );
          } else if (state is ProfileFailure) {
            return Text(state.error);
          } else {
            return const CircularProgressIndicator();
          }
        },
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
  Widget _buildProfileForm(
      String? name, String? phone, String? email, BuildContext context) {
    return Column(
      children: [
        _buildTextField(Icons.person, 'Name', name,
            context.read<ProfileCubit>().nameEditingController),
        SizedBox(height: 16.h),
        _buildTextField(Icons.phone, 'Phone Number', phone,
            context.read<ProfileCubit>().phoneEditingController),
        SizedBox(height: 16.h),
        _buildTextField(Icons.email, 'Email', email,
            context.read<ProfileCubit>().addressEditingController),
      ],
    );
  }

  // Save Changes button
  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<ProfileCubit>().updateUserProfile();
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C5DD3),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: Text(
          'Save Changes',
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
      ),
    );
  }

  // Helper function to build a reusable text field with icons
  Widget _buildTextField(IconData icon, String? label, String? hint,
      TextEditingController? controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF6C5DD3)),
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
