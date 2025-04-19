import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/nav_screens/account_screen.dart';
import 'package:flutter_application_1/views/screens/nav_screens/cart_screen.dart';
import 'package:flutter_application_1/views/screens/nav_screens/favorite_screen.dart';
import 'package:flutter_application_1/views/screens/nav_screens/home_screen.dart';
import 'package:flutter_application_1/views/screens/nav_screens/store_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    FavoriteScreen(),
    StoreScreen(),
    AccountScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 5, 22, 36),
        unselectedItemColor: const Color.fromARGB(255, 52, 173, 15),
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/home.png", width: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/love.png", width: 30),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/mart.png", width: 30),
            label: "Stores",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/cart.png", width: 30),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/user.png", width: 30),
            label: "Account",
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
