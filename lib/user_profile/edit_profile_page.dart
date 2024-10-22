import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quicklab/user_profile/cubit/profile_cubit.dart';
import 'package:quicklab/user_profile/profile_model.dart';

import 'edit_profile_cubit/edit_profile_cubit.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileSuccessful) {
              return Padding(
                padding: EdgeInsets.all(16.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 16.h),
                      _buildProfileAvatar(state.userData.image),
                      SizedBox(height: 24.h),
                      _buildProfileForm(
                          state.userData.name,
                          state.userData.phoneNumber,
                          state.userData.email,
                          context),
                      SizedBox(height: 16.h),
                      _buildMaleOrFemale(),
                      SizedBox(height: 16.h),
                      _buildSelectedAge(),
                      SizedBox(height: 32.h),
                      _buildSaveButton(context),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileFailure) {
              return Center(child: Text(state.error));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  // AppBar with title
  AppBar _buildAppBar() {
    return AppBar(centerTitle: true,
      title: Text(
        'Edit Profile',
        style: TextStyle(
          fontSize: 24.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  // Profile avatar
  Widget _buildProfileAvatar(String? image) {
    return Center(
      child: GestureDetector(
        onTap: () {
          ImagePicker()
              .pickImage(source: ImageSource.gallery)
              .then((v) {
            context.read<ProfileCubit>().image=v?.path;
              });
        },
        child: image == null
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
                backgroundImage: FileImage(File(image)),
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
      ],
    );
  }

  DropdownButton<String> _buildSelectedAge() {
    return DropdownButton<String>(
      hint: const Text('Select Age'),
      value: context.read<ProfileCubit>().age,
      items: List.generate(100, (index) => (index + 1).toString())
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          context.read<ProfileCubit>().age = newValue!;
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
            activeColor: Colors.cyan,
            value: 'Male',
            groupValue: context.read<ProfileCubit>().gender,
            onChanged: (String? value) {
              setState(() {
                context.read<ProfileCubit>().gender = value!;
              });
            },
          ),
        ),
      ),
      Expanded(
        child: ListTile(
          title: const Text('Female'),
          leading: Radio<String>(
            activeColor: Colors.cyan,
            value: 'Female',
            groupValue: context.read<ProfileCubit>().gender,
            onChanged: (String? value) {
              setState(() {
                context.read<ProfileCubit>().gender = value!;
              });
            },
          ),
        ),
      ),
    ]);
  }

  // Save Changes button
  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<EditProfileCubit>().updateUserProfile(
              ProfileModel(
                image: context.read<ProfileCubit>().image,
                name: context.read<ProfileCubit>().nameEditingController.text,
                phoneNumber:
                    context.read<ProfileCubit>().phoneEditingController.text,
              ),
              context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan,
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
        prefixIcon: Icon(icon, color:Colors.cyan),
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
