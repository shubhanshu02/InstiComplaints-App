import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AdProfile extends StatefulWidget {
  @override
  _AdProfileState createState() => _AdProfileState();
}

class _AdProfileState extends State<AdProfile> {
  List departments = [
    {'image': 'administration.jpg', 'name': 'Administration'},
    {'image': 'gymkhana.jpg', 'name': 'Gymkhana'},
    {'image': 'general.jpg', 'name': 'General'},
    {'image': 'hostel.jpg', 'name': 'Hostel Parliament'},
    {'image': 'parliament.jpg', 'name': 'Student Parliament'},
    {'image': 'proctor.jpg', 'name': 'Proctor'}
  ];
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
}
