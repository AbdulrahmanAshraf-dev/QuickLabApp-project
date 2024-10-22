import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/home/cubit/scans/scans_cubit.dart';
import 'package:quicklab/home/models/products_data.dart';
import 'package:quicklab/vertical_products/vertical_products_screen.dart';

import 'packages.dart';
import 'packages_item.dart';

class PackageDetails extends StatefulWidget {
   const PackageDetails({super.key});

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  List<ProductsData>items=[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PackagesList(
          "Scan",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        VerticalProductsScreen(items: items, title: "Scans")));
          },
        ),
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
              items = context.read<ScansCubit>().scansList;
              return SizedBox(
                height: 250.h,
                child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => PackagesItem(
                          items[index],
                          inBookmark: false,
                        ),
                    separatorBuilder: (context, index) => SizedBox(width: 10.w),
                    itemCount: items.length),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
