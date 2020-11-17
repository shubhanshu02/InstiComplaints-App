import 'package:InstiComplaints/feedCard.dart';
import 'ComplaintDialog.dart';
import 'package:InstiComplaints/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

var user = FirebaseAuth.instance.currentUser;
GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AdResolved extends StatefulWidget {
  const AdResolved({Key key}) : super(key: key);

  @override
  _AdResolvedState createState() => _AdResolvedState();
}

class _AdResolvedState extends State<AdResolved>
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
                        builder: (context, user) {
                          if (user.connectionState == ConnectionState.waiting)
                            return Loading();
                          List<Widget> list = snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            if (document['category'] == user.data['category'] &&
                                document['status'] == 'Solved')
                              return ComplaintOverviewCard(
                                title: document['title'],
                                onTap: ComplaintDialog(document.id),
                                email: document['email'],
                                filingTime: document['filing time'],
                                category: document['category'],
                                description: document['description'],
                                status: document['status'],
                                upvotes: document['upvotes'],
                                id: document.id,
                              );
                            return Container(width: 0.0, height: 0.0);
                          }).toList();
                          list.add(Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 40,
                                    color: Color(0xFF36497E),
                                  ),
                                  Text(
                                    "You're All Caught Up",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )
                                ],
                              )));

                          return ListView(children: list);
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
                    Text('Complaints Resolved',
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
