import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/home/models/products_data.dart';

import '../cubit/cart/cart_cubit.dart';

class CartItemSamples extends StatelessWidget {
  const CartItemSamples({super.key, required this.product});

  final ProductsData product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 110.h,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          padding: EdgeInsets.all(10.dm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                height: 70.h,
                width: 70.w,
                margin: EdgeInsets.only(right: 15.w),
                child: Image.network(
                  product.image!,
                  height: 170.h,
                  fit: BoxFit.fitHeight,
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name!,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${product.price}\$",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.w),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.cyan,
                      ),
                      onPressed: () {
                        CartCubit().removeFromCart(
                          product.id!,
                          product.isTest!,
                          product.price!.toInt(),
                          context,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
