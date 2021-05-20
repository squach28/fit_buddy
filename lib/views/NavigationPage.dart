import 'package:fit_buddy/views/HomePage.dart';
import 'package:fit_buddy/views/ProfilePage.dart';
import 'package:flutter/material.dart';


class NavigationPage extends StatefulWidget {
  @override 
  NavigationPageState createState() => NavigationPageState();
}

class NavigationPageState extends State<NavigationPage> {

  int selectedIndex = 0;

  final pages = [HomePage(), HomePage(), ProfilePage() ];

  void _onTabTapped(int index) {
    setState(() {
      this.selectedIndex = index;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
                    BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
                    BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          ),
        ],
        currentIndex: this.selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}