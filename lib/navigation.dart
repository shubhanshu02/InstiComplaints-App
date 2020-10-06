import 'package:InstiComplaints/Compose.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'st_profile.dart';
import 'package:InstiComplaints/feedPage.dart';
import 'package:InstiComplaints/notifications.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  final List<Widget> children = [Feed(), Notifications(), Profile(), Compose()];
  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: children[currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Color(0xFF181d3d),
          buttonBackgroundColor: Color(0xFFF49F1C),
          height: 60,
          animationDuration: Duration(
            milliseconds: 200,
          ),
          animationCurve: Curves.bounceInOut,
          items: <Widget>[
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.notifications,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
          ],
          onTap: onTapped,
          index: currentIndex,
        ));
  }
}
