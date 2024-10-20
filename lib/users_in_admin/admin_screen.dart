import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicklab/users_in_admin/cubit/users_in_admin_cubit.dart';
import 'package:quicklab/users_in_admin/users_in_admin_screen.dart';

import '../chat/admin.dart';
import '../products_in_admin/cubit/products_in_admin_cubit.dart';
import '../products_in_admin/products_in_admin_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  var _page = 0;

  final _pages = [
    const UsersInAdminScreen(),
    const ProductsInAdminScreen(),
    const AdminChatRoomsScreen(),
  ];

  final List<Widget> _navigationItem = [
    const Icon(Icons.person),
    const Icon(Icons.library_books),
    const Icon(Icons.chat),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          UsersInAdminCubit()
            ..getUsers(),
        ),
        BlocProvider(
          create: (context) => ProductsInAdminCubit()..getProducts(),
        ),
      ],
      child: Scaffold(
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
      ),
    );
  }
}
