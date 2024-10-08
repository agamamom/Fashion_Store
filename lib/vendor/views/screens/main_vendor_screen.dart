import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_fashion_store/vendor/views/screens/earnings_screen.dart';
import 'package:multi_fashion_store/vendor/views/screens/edit_product_screen.dart';
import 'package:multi_fashion_store/vendor/views/screens/upload_screen.dart';
import 'package:multi_fashion_store/vendor/views/screens/vendor_logout_screen.dart';
import 'package:multi_fashion_store/vendor/views/screens/vendor_order_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const EarningsScreen(),
      UploadScreen(),
      const EditProductScreen(),
      VendorOrderScreen(),
      VendorLogoutScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.yellow.shade900,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.money_dollar), label: 'Earnings'),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'UPLOAD'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'EDIT'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart), label: 'ORDERS'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'LOGOUT'),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}
