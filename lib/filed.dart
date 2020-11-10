import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'ComplaintDialog.dart';

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
      itemCount: complaintIds.length,
      itemBuilder: (context, index) {
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
                return Text('Awaiting result...');
              case ConnectionState.done:
                if (user.hasError) return Text('Error: ${user.error}');
                if (user.data['status'] == 'resolved')
                  return Container(width: 0.0, height: 0.0);
                return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11)),
                    child: Container(
                      // TODO: Adjust height according to generator function
                      height: 210,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(300),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  ComplaintDialog(user.data.id));
                          //TODO: Add navigator to other card
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(children: [
                                        Text(user.data["title"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18))
                                      ]),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Posted by ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            user.data[
                                                'email'], // todo: add name field in complaints collection docs
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.bookmark_border),
                                      onPressed: () {
                                        //TODO: Add color change
                                      })
                                ],
                              ),
                              SizedBox(height: 7),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(Icons.calendar_today),
                                    Text(
                                      DateFormat.yMMMMd()
                                          .format(
                                              user.data['filing time'].toDate())
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(' in '),
                                    Text(
                                      user.data["category"] ?? "",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      user.data["description"],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 7),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    width: 70,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(user.data["status"],
                                              style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                                fontWeight: FontWeight.bold,
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Status',
                                            style: TextStyle(
                                              fontSize: 11,
                                            ),
                                            textAlign: TextAlign.center,
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
                                        icon: Icon(Icons.arrow_upward),
                                        onPressed: () {},
                                      ),
                                      Text(
                                        //todo : get the size of upvotes array from the backend
                                        user.data['upvotes'].length.toString(),
                                        style: TextStyle(
                                          fontSize: 13,
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
            }
            return null; // unreachable
          },
        );
      },
    );
  }
}
