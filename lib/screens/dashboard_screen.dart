import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/buttom_nav_screen/account_screen.dart';
import 'package:hamro_bhagaicha_batch35d/screens/buttom_nav_screen/cart_screen.dart';
import 'package:hamro_bhagaicha_batch35d/screens/buttom_nav_screen/home_screen.dart';
import 'package:hamro_bhagaicha_batch35d/screens/buttom_nav_screen/order_screen.dart';
import 'package:hamro_bhagaicha_batch35d/screens/buttom_nav_screen/scan_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int _selectedIndex = 0;

  List<Widget>lstBottomScreen = [
    const DashboardHomeScreen(),
    const OrderScreen(),
    const ScanScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        
        type: BottomNavigationBarType.fixed,
        items: const [
          
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory),label: 'Order'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner, ),label: 'Scanner'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Account'),
        ],
        
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        ),
    );
  }
}