import 'package:InstiComplaints/ComplaintFiling.dart';
import 'package:InstiComplaints/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'UpdateNotification.dart';
import 'Complaint_Class.dart';

class ModeratorDialog extends StatefulWidget {
  final String _complaintID;
  ModeratorDialog(this._complaintID);
  @override
  _ModeratorDialogState createState() => _ModeratorDialogState();
}

class _ModeratorDialogState extends State<ModeratorDialog> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    return StreamBuilder<DocumentSnapshot>(
        stream: ComplaintShow(widget._complaintID).complaintsnap,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  snapshot.data.data()['title'],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Color(0xFF181D3D),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 6.0,
                              ),
                              Text(
                                'posted by ',
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
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                DateFormat('kk:mm:a').format(snapshot.data
                                        .data()['filing time']
                                        .toDate()) +
                                    '\n' +
                                    DateFormat('dd-MM-yyyy').format(snapshot
                                        .data
                                        .data()['filing time']
                                        .toDate()),
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.blueGrey),
                              ),
                              new Spacer(),
                              Text(snapshot.data.data()['category'],
                                  style: TextStyle(fontSize: 12.0))
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(snapshot.data.data()['description']),
                          SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            height: snapshot.data
                                        .data()['list of Images']
                                        .length !=
                                    0
                                ? (3.8 * MediaQuery.of(context).size.height) /
                                    10
                                : 0, // card height
                            child: PageView(
                                scrollDirection: Axis.horizontal,
                                controller: PageController(viewportFraction: 1),
                                //pageSnapping: ,
                                children: snapshot.data
                                    .data()['list of Images']
                                    .map<Widget>((imag) => Card(
                                          elevation: 6.0,
                                          child: Image.network(
                                            imag,
                                          ),
                                          margin: EdgeInsets.all(10.0),
                                        ))
                                    .toList()),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () async {
                                  if (snapshot.data.data()['status'] !=
                                      status[3]) {
                                    await ComplaintFiling()
                                        .complaints
                                        .doc(widget._complaintID)
                                        .update({'status': status[3]});
                                    for (var doc in await users
                                        .get()
                                        .then((value) => value.docs)) {
                                      if (doc
                                              .data()['bookmarked']
                                              .contains(widget._complaintID) ||
                                          doc
                                              .data()[
                                                  'list of my filed Complaints']
                                              .contains(widget._complaintID)) {
                                        await users.doc(doc.id).update({
                                          'notification':
                                              FieldValue.arrayUnion([
                                            {
                                              'complaintID':
                                                  widget._complaintID,
                                              'time': DateTime.now().toString()
                                            }
                                          ])
                                        });
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  //color: Color(0xFF181D3D),
                                  width:
                                      (0.7 * MediaQuery.of(context).size.width -
                                              30) /
                                          3,
                                  height: (0.6 *
                                          MediaQuery.of(context).size.height) /
                                      10,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF181D3D),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular((0.6 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                            20),
                                        bottomLeft: Radius.circular((0.6 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                            20),
                                        topRight: Radius.zero,
                                        bottomRight: Radius.zero),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Reject",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                color: Color.fromRGBO(58, 128, 203, 1),
                                width: 1.0,
                              ),
                              Container(
                                height:
                                    (0.6 * MediaQuery.of(context).size.height) /
                                        10,
                                width:
                                    (0.7 * MediaQuery.of(context).size.width -
                                            30) /
                                        3,
                                decoration: BoxDecoration(
                                  color: Color(0xFF181D3D),
                                  shape: BoxShape.rectangle,
                                  //borderRadius: BorderRadius.only(topLeft:Radius.circular((0.6*MediaQuery.of(context).size.height)/20),bottomLeft:Radius.circular((0.6*MediaQuery.of(context).size.height)/20),topRight:Radius.zero,bottomRight:Radius.zero),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data.data()['status'],
                                      style: TextStyle(
                                          fontSize: (0.12 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                              3,
                                          color: Colors.yellow[900],
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      'Status',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: (0.08 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width) /
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
                                onTap: () async {
                                  if (snapshot.data.data()['status'] !=
                                      status[1]) {
                                    await ComplaintFiling()
                                        .complaints
                                        .doc(widget._complaintID)
                                        .update({'status': status[1]});
                                    for (var doc in await users
                                        .get()
                                        .then((value) => value.docs)) {
                                      if (doc
                                              .data()['bookmarked']
                                              .contains(widget._complaintID) ||
                                          doc
                                              .data()[
                                                  'list of my filed Complaints']
                                              .contains(widget._complaintID)) {
                                        await users.doc(doc.id).update({
                                          'notification':
                                              FieldValue.arrayUnion([
                                            {
                                              'complaintID':
                                                  widget._complaintID,
                                              'time': DateTime.now().toString()
                                            }
                                          ])
                                        });
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  //color: Color(0xFF181D3D),
                                  width:
                                      (0.7 * MediaQuery.of(context).size.width -
                                              30) /
                                          3,
                                  height: (0.6 *
                                          MediaQuery.of(context).size.height) /
                                      10,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF181D3D),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.zero,
                                        bottomLeft: Radius.zero,
                                        topRight: Radius.circular((0.6 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                            20),
                                        bottomRight: Radius.circular((0.6 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                            20)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Pass",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )));
          } else {
            Loading();
          }
        });
  }
}
