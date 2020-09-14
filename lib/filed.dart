import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Filed extends StatefulWidget {
  @override
  _FiledState createState() => _FiledState();
}

class _FiledState extends State<Filed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment(0.0, 2.0), children: [
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
        Column(children: [
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
                        image: AssetImage("assets/app_logo_final_jpg_ws.jpg"),
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
            "Complaints Filed",
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              fontFamily: 'JosefinSans',
            ),
          ),
          SizedBox(
            height: 11.0,
          ),
        ]),
      ]),
    );
  }
}
