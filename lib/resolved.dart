import 'package:InstiComplaints/feedCard.dart';
import 'ComplaintDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

var user = FirebaseAuth.instance.currentUser;
GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class Resolved extends StatefulWidget {
  const Resolved({Key key}) : super(key: key);

  @override
  _ResolvedState createState() => _ResolvedState();
}

class _ResolvedState extends State<Resolved>
    with SingleTickerProviderStateMixin {
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
                  child: ResolvedList(),
                )),
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

class ResolvedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
          if (user.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          final List<String> resolved = List<String>.from(
              user.data.data()['list of my filed Complaints']);
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('complaints')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());

                List<Widget> currentresolved = [];
                snapshots.data.docs.forEach((doc) {
                  if (resolved.contains(doc.id) &&
                      doc.data()['status'] == 'Solved') {
                    currentresolved.add(ComplaintOverviewCard(
                      title: doc.data()["title"],
                      onTap: ComplaintDialog(doc.id),
                      email: doc.data()['email'],
                      filingTime: doc.data()['filing time'],
                      category: doc.data()["category"],
                      description: doc.data()["description"],
                      status: doc.data()["status"],
                      upvotes: doc.data()['upvotes'],
                      id: doc.id,
                    ));
                  }
                });
                currentresolved.add(Container(
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
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    )));
                return ListView(
                  children: currentresolved,
                );
              });
        });
  }
}
