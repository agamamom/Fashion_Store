import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_fashion_store/views/buyers/nav_screens/accout_screen.dart';
import 'package:multi_fashion_store/views/buyers/nav_screens/cart_screen.dart';
import 'package:multi_fashion_store/views/buyers/nav_screens/category_screen.dart';
import 'package:multi_fashion_store/views/buyers/nav_screens/home_screen.dart';
import 'package:multi_fashion_store/views/buyers/nav_screens/search_screen.dart';
import 'package:multi_fashion_store/views/buyers/nav_screens/store_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    int pageIndex = 0;

    List<Widget> pages = [
      const HomeScreen(),
      const CategoryScreen(),
      const StoreScreen(),
      const CartScreen(),
      const SearchScreen(),
      const AccountScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.yellow.shade900,
          currentIndex: pageIndex,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/explore.svg',
                width: 20,
              ),
              label: 'CATEGORIES',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/shop.svg',
                width: 20,
              ),
              label: 'STORE',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/cart.svg'),
              label: 'CART',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/search.svg'),
              label: 'SEARCH',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/account.svg'),
              label: 'ACCOUNT',
            ),
          ]),
      body: pages[pageIndex],
    );
  }
}
