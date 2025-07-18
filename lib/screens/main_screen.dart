import 'package:flutter/material.dart';
import 'package:studee_app/data/universityData.dart';
import 'package:studee_app/screens/favorites_screen.dart';
import 'package:studee_app/screens/profile.dart';
import 'package:studee_app/screens/profileData.dart';
import 'package:studee_app/screens/searchPage.dart';
import 'package:studee_app/screens/universityCarousel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isProfile = false;

  final ScrollController _homeController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '',
            backgroundColor: Color.fromARGB(255, 255, 251, 238),
          ),

          BottomNavigationBarItem(
            activeIcon: Icon(Icons.search_outlined),
            icon: Icon(Icons.search_off_rounded),
            label: '',
            backgroundColor: Color.fromARGB(255, 255, 251, 238),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(Icons.bookmark),
            label: '',
            backgroundColor: Color.fromARGB(255, 255, 251, 238),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '',
            backgroundColor: Color.fromARGB(255, 255, 251, 238),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 255, 251, 238),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,

        onTap: (int index) {
          switch (index) {
            case 0:
              // only scroll to top when current index is selected.
              if (_selectedIndex == index) {
                _homeController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastEaseInToSlowEaseOut,
                );
              }
            case 1:
          }
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 255, 251, 238)),
        child: Center(
          child: Column(
            children: [
              if (_selectedIndex != 3)
                SafeArea(
                  top: true,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: size.width * 0.28,
                    height: size.height * 0.035,
                  ),
                ),

              if (_selectedIndex == 3)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(150),
                          bottomRight: Radius.circular(150),
                        ),
                      ),
                    ),
                    SafeArea(
                      top: true,
                      child: Center(
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: size.width * 0.28,
                          height: size.height * 0.035,
                        ),
                      ),
                    ),
                    UserImagePicker(),
                  ],
                ),
              if (_selectedIndex == 3) const SizedBox(height: 90),

              if (_selectedIndex == 3) ProfileData(),
              if (_selectedIndex == 1) SearchPage(),
              if (_selectedIndex == 2) FavoritesScreen(favorites: []),
              if (_selectedIndex == 0) SizedBox(height: size.height * 0.25),
              if (_selectedIndex == 0)
                Text(
                  "Because you searched for United Kingdom",
                  style: TextStyle(color: Colors.black),
                ),
              if (_selectedIndex == 0) UniversityCarousel(universities: uni),
            ],
          ),
        ),
      ),
    );
  }
}
