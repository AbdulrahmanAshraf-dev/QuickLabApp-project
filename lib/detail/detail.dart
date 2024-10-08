import 'package:flutter/material.dart';

import '../models/items.dart';


class DetailPage extends StatelessWidget {
  final Items items;
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
