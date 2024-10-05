import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicklab/homeTap/home_tap.dart';
import 'package:quicklab/recent_page/recent_screen.dart';
import 'package:quicklab/user_profile/profile.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   late int index = 0 ;

  final List<Widget>pages =[
    const HomeTap(),
    const RecentScreen(),
    const PatientProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[index] ,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: FlashyTabBar(
          backgroundColor:  Color(0xFF6C5DD3),
          selectedIndex: index,
          showElevation: true,
          onItemSelected: (i) => setState(() {
            index = i;
          }),
          items: [
            FlashyTabBarItem(
                activeColor: Colors.white,
                title: const Center(
                  child: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                icon: const Icon(Icons.home,size: 35,color: Colors.white,)),
            FlashyTabBarItem(
                activeColor: Colors.white,
                title: const Center(
                    child: Text('Recent')),
                icon:const Icon(CupertinoIcons.clock,size: 35,color: Colors.white,)),
            FlashyTabBarItem(
                activeColor: Colors.white,
                title: const Center(
                    child: Text('Profile')),
                icon: const Icon(CupertinoIcons.profile_circled,size: 35,color: Colors.white,)),
          ],
        ),
      ),
    );
  }
}
