import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/home/cubit/scans/scans_cubit.dart';

import 'packages.dart';
import 'packages_item.dart';

class PackageDetails extends StatelessWidget {
  const PackageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PackagesList("Scan"),
        BlocConsumer<ScansCubit, ScansState>(
          listener: (context, state) {
            if (state is ScansErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ScansLoadingState) {
              return Center(
                child: SizedBox(
                    height: 250.h,
                    child: const Center(child: CircularProgressIndicator())),
              );
            }
            if (state is ScansSuccessState) {
              final scans = context.read<ScansCubit>().scansList;
              return SizedBox(
                height: 250.h,
                child: ListView.separated(
                    padding:  EdgeInsets.symmetric(horizontal: 15.w),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => PackagesItem(scans[index], inBookmark: false,),
                    separatorBuilder: (context, index) =>
                        SizedBox(width: 10.w),
                    itemCount: scans.length),
              );
            }
            return const SizedBox.shrink();
          },
        ),SizedBox(height: 10.h),
      ],
    );
  }
}
