import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loading.dart';
import 'dart:math';

var user = FirebaseAuth.instance.currentUser;

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

Map<String, String> departments = {
  'Administration': 'administration.jpg',
  'Gymkhana': 'gymkhana.jpg',
  'General': 'general.jpg',
  'image': 'hostel.jpg',
  'Campus': 'parliament.jpg',
  'Proctor': 'proctor.jpg'
};
/*class Ad1Profile extends StatefulWidget {
  @override
  _Ad1ProfileState createState() => _Ad1ProfileState();
}

class _Ad1ProfileState extends State<Ad1Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pages1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(width: 5.0),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/app_logo_final_jpg_ws.jpg'),
                      radius: 25.0,
                    ),
                    SizedBox(width: 5.0),
                    Text('InstiComplaints',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Amaranth',
                          fontSize: 20.0,
                        )),
                  ],
                ),
                SizedBox(height: 25.0),
                Text('Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 30.0,
                    )),
                SizedBox(height: 50.0),
                Container(
                  width: 160,
                  height: 160,
                  margin: EdgeInsets.fromLTRB(110, 0, 110, 0),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/admin/${departments[1]["image"]}'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Text(departments[1]['name'],
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181d3d),
                      )),
                ),
                SizedBox(height: 20.0),
                Row(children: [
                  Expanded(
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/ad_pending');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('21',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.grey[800],
                                    fontFamily: 'Roboto',
                                  )),
                              SizedBox(height: 5.0),
                              Text('Complaints Pending',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: 'Roboto',
                                  )),
                            ],
                          ),
                        ),
                        color: Colors.blueGrey[50],
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey[400],
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        )),
                  ),
                  Expanded(
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/ad_resolved');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('5',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.grey[800],
                                    fontFamily: 'Roboto',
                                  )),
                              SizedBox(height: 5.0),
                              Text('Complaints Resolved',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: 'Roboto',
                                  )),
                            ],
                          ),
                        ),
                        color: Colors.blueGrey[50],
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey[400],
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        )),
                  )
                ]),
                SizedBox(height: 15.0),
                Card(
                    elevation: 5.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
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
                              Text('Admin',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  )),
                            ],
                          )
                        ],
                      ),
                    )),
                Card(
                    elevation: 5.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email Id',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'Roboto',
                              )),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Icon(Icons.mail),
                              SizedBox(width: 5.0),
                              Text('gymkhana@itbhu.ac.in',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  )),
                            ],
                          )
                        ],
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}*/
GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

class AdProfile extends StatefulWidget {
  @override
  _AdProfileState createState() => _AdProfileState();
}

class _AdProfileState extends State<AdProfile> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
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
              List<String> ls =
                  List.from(user.data['list of my filed Complaints']);

              return Scaffold(
                key: _scaffoldState,
                body: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              right: 0, left: 0, top: 150, bottom: 0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ListView(children: [
                                SizedBox(height: query.size.height / 32),
                                Center(
                                  child: Container(
                                    width: query.size.width / 2.5,
                                    height: query.size.width / 2.5,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/admin/${(departments.containsKey(user.data["category"])) ? departments[user.data["category"]] : departments['image']}'),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                SizedBox(height: query.size.height / 50),
                                Center(
                                  child: Text(
                                    //'${FirebaseAuth.instance.currentUser.displayName}',
                                    user.data['category'],
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                SizedBox(
                                  child: Row(children: [
                                    Expanded(
                                      flex: 3,
                                      child: FlatButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/ad_pending');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              child: Column(
                                                children: [
                                                  StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'complaints')
                                                          .where('status',
                                                          whereIn: ['Passed', 'In Progress']
                                                              )
                                                          .where('category',
                                                              isEqualTo: user
                                                                      .data[
                                                                  'category'])
                                                          .snapshots(),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              passed) {
                                                        if (passed
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Text('',
                                                              style: TextStyle(
                                                                fontSize: 25.0,
                                                                color: Colors
                                                                    .grey[800],
                                                                fontFamily:
                                                                    'Roboto',
                                                              ));
                                                        }
                                                        return Text(
                                                            passed.data.docs
                                                                .length
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 25.0,
                                                              color: Colors
                                                                  .grey[800],
                                                              fontFamily:
                                                                  'Roboto',
                                                            ));
                                                      }),
                                                  SizedBox(height: 5.0),
                                                  Text('Complaints Pending',
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
                                                context, '/ad_resolved');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              child: Column(
                                                children: [
                                                  StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'complaints')
                                                          .where('status',
                                                              isEqualTo:
                                                                  'Solved')
                                                          .where('category',
                                                              isEqualTo: user
                                                                      .data[
                                                                  'category'])
                                                          .snapshots(),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              resolved) {
                                                        if (resolved
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Text('',
                                                              style: TextStyle(
                                                                fontSize: 25.0,
                                                                color: Colors
                                                                    .grey[800],
                                                                fontFamily:
                                                                    'Roboto',
                                                              ));
                                                        }
                                                        print(resolved.data);
                                                        return Text(
                                                            resolved.data.docs
                                                                .length
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 25.0,
                                                              color: Colors
                                                                  .grey[800],
                                                              fontFamily:
                                                                  'Roboto',
                                                            ));
                                                      }),
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
                                  ]),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              Text('Admin',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'Roboto',
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                                Card(
                                    elevation: 5.0,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: query.size.width / 14,
                                        vertical: query.size.height / 80),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('E-Mail',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontFamily: 'Roboto',
                                              )),
                                          SizedBox(height: 5.0),
                                          Row(
                                            children: [
                                              Icon(Icons.person),
                                              SizedBox(width: 5.0),
                                              Text(user.data['email'],
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'Roboto',
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ]))),
                    ),
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.035,
                                color: Color(0xFF181D3D),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: ClipPath(
                                    clipper: CurveClipper(),
                                    child: Container(
                                      //constraints: BoxConstraints.expand(),
                                      color: Color(0xFF181D3D),
                                    )),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 25.0),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/app_logo_final_jpg_ws.jpg'),
                                      radius: 25.0,
                                    ),
                                    SizedBox(
                                      width: 20.0,
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
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
          }
          return null;
        });
  }
}

