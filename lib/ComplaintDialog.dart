import 'package:InstiComplaints/UpdateNotification.dart';
import 'package:flutter/material.dart';
import 'Compose.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Complaint_Class.dart';

class ComplaintDialog extends StatefulWidget {

  final String _complaintID;
  ComplaintDialog(this._complaintID);
  @override
  _ComplaintDialogState createState() => _ComplaintDialogState();
}

class _ComplaintDialogState extends State<ComplaintDialog> {



  final CollectionReference complaints = FirebaseFirestore.instance.collection('complaints');

  /*bool _like =
      true ? complaint.upvotes.contains("MY EMAIL ID: FROM BACKEND") : false;*/

  //bool bookmarked = false;

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<DocumentSnapshot>(
      stream: ComplaintShow(widget._complaintID).complaintsnap,
      builder: (context, snapshot) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5.0,
            backgroundColor: Colors.transparent,
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                snapshot.data.data()['title'],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF181D3D),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'posted by:',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                Text(
                                  snapshot.data.data()['email'],
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color.fromRGBO(53, 99, 184, 1),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0),
                                ),
                              ],
                            )
                          ],
                        ),
                        new Spacer(),
                        IconButton(
                          onPressed: () {
                            
                          },
                          icon: Icon(
                              //bookmarked ? Icons.bookmark : Icons.bookmark_border
                              Icons.bookmark
                              ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          DateFormat('kk:mm:a').format(snapshot.data.data()['filing time'].toDate()) +
                              '\n' +
                              DateFormat('dd-MM-yyyy').format(snapshot.data.data()['filing time'].toDate()),
                          style: TextStyle(fontSize: 12.0),
                        ),
                        new Spacer(),
                        Text(snapshot.data.data()['category'], style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: (4.2 * MediaQuery.of(context).size.height) / 10,
                      child: ListView(
                        padding: EdgeInsets.all(8.0),
                        children: <Widget>[
                          Text(snapshot.data.data()['description']),
                          SizedBox(
                            height: 10.0,
                          ),
                          Center(
                              child: SizedBox(
                            height: (3.8 * MediaQuery.of(context).size.height) /10, // card height
                            child: PageView(
                                scrollDirection: Axis.horizontal,
                                controller: PageController(viewportFraction: 1),
                                //pageSnapping: ,
                                children: snapshot.data.data()['list of Images']
                                    .map<Widget>((imag) => Card(
                                          elevation: 6.0,
                                          child: Image.network(
                                            imag,
                                          ),
                                          margin: EdgeInsets.all(10.0),
                                        ))
                                    .toList()),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: (0.8 * MediaQuery.of(context).size.height) / 10,
                          width: (0.7 * MediaQuery.of(context).size.width - 30) / 3,
                          decoration: BoxDecoration(
                            color: Color(0xFF181D3D),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    (0.6 * MediaQuery.of(context).size.height) /
                                        20),
                                bottomLeft: Radius.circular(
                                    (0.6 * MediaQuery.of(context).size.height) /
                                        20),
                                topRight: Radius.zero,
                                bottomRight: Radius.zero),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                snapshot.data.data()['status'],
                                style: TextStyle(
                                    fontSize:
                                        (0.12 * MediaQuery.of(context).size.width) /
                                            3,
                                    color: Colors.yellow[900],
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Status',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize:
                                        (0.08 * MediaQuery.of(context).size.width) /
                                            3),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Color.fromRGBO(58, 128, 203, 1),
                          width: 1.0,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                              width:
                                  (0.7 * MediaQuery.of(context).size.width - 30) /
                                      3,
                              height:
                                  (0.8 * MediaQuery.of(context).size.height) / 10,
                              decoration: BoxDecoration(
                                color: Color(0xFF181D3D),
                                shape: BoxShape.rectangle,
                              ),
                              child: Icon(
                                Icons.share,
                                size: (0.35 * MediaQuery.of(context).size.height) /
                                    10,
                                color: Colors.white,
                              )),
                        ),
                        VerticalDivider(
                          color: Color.fromRGBO(58, 128, 203, 1),
                          width: 1.0,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              /*if (_like == true) {
                                _like = false;
                                complaint.upvotes
                                    .remove("MY EMAIL ID: FROM BACKEND");
                                //TODO: Upload complaint to Backend
                              } else {
                                _like = true;
                                complaint.upvotes.add("MY EMAIL ID: FROM BACKEND");
                                //TODO: Upload complaint to Backend
                              }*/
                            });
                          },
                          child: Container(
                            width:
                                (0.7 * MediaQuery.of(context).size.width - 30) / 3,
                            height: (0.8 * MediaQuery.of(context).size.height) / 10,
                            decoration: BoxDecoration(
                              color: Color(0xFF181D3D),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.zero,
                                  bottomLeft: Radius.zero,
                                  topRight: Radius.circular(
                                      (0.6 * MediaQuery.of(context).size.height) /
                                          20),
                                  bottomRight: Radius.circular(
                                      (0.6 * MediaQuery.of(context).size.height) /
                                          20)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_upward,
                                  //color: _like ? Colors.blue[400] : Colors.grey,
                                  size:
                                      (0.35 * MediaQuery.of(context).size.height) /
                                          10,
                                ),
                                Text(
                                  snapshot.data.data()['upvotes'].length.toString(),
                                  //complaint.upvotes.length.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 10.0),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )));
      }
    );
  }
}
