// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:nftgallery/Components/AppBar.dart';
import 'package:nftgallery/Screens/HomePage/homePage.dart';
import 'package:nftgallery/Screens/MarketPlace/marketPlace.dart';
import 'package:nftgallery/Screens/ProfilePage/profilePage.dart';

class navBar extends StatefulWidget {
  const navBar({Key? key}) : super(key: key);

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 1);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 1);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const homePage(),
    const profilePage(),
    const marketPlace(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color.fromRGBO(21, 21, 21, 100),
      backgroundColor: Color.fromRGBO(6, 3, 34, 0.612),
      appBar: appBar(),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: Colors.black,
              showLabel: true,
              notchColor: Colors.black87,
              removeMargins: false,
              bottomBarWidth: 200,
              durationInMilliSeconds: 300,
              bottomBarItems: [
                bottonBarItems('Home', Icons.home_filled),
                bottonBarItems('Profile', Icons.person),
                bottonBarItems('Market', Icons.shopping_bag),
              ],
              onTap: (index) {
                print('current selected index $index');
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }

  BottomBarItem bottonBarItems(String item, IconData icon) {
    return BottomBarItem(
      inActiveItem: Icon(
        icon,
        color: Colors.grey,
      ),
      activeItem: Icon(
        icon,
        color: Colors.blueAccent,
      ),
      itemLabel: item,
    );
  }
}
