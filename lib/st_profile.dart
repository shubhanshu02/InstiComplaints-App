import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'camera.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String category = "Student", roomNo = "C-304", hostel = "Ramanujan Hostel";

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
                      radius: 20.0,
                    ),
                    SizedBox(width: 5.0),
                    Text('InstiComplaints',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 15.0,
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
                Camera(),
                SizedBox(height: 10.0),
                Center(
                  child: Text('John Leutis',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                      )),
                ),
                SizedBox(height: 20.0),
                Row(children: [
                  Expanded(
                    child: FlatButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 263.0, 0.0),
                            child: Text('Category',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Roboto',
                                )),
                          ),
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
                Card(
                    elevation: 5.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 263.0, 0.0),
                            child: Text('Room no.',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Roboto',
                                )),
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Icon(Icons.person_pin),
                              SizedBox(width: 5.0),
                              Text('C-304',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  )),
                            ],
                          )
                        ],
                      ),
                    )),
                SizedBox(height: 5.0),
                Card(
                    elevation: 5.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 237.0, 0.0),
                            child: Text('Hostel Name',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Roboto',
                                )),
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 5.0),
                              Text('Ramanujan Hostel',
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,

        color: Color(0xFF181d3d),

        buttonBackgroundColor: Colors.red,
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

Widget cardTempelate() {
  return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        children: [
          Text('Address',
              style: TextStyle(
                color: Colors.grey[600],
                fontFamily: 'Roboto',
              )),
          Row(
            children: [
              Icon(Icons.location_city),
              SizedBox(width: 5.0),
              Text('Ramanujan Hostel',
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Roboto',
                  )),
            ],
          )
        ],
      ));
}
