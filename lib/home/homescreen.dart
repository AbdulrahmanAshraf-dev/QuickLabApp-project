import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicklab/chat/chat_screen.dart';

import '../bookmark/bookmark_screen.dart';
import '../recent_page/recent_screen.dart';
import '../user_profile/cubit/profile_cubit.dart';
import '../user_profile/profile.dart';
import 'home.dart';
import 'models/products_data.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var _page = 0;

  final _pages = [
    const HomePage(),
    const RecentScreen(),
    const BookmarkScreen(),
    const ChatScreen(),
    const PatientProfilePage()
  ];

  final List<Widget> _navigationItem = [
    const Icon(Icons.home),
    const Icon(Icons.library_books_rounded),
    const Icon(Icons.bookmark),
    const Icon(Icons.chat),
    const Icon(Icons.person)
  ];

  @override
  void initState() {
    context.read<ProfileCubit>().fetchUserProfile();
     ProductsData.setBookmarkedProducts();
      ProductsData.setInCartProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 50.0,
        color: Colors.cyan,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        items: _navigationItem,
      ),
    );
  }
}
