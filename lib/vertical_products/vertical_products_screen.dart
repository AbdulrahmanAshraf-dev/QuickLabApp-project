import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/home/models/products_data.dart';
import 'package:quicklab/home/widget/packages_item.dart';

class VerticalProductsScreen extends StatelessWidget {
  const VerticalProductsScreen(
      {super.key, required this.items, required this.title});

  final String title;
  final List<ProductsData> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          title,
          style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(itemCount: items.length,
    itemBuilder: (BuildContext context, int index) {
        return PackagesItem(items[index], inBookmark: false,);
    },

    ),
    );
  }
}
