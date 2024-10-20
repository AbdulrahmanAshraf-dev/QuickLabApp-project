import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../user_profile/profile_model.dart';

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

            _buildXrayRequests(),
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

  Widget _buildXrayRequests() {
    final List<String> xrayRequests = [
      'Chest X-ray',
      'Abdominal X-ray',
      'Knee X-ray',
    ];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.medical_services,
              color: const Color(0xFF6C5DD3), size: 24.r),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'X-rays Requested:',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 5.h),
                ...xrayRequests.map((xray) => Text(
                      xray,
                      style:
                          TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
