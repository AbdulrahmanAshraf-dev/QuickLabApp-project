import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/users_in_admin/model/appointment_model.dart';

import '../user_profile/profile_model.dart';
import 'cubit/appointment_details_cubit.dart';

class UserDetailsScreen extends StatelessWidget {
  final ProfileModel user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name} Details'),
        backgroundColor: const Color(0xFF6C5DD3),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.dm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipOval(
                child: Container(
                  width: 120.r, // Diameter (2 * radius)
                  height: 120.r,
                  color: const Color(0xFF6C5DD3),
                  child: user.image == null || user.image!.isEmpty
                      ? Center(
                    child: Text(
                      (user.name?.isNotEmpty ?? false)
                          ? user.name![0]
                          : " ",
                      style:
                      TextStyle(fontSize: 65.sp, color: Colors.white),
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
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              user.name ?? "",
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF6C5DD3),
              ),
            ),
            SizedBox(height: 10.h),
            const Divider(),
            SizedBox(height: 10.h),
            _buildDetailRow(Icons.calendar_today, 'Age:', user.age ?? ''),
            _buildDetailRow(Icons.male, 'Gender:', user.gender ?? ''),
            _buildDetailRow(Icons.phone, 'Phone:', user.phoneNumber ?? ''),
            _buildDetailRow(Icons.email, 'Email:', user.email ?? ''),
            _buildXrayRequests(context, user.id!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6C5DD3), size: 24.r),
          SizedBox(width: 10.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  value,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 18.sp, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXrayRequests(BuildContext context, String userID) {
    context.read<AppointmentDetailsCubit>().getAppointmentDetails(userID);

    return BlocBuilder<AppointmentDetailsCubit, AppointmentDetailsState>(
  builder: (context, state) {
    if(state is AppointmentDetailsErrorState)
    {
      return Center(
        child: Text(
          "No appointments available.",
          style: TextStyle(
              fontSize: 16.sp, color: Colors.black),
        ),
      );
    }
    if(state is AppointmentDetailsSuccessState)
    {
     List<AppointmentModel> xrayRequests = state.appointments;
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appointments:',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 10.h),
                xrayRequests.isEmpty
                    ? Center(
                        child: Text(
                          "No appointments available.",
                          style: TextStyle(
                              fontSize: 16.sp, color: Colors.grey[600]),
                        ),
                      )
                    : SizedBox(
                        height: 400.h, // Set a height for ListView
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: xrayRequests.length,
                          itemBuilder: (context, index) {
                            final xray = xrayRequests[index];

                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.medical_services,
                                            color: const Color(0xFF6C5DD3), size: 24.r),
                                        SizedBox(width: 10.w),
                                        Text(
                                          'Appointment ${index + 1}',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),

                                    // Displaying all product names
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: xray.products.map((productFuture) {
                                        return FutureBuilder<Product>(
                                          future: productFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return const Text('Loading product name...');
                                            } else if (snapshot.hasError) {
                                              return const Text('Error loading product name');
                                            } else if (snapshot.hasData) {
                                              final product = snapshot.data!;
                                              return Text(
                                                'Name: ${product.name}',
                                                style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                                              );
                                            } else {
                                              return const Text('No product found');
                                            }
                                          },
                                        );
                                      }).toList(),
                                    ),

                                    SizedBox(height: 5.h),
                                    Text(
                                      'In Home: ${xray.isInHome ? "Yes" : "No"}',
                                      style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      'Is Cash: ${xray.isCash ? "Yes" : "No"}',
                                      style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      'Date: ${xray.date.toString()}',
                                      style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
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
);
  }


}
