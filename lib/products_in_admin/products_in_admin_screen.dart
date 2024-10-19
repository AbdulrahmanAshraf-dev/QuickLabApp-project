import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/home/models/products_data.dart';
import 'package:quicklab/products_in_admin/cubit/products_in_admin_cubit.dart';

class ProductsInAdminScreen extends StatelessWidget {
  const ProductsInAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),
      body: BlocConsumer<ProductsInAdminCubit, ProductsInAdminState>(
        listener: (context, state) {
          if (state is ProductsInAdminErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProductsInAdminLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.cyan,
              ),
            );
          }
          if (state is ProductsInAdminSuccessState) {
            List<ProductsData> products =
                context.read<ProductsInAdminCubit>().products;
            if (products.isEmpty) {
              return Center(
                child: Text(
                  "No products found",
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
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ProductDetailsPage(
                            //       product: products[index],
                            //     ),
                            //   ),
                            // );
                          },
                          child: _ProductCard(product: products[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductsData product;

  const _ProductCard({required this.product});

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
              child: SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: product.image == null || product.image!.isEmpty
                      ? Center(
                          child: Text(
                            (product.name?.isNotEmpty ?? false)
                                ? product.name![0]
                                : " ",
                            style:
                                TextStyle(fontSize: 30.sp, color: Colors.white),
                          ),
                        )
                      : Image.network(
                          product.image!,
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
            Text(
              product.name ?? "",
              style:
                  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
