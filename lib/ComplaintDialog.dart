import 'package:InstiComplaints/UpdateNotification.dart';
import 'package:InstiComplaints/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ComplaintDialog extends StatefulWidget {
  final String _complaintID;
  ComplaintDialog(this._complaintID);
  @override
  _ComplaintDialogState createState() => _ComplaintDialogState();
}

class _ComplaintDialogState extends State<ComplaintDialog> {
  final CollectionReference _complaints =
      FirebaseFirestore.instance.collection('complaints');
  final DocumentReference _userDocument = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid);

  bool bookmarked = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _userDocument.get().then((value) async {
        bookmarked =
            await value.data()['bookmarked'].contains(widget._complaintID);
      });
      print(bookmarked);
    });
  }

  @override
  Widget build(BuildContext context) {
    //_userDocument.get().then((value) {bookmarked=value.data()['bookmarked'].contains(widget._complaintID);});
    return FutureBuilder<DocumentSnapshot>(
        future: _userDocument.get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> aot) {
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
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Text(
                                            'posted by:',
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                          Text(
                                            snapshot.data.data()['email'],
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Color.fromRGBO(
                                                    53, 99, 184, 1),
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //new Spacer(),
                                    IconButton(
                                      onPressed: () async {
                                        if (await _userDocument.get().then(
                                            (value) => value
                                                .data()['bookmarked']
                                                .contains(
                                                    widget._complaintID))) {
                                          await _userDocument.update({
                                            'bookmarked':
                                                FieldValue.arrayRemove(
                                                    [widget._complaintID])
                                          });
                                          setState(() {
                                            bookmarked = false;
                                          });
                                        } else {
                                          await _userDocument.update({
                                            'bookmarked': FieldValue.arrayUnion(
                                                [widget._complaintID])
                                          });
                                          setState(() {
                                            bookmarked = true;
                                          });
                                        }
                                      },
                                      icon: Icon(bookmarked
                                          ? Icons.bookmark
                                          : Icons.bookmark_border),
                                    )
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
                                          DateFormat('dd-MM-yyyy').format(
                                              snapshot.data
                                                  .data()['filing time']
                                                  .toDate()),
                                      style: TextStyle(fontSize: 12.0),
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
                                      ? (3.8 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height) /
                                          10
                                      : 0, // card height
                                  child: PageView(
                                      scrollDirection: Axis.horizontal,
                                      controller:
                                          PageController(viewportFraction: 1),
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
                                    Container(
                                      height: (0.8 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height) /
                                          10,
                                      width: (1.05 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width -
                                              30) /
                                          3,
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                    /*InkWell(
                                      onTap: () {},
                                      child: Container(
                                          width: (0.7 *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                  30) /
                                              3,
                                          height: (0.8 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height) /
                                              10,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF181D3D),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Icon(
                                            Icons.share,
                                            size: (0.35 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height) /
                                                10,
                                            color: Colors.white,
                                          )),
                                    ),
                                    VerticalDivider(
                                      color: Color.fromRGBO(58, 128, 203, 1),
                                      width: 1.0,
                                    ),*/
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
                                        width: (1.05 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                30) /
                                            3,
                                        height: (0.8 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height) /
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
                                              bottomRight: Radius.circular(
                                                  (0.6 *
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height) /
                                                      20)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.arrow_upward),
                                              onPressed: () {
                                                if (snapshot.data
                                                    .data()['upvotes']
                                                    .contains(FirebaseAuth
                                                        .instance
                                                        .currentUser
                                                        .uid)) {
                                                  _complaints
                                                      .doc(widget._complaintID)
                                                      .update({
                                                    'upvotes':
                                                        FieldValue.arrayRemove([
                                                      FirebaseAuth.instance
                                                          .currentUser.uid
                                                    ])
                                                  });
                                                } else {
                                                  _complaints
                                                      .doc(widget._complaintID)
                                                      .update({
                                                    'upvotes':
                                                        FieldValue.arrayUnion([
                                                      FirebaseAuth.instance
                                                          .currentUser.uid
                                                    ])
                                                  });
                                                }
                                              },
                                              color: snapshot.data
                                                      .data()['upvotes']
                                                      .contains(FirebaseAuth
                                                          .instance
                                                          .currentUser
                                                          .uid)
                                                  ? Colors.blue[400]
                                                  : Colors.grey,
                                              iconSize: (0.35 *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height) /
                                                  10,
                                            ),
                                            SizedBox(width: 4.0,),
                                            Text(
                                              snapshot.data
                                                  .data()['upvotes']
                                                  .length
                                                  .toString(),
                                              //complaint.upvotes.length.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 15.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )));
                } else {
                  return Loading();
                }
              });
        });
  }
}
