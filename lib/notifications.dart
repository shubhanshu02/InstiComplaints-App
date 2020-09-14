import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// TODO: Generating list of notifications for the complaints taken from the backend

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

List notifications = List.generate(
    20,
    (index) => {
          "complaint": complaints[random.nextInt(5)],
          "time": "${random.nextInt(50)} min ago",
          "dp":
              "assets/cm${random.nextInt(5)}.jpg", //images of different categories
        });

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
                height: MediaQuery.of(context).size.height / 11.0,
              ),
              new Expanded(
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
                  itemCount: notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map notif = notifications[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(notif['dp']),
                          radius: 25,
                        ),
                        contentPadding: EdgeInsets.all(1.2),
                        title: Text(
                          "Status Updated",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          notif['complaint'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          notif['time'],
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 11,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                    );
                  },
                ),
              ),
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
