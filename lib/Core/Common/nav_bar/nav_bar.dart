import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Features/AddToCartScreen/Screen/add_to_cart_screen.dart';
import '../../../Features/ProductScreen/Screens/product_screen.dart';
import '../Components/components.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int screeIndex = 0;
  List<Widget> screens = [
    ProductScreen(),
    AddToCartScreen(),
  ];
  List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      activeIcon: Icon(
        Icons.home,
        color: Colors.orange,
      ),
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_cart_checkout,
        ),
        label: 'Cart',
        activeIcon: Icon(
          Icons.shopping_cart,
          color: Colors.orange,
        )),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        title: logo,
        actions: [
          IconButton(
            onPressed: () {
              // navigateTo(context, SearchScreen());
            },
            icon: Icon(
              CupertinoIcons.search,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: screens[screeIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 12.8,
          child: BottomNavigationBar(
            onTap: (index) {
              screeIndex = index;
              setState(() {});
              // cubit.changeNavIndex(index);
            },
            unselectedFontSize: 11.0,
            selectedFontSize: 12.0,
            currentIndex: screeIndex,
            items: navItems,
            iconSize: MediaQuery.of(context).size.height / 30.0,
          ),
        ),
      ),
    );
  }
}
