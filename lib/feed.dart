import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,

        color: Color(0xFF181d3d),

        buttonBackgroundColor: Color(0xFFF49F1C),
        height: 60,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        index: 2, //.. default start position for icon
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
        ],

        onTap: (index) {
          //..tap icon to navigate...
        },
      ),
    );
  }
}
