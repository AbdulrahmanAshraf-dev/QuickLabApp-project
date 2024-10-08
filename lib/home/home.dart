import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../recent_page/recent_screen.dart';
import '../user_profile/profile.dart';
import 'widget/custom_app_bar.dart';
import 'widget/package_details.dart';
import 'widget/search_input.dart';
import 'widget/tests.dart';


class HomePage extends StatefulWidget {


   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            SearchInput(),
            PackageDetails(),
            Tests(),
          ],
        ),
      ),
    );
  }
}
