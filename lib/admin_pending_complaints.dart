import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'AdminDialog.dart';

var user = FirebaseAuth.instance.currentUser;

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

class AdPending extends StatefulWidget {
  const AdPending({Key key}) : super(key: key);

  @override
  _AdPendingState createState() => _AdPendingState();
}

class _AdPendingState extends State<AdPending>
    with SingleTickerProviderStateMixin {
  CollectionReference complaints =
      FirebaseFirestore.instance.collection('complaints');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: Stack(
        children: [
          Container(
            child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 150, bottom: 0),
                child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: complaints.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) return Loading();
                          return new ListView(
                            children: snapshot.data.docs
                                .map((DocumentSnapshot document) {
                              if (document['category'] ==
                                      snapshot.data['category'] &&
                                  document['status'] == 'passed')
                                return Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(11)),
                                    child: Container(
                                      // TODO: Adjust height according to generator function
                                      height: 210,
                                      child: InkWell(
                                        splashColor: Colors.blue.withAlpha(300),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AdminDialog(document.id));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Row(children: [
                                                        Text(document["title"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18))
                                                      ]),
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            'Posted by ',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            document["email"],
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton(
                                                      icon: Icon(Icons
                                                          .bookmark_border),
                                                      onPressed: () {
                                                        //TODO: Add color change
                                                      })
                                                ],
                                              ),
                                              SizedBox(height: 7),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Icon(Icons.calendar_today),
                                                    Text(
                                                      DateFormat.yMd()
                                                          .format(document[
                                                                  'filing time']
                                                              .toDate())
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(' in '),
                                                    Text(
                                                      document["category"],
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      document["description"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 7),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 70,
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                              document[
                                                                  "status"],
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .red
                                                                    .withOpacity(
                                                                        0.6),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            'Status',
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      IconButton(
                                                        icon: Icon(Icons.share),
                                                        onPressed: () {},
                                                      ),
                                                      Text(
                                                        'Share',
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      IconButton(
                                                        icon: Icon(
                                                            Icons.arrow_upward),
                                                        onPressed: () {},
                                                      ),
                                                      Text(
                                                        document['upvotes']
                                                            .length
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              return Container(width: 0.0, height: 0.0);
                            }).toList(),
                          );
                        });
                  },
                ))),
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.035,
                      color: Color(0xFF181D3D),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ClipPath(
                          clipper: CurveClipper(),
                          child: Container(
                            //constraints: BoxConstraints.expand(),
                            color: Color(0xFF181D3D),
                          )),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/app_logo_final_jpg_ws.jpg'),
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
                    SizedBox(height: 20.0),
                    Text('Complaints Pending',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                (30 * MediaQuery.of(context).size.height) /
                                    1000)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////

// code for the upper design of appbar

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..addArc(Rect.fromLTWH(0, 0, size.width / 2, size.width / 3), pi, -1.57)
      ..lineTo(9 * size.width / 10, size.width / 3)
      ..addArc(
          Rect.fromLTWH(
              size.width / 2, size.width / 3, size.width / 2, size.width / 3),
          pi + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 6);
    return path;
  }

  @override
  bool shouldReclip(oldCliper) => false;
}
