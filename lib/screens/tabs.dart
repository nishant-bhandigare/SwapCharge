import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:battery/screens/history.dart';
import 'package:battery/screens/home.dart';
import 'package:battery/screens/live_map.dart';
import 'package:battery/screens/profile.dart';
import 'package:battery/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({super.key, required this.userData});

  Map<String, dynamic> userData;

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<String> _screenNames = ["Dashboard", "Maps", "History", "Profile"];
  final List<Widget> _pages = [const HomeScreen(), const LiveMapScreen(), const HistoryScreen(), ProfileScreen()];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screenNames[_selectedPageIndex]),
        backgroundColor: Color.fromRGBO(124, 198, 252, 1.0),
        actions: [
          IconButton(
            onPressed: () {
              // Handle notification button action
            },
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      drawer: MainDrawer(
        username: '',
        email: '',
      ),

      body: SafeArea(
        child: _pages[_selectedPageIndex],
      ),

      bottomNavigationBar: CurvedNavigationBar(
        onTap: _selectPage,
        height: 50,
        // color: Colors.black26,
        // color: Color.fromRGBO(124, 198, 252, 1.0),
        color: Color.fromRGBO(142, 143, 253, 1),
        backgroundColor: Colors.transparent,
        // buttonBackgroundColor: Color.fromRGBO(106, 166, 255, 1.0),
        buttonBackgroundColor: Color.fromRGBO(119, 82, 254, 1.0),
        items: [
          Image.asset(
            "assets/icons/home.png",
            width: 25,
          ),
          Image.asset(
            "assets/icons/map.png",
            width: 25,
          ),
          Image.asset(
            "assets/icons/history.png",
            width: 25,
          ),
          Image.asset(
            "assets/icons/account.png",
            width: 25,
          ),
        ],
      ),
    );
  }
}
