import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/home/cubit/cart/cart_cubit.dart';
import 'package:quicklab/home/models/products_data.dart';

import '../../checkout/checkout.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  static int total = 0;

  Future<void> _refreshCart(BuildContext context) async {
    context.read<CartCubit>().getCartItems();
  }

  void _calculateTotal(List<ProductsData> cartItems) {
    total = cartItems.fold(0, (sum, item) => sum + (item.price?.toInt() ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartSuccessState) {
            // Recalculate total whenever CartSuccessState is emitted
            final List<ProductsData> cartItems =
                context.read<CartCubit>().items;
            _calculateTotal(cartItems);
            setState(() {});
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => _refreshCart(context),
            child: Builder(
              builder: (context) {
                if (state is CartLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CartErrorState) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 100.h),
                        child: Text(
                          "No items in cart",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                if (state is CartSuccessState) {
                  final List<ProductsData> cartItems =
                      context.read<CartCubit>().items;

                  if (cartItems.isEmpty) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 100.h),
                          child: Text(
                            "No items in cart",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.sp,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 110.h,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
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
                                    cartItems[index].image!,
                                    height: 170.h,
                                    fit: BoxFit.fitHeight,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 200.w,
                                        child: Text(
                                          cartItems[index].name!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${cartItems[index].price}\$",
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.cyan,
                                        ),
                                        onPressed: () {
                                          CartCubit().removeFromCart(
                                            cartItems[index].id!,
                                            cartItems[index].isTest!,
                                            cartItems[index].price!.toInt(),
                                            context,
                                          );
                                          total -=
                                              cartItems[index].price!.toInt();
                                          setState(() {});
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
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          height: 160,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${total.toString()}\$",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                              total: total,
                            )),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "Checkout",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
