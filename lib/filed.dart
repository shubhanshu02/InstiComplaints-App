import 'package:InstiComplaints/feedCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'ComplaintDialog.dart';
import 'loading.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

class Filed extends StatefulWidget {
  const Filed({Key key}) : super(key: key);

  @override
  _FiledState createState() => _FiledState();
}

class _FiledState extends State<Filed> with SingleTickerProviderStateMixin {
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
                  child: ComplaintList(),
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
                    Text('Complaints Filed',
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

///////////////////////// filed complaints execution //////////////////////////////////

var user = FirebaseAuth.instance.currentUser;

class ComplaintList extends StatefulWidget {
  @override
  _ComplaintListState createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<String>>.value(
      value: getComplaintId,
      child: ComplaintTile1(),
    );
  }
}

List<String> getComplaints(DocumentSnapshot snapshot) {
  print(snapshot.data());
  return List.from(snapshot['list of my filed Complaints']);
}

Stream<List<String>> get getComplaintId {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get()
      .then((snapshot) {
    try {
      return getComplaints(snapshot);
    } catch (e) {
      print(e);
      return null;
    }
  }).asStream();
}

class ComplaintTile1 extends StatefulWidget {
  @override
  _ComplaintTile1State createState() => _ComplaintTile1State();
}

class _ComplaintTile1State extends State<ComplaintTile1> {
  @override
  Widget build(BuildContext context) {
    final complaintIds = Provider.of<List<String>>(context) ?? [];
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == complaintIds.length) {
          return Container(
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
              ));
        }
        return FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('complaints')
              .doc(complaintIds[index])
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
            switch (user.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start.');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Loading();
              case ConnectionState.done:
                if (user.hasError) return Text('Error: ${user.error}');
                return ComplaintOverviewCard(
                  title: user.data["title"],
                  onTap: ComplaintDialog(user.data.id),
                  email: user.data['email'],
                  filingTime: user.data['filing time'],
                  category: user.data["category"],
                  description: user.data["description"],
                  status: user.data["status"],
                  upvotes: user.data['upvotes'],
                  id: user.data.id,
                );
            }
            return null; // unreachable
          },
        );
      },
      itemCount: complaintIds.length + 1,
    );
  }
}
