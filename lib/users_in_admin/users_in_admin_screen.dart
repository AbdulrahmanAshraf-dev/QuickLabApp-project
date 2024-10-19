import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/users_in_admin/cubit/users_in_admin_cubit.dart';

import '../user_profile/profile_model.dart';
import 'user_details_page.dart';

class UsersInAdminScreen extends StatelessWidget {
  const UsersInAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patients',
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),
      body: BlocConsumer<UsersInAdminCubit, UsersInAdminState>(
        listener: (context, state) {
          if (state is UsersInAdminErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UsersInAdminLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.cyan,
              ),
            );
          }
          if (state is UsersInAdminSuccessState) {
            List<ProfileModel> users = context.read<UsersInAdminCubit>().users;
            if(users.isEmpty){
              return Center(
                child: Text(
                  "No users found",
                  style: TextStyle(fontSize: 28.sp),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.all(10.0.dm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserDetailsScreen(user: users[index]),
                              ),
                            );
                          },
                          child: _UserCard(user: users[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final ProfileModel user;

  const _UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0.dm),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                  width: 60.0,
                  height: 60.0,
                  color: Colors.cyan,
                  child: user.image == null || user.image!.isEmpty
                      ? Center(
                          child: Text(
                            (user.name?.isNotEmpty ?? false)
                                ? user.name![0]
                                : " ",
                            style:
                                TextStyle(fontSize: 30.sp, color: Colors.white),
                          ),
                        )
                      : Image.network(
                          user.image!,
                          height: 170.h,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.error),
                            );
                          },
                        )),
            ),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.name ?? "",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  user.phoneNumber ?? "",
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
