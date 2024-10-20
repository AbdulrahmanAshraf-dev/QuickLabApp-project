import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/bookmark/cubit/get_bookmark_cubit.dart';
import 'package:quicklab/home/models/products_data.dart';

import '../home/widget/packages_item.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  Future<void> _refreshBookmarks(BuildContext context) async {
    context.read<GetBookmarkCubit>().getBookmark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Bookmark",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: BlocConsumer<GetBookmarkCubit, GetBookmarkState>(
          listener: (context, state) {
            if (state is GetBookmarkErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () => _refreshBookmarks(context),
              child: Builder(
                builder: (context) {
                  if (state is GetBookmarkLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.cyan),
                    );
                  }

                  if (state is GetBookmarkErrorState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Error loading bookmarks"),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    );
                  }

                  if (state is GetBookmarkSuccessState) {
                    List<ProductsData> bookmarkedProducts =
                        context.read<GetBookmarkCubit>().bookmarkList;

                    if (bookmarkedProducts.isEmpty) {
                      // Wrap in SingleChildScrollView for empty list
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 100.h),
                            child:  Text("No bookmarked products", style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold)),
                          ),
                        ),
                      );
                    } else {
                      return ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(width: 10.w),
                        itemCount: bookmarkedProducts.length,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        itemBuilder: (context, index) {
                          return PackagesItem(
                            bookmarkedProducts[index],
                            inBookmark: true,
                          );
                        },
                      );
                    }
                  }

                  return const SizedBox.shrink(); // For any other unexpected states
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
