import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicklab/user_profile/cubit/profile_cubit.dart';

import 'cart_page.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 25, right: 25),
      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
      Row(
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileSuccessful) {
                return Text("Hello, ${state.userData.name}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold));
              }
              return const Text("Hello, ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold));
            },
          )
        ],
      ),
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.1,
                        blurRadius: 0.1,
                        offset: const Offset(0, 1))
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){
                            return CartPage();
                      }
                      ),
                    ), icon: Icon(Icons.shopping_cart),
                ),
              ),
            ),
          ),
          Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                    color: Colors.cyan, shape: BoxShape.circle),
              ))
        ],
      )
              ],
            ),
    );
  }
}
