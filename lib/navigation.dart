import 'package:InstiComplaints/Compose.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'st_profile.dart';
import 'package:InstiComplaints/feedPage.dart';
import 'package:InstiComplaints/notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'modifyModerators.dart';
import 'ad_profile.dart';
import 'loading.dart';
import 'moderator_requests.dart';

var user = FirebaseAuth.instance.currentUser;

class User1 extends StatefulWidget {
  @override
  _User1State createState() => _User1State();
}

class _User1State extends State<User1> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
        switch (user.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Loading();
          case ConnectionState.done:
            if (user.hasError) return Text('Error: ${user.error}');
            print(user.data['type']);
            final List<Widget> children1 = [
              Feed(),
              Notifications(),
              Profile(),
              Compose()
            ];
            final List<Widget> children2 = [
              Feed(),
              AdProfile(),
              ModifyModerators()
            ];
            final List<Widget> children3 = [
              Feed(),
              Notifications(),
              Profile(),
              Compose(),
              Requested(),
            ];
            void onTapped(int index) {
              setState(() {
                currentIndex = index;
              });
            }
            return Scaffold(
                body: (user.data['type'] == 'admin')
                    ? children2[currentIndex]
                    : (user.data['type'] == 'student')
                        ? children1[currentIndex]
                        : children3[currentIndex],
                bottomNavigationBar: (user.data['type'] == 'admin')
                    ? CurvedNavigationBar(
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
                            Icons.person,
                            size: 30,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.person_add,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                        onTap: onTapped,
                        index: currentIndex,
                      )
                    : (user.data['type'] == 'student')
                        ? CurvedNavigationBar(
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
                          )
                        : CurvedNavigationBar(
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
                              Icon(
                                Icons.assignment,
                                size: 30,
                                color: Colors.white,
                              ),
                            ],
                            onTap: onTapped,
                            index: currentIndex,
                          ));
        }
        return null; // unreachable
      },
    );
  }
}
