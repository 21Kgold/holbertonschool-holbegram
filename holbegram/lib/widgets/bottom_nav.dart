import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'package:holbegram/screens/Pages/add_image.dart';
import 'package:holbegram/screens/Pages/favorite.dart';
import 'package:holbegram/screens/Pages/feed.dart';
import 'package:holbegram/screens/Pages/profile_screen.dart';
import 'package:holbegram/screens/Pages/search.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _currentIndex,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          Feed(),
          Search(),
          AddImage(),
          Favorite(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 600),
              curve: Curves.ease,
            );
          });
        },
        items: [
          barItem(icon: Icons.home, text: "Home"),
          barItem(icon: Icons.search, text: "Search"),
          barItem(icon: Icons.add_photo_alternate, text: "Add"),
          barItem(icon: Icons.favorite, text: "Favorite"),
          barItem(icon: Icons.person, text: "Profile"),
        ],
      ),
    );
  }
}

BottomNavyBarItem barItem({
  required String text,
  required IconData icon,
}) {
  return BottomNavyBarItem(
    icon: Icon(icon),
    title: Text(
      text,
      style: const TextStyle(
        fontSize: 25,
        fontFamily: "Billabong",
      ),
    ),
    activeColor: Colors.red,
    textAlign: TextAlign.center,
    inactiveColor: Colors.black,
  );
}