import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicklab/home/cubit/cart/cart_cubit.dart';
import 'cart_item_samples.dart';
import 'cart_nav_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is GetCartSuccessful) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.5,
                centerTitle: true,
                title: const Text(
                  "Cart",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
              body: ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEDECF2),
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                      ),
                      child: Column(
                        children: [
                          CartItemSamples(
                            data: state.data[index],
                            onTap: () {
                              context
                                  .read<CartCubit>()
                                  .removeFromCart(state.data[index].id!);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              bottomNavigationBar: CartNavBar(
                total: state.total,
              ));
        } else if (state is GetCartFailure) {
          return Center(
            child: Text(state.error),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
