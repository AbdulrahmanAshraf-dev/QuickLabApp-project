import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/home/widget/banners.dart';
import 'package:quicklab/home/widget/tests.dart';
import 'widget/custom_app_bar.dart';
import 'widget/package_details.dart';
import 'widget/search_input.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(),
            SearchInput(),
            const PackageDetails(),
            const Banners(),
            const Tests(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
