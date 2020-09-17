import 'package:flutter/material.dart';

class ComplaintBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 4,
        child: Container(
          width: 377,
  
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(11),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.1), //Color(0xFFD9B08C).withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 0.5,

                //offset: Offset(0, 30), // changes position of shadow
              )
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: [
                          Text('Fan Not Working in C402',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18))
                        ]),
                        Row(
                          children: <Widget>[
                            Text(
                              'Posted by ',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Raju Rastogi',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.bookmark_outline)
                  ],
                ),
                SizedBox(height: 7),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      Text(
                        '  24-07-2020  ',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text('in '),
                      Text(
                        'C.V. Raman Hostel',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'The fan was not found in working state as of 10th...',
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Pending  ',
                              style: TextStyle(
                                color: Colors.red.withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                              )),
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
                    Column(
                      children: <Widget>[
                        Icon(Icons.share),
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
                        Icon(Icons.arrow_upward),
                        Text(
                          '4 Upvotes',
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
