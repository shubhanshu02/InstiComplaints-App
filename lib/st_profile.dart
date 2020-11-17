import 'package:InstiComplaints/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'camera.dart';
import 'card.dart';
import 'dart:math';

var st = FirebaseAuth.instance.currentUser;

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..lineTo(0, size.width / 8)
      ..addArc(
          Rect.fromLTWH(0, size.width / 512 - size.width / 8, size.width / 2,
              size.width / 2),
          pi,
          -pi / 2)
      ..lineTo(4 * size.width / 4, size.width / 2 - size.width / 8)
      ..addArc(
          Rect.fromLTWH(2 * size.width / 4, size.width / 2 - size.width / 8,
              size.width / 2, size.width / 2),
          3.14 + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 8);
    return path;
  }

  @override
  bool shouldReclip(oldCliper) => false;
}

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('users').doc(st.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
          switch (user.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Loading();
            case ConnectionState.done:
              if (user.hasError) return Text('Error: ${user.error}');
              List<String> ls =
                  List.from(user.data['list of my filed Complaints']);
              List<String> res_list = [];
              /*for (var i = 0; i < ls.length; i++) {
                FirebaseFirestore.instance
                    .collection('complaints')
                    .where('status', isEqualTo: 'Solved').limit(1)\\
                    .get()
                    .then((data) {
                  return res_list.add(FieldPath.documentId.toString());
                });
              }*/
              for (var i = 0; i < ls.length; i++) {
                FirebaseFirestore.instance
                    .collection('complaints')
                    .where('status', isEqualTo: 'Solved')
                    .where('uid', isEqualTo: st.uid)
                    .limit(1)
                    .get()
                    .then((value) =>
                        res_list.add(FieldPath.documentId.toString()));
              }
              print(res_list);
              return Container(
                color: Color(0xFF181D3D),
                child: SafeArea(
                  child: Scaffold(
                    key: _scaffoldState,
                    body: Container(
                      child: ListView(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 4,
                            child: ClipPath(
                                clipper: CurveClipper(),
                                child: Container(
                                  constraints: BoxConstraints.expand(),
                                  color: Color(0xFF181D3D),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 25.0),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/app_logo_final_jpg_ws.jpg'),
                                            radius: 25.0,
                                          ),
                                          SizedBox(
                                            width: 35.0,
                                          ),
                                          Text(
                                            'InstiComplaints',
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.white,
                                              fontFamily: 'Amaranth',
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: query.size.height / 25),
                                      Text('Profile',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Roboto',
                                              fontSize: (30 *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height) /
                                                  1000)),
                                    ],
                                  ),
                                )),
                          ),
                          Center(child: Camera()),
                          SizedBox(height: query.size.height / 50),
                          Center(
                            child: Text(
                              //'${FirebaseAuth.instance.currentUser.displayName}',
                              user.data['name'],
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          SizedBox(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('complaints')
                                    .where('status', isEqualTo: 'Solved')
                                    .where('uid', isEqualTo: st.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text('',
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.grey[800],
                                          fontFamily: 'Roboto',
                                        ));
                                  }
                                  return Row(children: [
                                    Expanded(
                                      flex: 3,
                                      child: FlatButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/filed');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      (ls.length -
                                                              snapshot.data.docs
                                                                  .length)
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                        color: Colors.grey[800],
                                                        fontFamily: 'Roboto',
                                                      )),
                                                  SizedBox(height: 5.0),
                                                  Text('Complaints Filed',
                                                      style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontFamily: 'Roboto',
                                                        fontSize: 3 *
                                                            query.size.width /
                                                            100,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          color: Colors.blueGrey[50],
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: Colors.grey[400],
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          )),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: FlatButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/resolved');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      snapshot.data.docs.length
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                        color: Colors.grey[800],
                                                        fontFamily: 'Roboto',
                                                      )),
                                                  SizedBox(height: 5.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                    child: Text(
                                                        'Complaints Resolved',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[800],
                                                          fontFamily: 'Roboto',
                                                          fontSize: 3 *
                                                              query.size.width /
                                                              100,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          color: Colors.blueGrey[50],
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: Colors.grey[400],
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          )),
                                    )
                                  ]);
                                }),
                          ),
                          SizedBox(height: 15.0),
                          Card(
                              elevation: 5.0,
                              margin: EdgeInsets.symmetric(
                                  horizontal: query.size.width / 14,
                                  vertical: query.size.height / 80),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Category',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontFamily: 'Roboto',
                                        )),
                                    SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        Icon(Icons.person),
                                        SizedBox(width: 5.0),
                                        Text(user.data['type'],
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'Roboto',
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          CardCategory(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
          }
          return null;
        });
  }
}
