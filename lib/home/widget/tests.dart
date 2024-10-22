import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/home/cubit/tests/tests_cubit.dart';
import 'package:quicklab/home/widget/packages_item.dart';

import '../../vertical_products/vertical_products_screen.dart';
import '../models/products_data.dart';
import 'packages.dart';

class Tests extends StatefulWidget {
  const Tests({super.key});

  @override
  State<Tests> createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  List<ProductsData> items = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PackagesList("Tests", onTap: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        VerticalProductsScreen(items: items, title: "Scans")));

        },),
        SizedBox(height: 250.h,
          child: BlocConsumer<TestsCubit, TestsState>(
            listener: (context, state) {
              if (state is TestsErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is TestsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is TestsSuccessState) {
                items = context
                    .read<TestsCubit>()
                    .testsList;
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(width: 10.w),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  itemBuilder: (context, index) {
                    return PackagesItem(items[index], inBookmark: false,);
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        )
      ],
    );
  }
}
