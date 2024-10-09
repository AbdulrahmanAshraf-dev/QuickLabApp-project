import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/home/cubit/tests/tests_cubit.dart';
import 'package:quicklab/home/widget/packages_item.dart';

import 'packages.dart';

class Tests extends StatelessWidget {
  const Tests({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PackagesList("Tests"),
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
                final tests = context.read<TestsCubit>().testsList;
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(width: 10.w),
                  itemCount: tests.length,
                  scrollDirection: Axis.horizontal,
                  padding:  EdgeInsets.symmetric(horizontal: 15.w),
                  itemBuilder: (context, index) {
                    return PackagesItem(tests[index], inBookmark: false,);
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
