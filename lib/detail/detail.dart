import 'package:flutter/material.dart';
import 'package:quicklab/home/models/products_data.dart';



class DetailPage extends StatelessWidget {
  final ProductsData items;
  DetailPage(this.items);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("details")
          ],
        ),
      ),
    );
  }
}
