import 'package:flutter/material.dart';
import 'package:shoea/view/account/account_screen.dart';
import 'package:shoea/view/cart/cart_screen.dart';
import 'package:shoea/view/home/home_screen.dart';
import 'package:shoea/view/orders/order_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const CartScreen(),
    const OrderScreen(),
    const AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/img/home.png', width: 24, height: 20),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/img/cart.png', width: 24, height: 20),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/img/order.png', width: 24, height: 20),
            label: "Order",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/img/account.png', width: 24, height: 20),
            label: "Account",
          ),
        ],
      ),
    );
  }
}