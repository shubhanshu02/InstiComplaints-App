import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math';
import 'UpdateNotification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'loading.dart';
import 'ComplaintDialog.dart';

Random random = Random();
// complaints to be taken from backend
List complaints = [
  "Fan Not Working",
  "Fee payment portal not working properly djkskfskn jdnsjkdjs dkjfkla dskjfksakkl",
  "Rooms not Swept Properly ",
  "Geyser Not Working",
  "Dustbins Overflowing",
  "Students not Parking Cycle Properly",
  "Lost my Cycle",
  "Messy club common halls",
];
Map<String, String> departments = {
  'Administration': 'administration.jpg',
  'Gymkhana': 'gymkhana.jpg',
  'General': 'general.jpg',
  'image': 'hostel.jpg',
  'Campus': 'parliament.jpg',
  'Proctor': 'proctor.jpg'
};

List notifications = List.generate(
    20,
    (index) => {
          "complaint": complaints[random.nextInt(5)],
          "time": "${random.nextInt(50)} min ago",
          "dp":
              "assets/cm${random.nextInt(5)}.jpg", //images of different categories
        });

class Tile extends StatefulWidget {
  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: UpdateNotification().userssnap,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(8.0),
                separatorBuilder: (BuildContext context, int index) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 0.4,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Divider(),
                    ),
                  );
                },
                itemCount: snapshot.data.data()['notification'].length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == snapshot.data.data()['notification'].length) {
                    return Container(
                        padding: EdgeInsets.all(10),
                        child: Expanded(
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
                          ),
                        ));
                  }
                  //Map<String,String> notification = snapshot.data.data()['notification'][snapshot.data.data()['notification'].length-index-1];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/admin/${departments['image']}'),
                        //backgroundImage: AssetImage(notif['dp']),
                        backgroundColor: Colors.blue,
                        radius: 25,
                      ),
                      contentPadding: EdgeInsets.all(1.2),
                      title: Text(
                        "Status Updated",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      /*subtitle: Text(
                      title.then((value) => value).toString()
                      ,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),*/
                      trailing: Text(
                        DateFormat('kk:mm:a').format(DateTime.parse(
                                snapshot.data.data()['notification'][
                                    snapshot.data.data()['notification'].length -
                                        index -
                                        1]['time'])) +
                            '\n' +
                            DateFormat('dd-MM-yyyy').format(DateTime.parse(
                                snapshot.data.data()['notification']
                                        [snapshot.data.data()['notification'].length - index - 1]
                                    ['time'])),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 11,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => ComplaintDialog(
                                snapshot.data.data()['notification'][snapshot
                                        .data
                                        .data()['notification']
                                        .length -
                                    index -
                                    1]['complaintID']));
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // TODO: Deciding the location of compose button(as a floating button or in the bottom bar)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment(0.0, 2.0),
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/pages1.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          Column(
            children: [
              SizedBox(
                height: 25.0,
              ),
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
                            image:
                                AssetImage("assets/app_logo_final_jpg_ws.jpg"),
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
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontFamily: 'JosefinSans',
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              Tile(),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
