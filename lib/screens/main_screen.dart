import 'package:flutter/material.dart';
import 'package:studee_app/screens/profile.dart';

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

  final ScrollController _homeController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
            backgroundColor: Color.fromARGB(255, 255, 251, 238),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: '',
            backgroundColor: Color.fromARGB(255, 255, 251, 238),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: '',
            backgroundColor: Color.fromARGB(255, 255, 251, 238),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '',
            backgroundColor: Color.fromARGB(255, 255, 251, 238),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 255, 251, 238),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
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
          child: SafeArea(
            top: true,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: size.width * 0.28,
                  height: size.height * 0.035,
                ),
                if (_selectedIndex == 0) UserImagePicker(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
