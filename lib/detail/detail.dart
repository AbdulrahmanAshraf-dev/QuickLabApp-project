import 'package:flutter/material.dart';
import 'package:quicklab/home/models/products_data.dart';



class DetailPage extends StatelessWidget {

  double screenWidth=0;
  double screenHeight=0;

  bool isExpanded=false;

  void expandButton(){
    setState((){
      isExpanded =!isExpanded;
    });
  }

  DetailPage(ProductsData items);

  @override
  Widget build(BuildContext context) {

    screenWidth= MediaQuery.of(context).size.width;
    screenHeight= MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
            child: SizedBox(
            height: screenHeight / 2.5,
            width: screenWidth,
            child: Image.asset("assets/images/zw.png",
            fit: BoxFit.cover
            ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: screenWidth / 20,
            ),
            child: Text(
              "test",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: screenWidth / 20,
            ),
            child: Text(
              "describtion",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 100,),
          Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 80,
                width: isExpanded? 250:100,
            decoration: BoxDecoration(
                color: isExpanded? Colors.green : Colors.blue,
              borderRadius: BorderRadius.circular( isExpanded ? 50 : 10),
            ),
            child: isExpanded ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check,color: Colors.white,),
                SizedBox(width: 10,),
                Text(
                  "Booked",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                  ),
                ),
              ],
            ) :
            Icon(Icons.add_shopping_cart,color: Colors.white,),
          )

          )
        ],
      ),
    );
  }
}
