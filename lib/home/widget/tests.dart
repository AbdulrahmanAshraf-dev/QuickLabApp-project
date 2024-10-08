import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'packages.dart';

class Tests extends StatelessWidget {
  const Tests({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PackagesList("Tests"),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset("assets/images/zw.png",
                      width: 80
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CPK - Total",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("cardiac enzyme, requested when feeling\nchest pain"),
                        Text("260 EGP",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.cyan),),

                      ],
                    ),
                  ],
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle
                      ),
                      child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 15,
                      ),
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
