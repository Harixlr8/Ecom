import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:test_zybo/layers/home/screen/home/home.dart';
import 'package:test_zybo/layers/home/screen/profile/profile.dart';
import 'package:test_zybo/layers/home/screen/wishlist/wishlist.dart';

import '../../../data/bloc/bloc_wishlist/wishlist_bloc.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.index == 1) {
        wishlistBloc.add(WishlistFetchEvent());
      }
    });
  }

  List<Widget> _screens() {
    return [
      HomeScreen(),
      WishlistScreen(wishlistBloc: wishlistBloc,),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorSecondary: Colors.white,
        activeColorPrimary: Colors.deepPurple, // Set selected color
        inactiveColorPrimary: Colors.grey, // Set unselected color
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite),
        title: "Wishlist",
        activeColorSecondary: Colors.white,
        activeColorPrimary: Colors.deepPurple,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "Profile",
        activeColorSecondary: Colors.white,
        activeColorPrimary: Colors.deepPurple,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style7,
    );
  }
}
