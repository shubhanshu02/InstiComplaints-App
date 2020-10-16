import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:math';

class Resolved extends StatefulWidget {
  @override
  _ResolvedState createState() => _ResolvedState();
}

class _ResolvedState extends State<Resolved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: (4.3 * MediaQuery.of(context).size.width) / 8,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(),
              color: Colors.white,
              //child: Compose(),
            ),
            ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  constraints: BoxConstraints.expand(),
                  color: Color(0xFF181D3D),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 25.0, 0.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(height: 30.0),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/app_logo_final_jpg_ws.jpg'),
                            radius: (38 * MediaQuery.of(context).size.height) /
                                1000,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'InstiComplaint',
                            style: TextStyle(
                                fontFamily: 'Amaranth',
                                color: Colors.white,
                                fontSize:
                                    (34 * MediaQuery.of(context).size.height) /
                                        1000),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 24),
                    Text('Complaints Resolved',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                (30 * MediaQuery.of(context).size.height) /
                                    1000)),
                    //SizedBox(height: MediaQuery.of(context).size.height / 12),
                  ]),
                )),
          ],
        ))
    );
  }
}


class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..lineTo(0, size.width / 8)
      ..addArc(
          Rect.fromLTWH(0, size.width / 512 - size.width / 8, size.width / 2,
              size.width / 2),
          pi,
          -pi / 2)
      ..lineTo(4 * size.width / 4, size.width / 2 - size.width / 8)
      ..addArc(
          Rect.fromLTWH(2 * size.width / 4, size.width / 2 - size.width / 8,
              size.width / 2, size.width / 2),
          3.14 + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 8);
    return path;
  }

  @override
  bool shouldReclip(oldCliper) => false;
}