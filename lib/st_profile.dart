import 'package:InstiComplaints/UpdateNotification.dart';
import 'package:InstiComplaints/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'camera.dart';
import 'card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: UpdateNotification().userssnap,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Container(
            color: Color(0xFF181D3D),
            child: SafeArea(
              child: Scaffold(
                body: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/pages1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20.0,
                            ),
                            new Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          "assets/app_logo_final_jpg_ws.jpg"),
                                    ))),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "InstiComplaints",
                              style: TextStyle(
                                fontFamily: 'Amaranth',
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Text('Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 30.0,
                              )),
                        ),
                        SizedBox(height: 40.0),
                        Center(child: Camera()),
                        SizedBox(height: 10.0),
                        Center(
                          child: Text(
                            snapshot.data.data()['name'],
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(children: [
                          Expanded(
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/filed');
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
                                      Text('Complaints Filed',
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
                                  Navigator.pushNamed(context, '/resolved');
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
                                      Text('Student',
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
                    )),
              ),
            ),
          );
        }
        else{
          return Loading();
        }
      }
    );
  }
}
