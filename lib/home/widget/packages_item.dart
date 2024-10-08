import 'package:flutter/material.dart';
import '../../detail/detail.dart';
import '../../models/items.dart';
class PackagesItem extends StatelessWidget {
  final Items items;
  const PackagesItem(this.items);
@override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => DetailPage(items)));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    height: 170,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(items.imageUrl),
                        fit: BoxFit.fitHeight
                      )
                    ),
                  ),
                  Positioned(
                      right: 20,
                      top: 15,
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
                      ))
                ],
              ),
              Text(items.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 1.5
              ),),
              Text(items.price,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: Colors.cyan
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
