import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 25, right: 25),
      child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  RichText(text: const TextSpan(
                    children: [
                      TextSpan(
                        text:"Hello Mr.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ],
                  ))
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
                            offset: Offset(0, 1)
                          )
                        ]
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      shape: BoxShape.circle
                    ),
                  ))
                ],
              )
            ],
          )
      ),
    );
  }
}
