import 'package:flutter/material.dart';
import '../../models/items.dart';
import 'packages.dart';
import 'packages_item.dart';
class PackageDetails extends StatelessWidget {
final PackagesLs=Items.generateItems();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PackagesList("Packages"),
          Container(
            height: 280,
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 25),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => PackagesItem(PackagesLs[index]),
                separatorBuilder: (_, index) => SizedBox(width: 10),
                itemCount: PackagesLs.length),
          ),
        ],
      ),
    );
  }
}
