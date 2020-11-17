import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComplaintOverviewCard extends StatefulWidget {
  final String title;
  final Widget onTap;
  final String email;
  final String category;
  final String description;
  final String status;
  final filingTime;
  final upvotes;
  final id;

  const ComplaintOverviewCard(
      {Key key,
      this.title,
      this.onTap,
      this.email,
      this.filingTime,
      this.category,
      this.description,
      this.status,
      this.upvotes,
      this.id})
      : super(key: key);

  @override
  _ComplaintOverviewCardState createState() => _ComplaintOverviewCardState();
}

class _ComplaintOverviewCardState extends State<ComplaintOverviewCard> {
  var upvoteArray;

  @override
  Widget build(BuildContext context) {
    upvoteArray = widget.upvotes;
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(300),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => widget.onTap);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Wrap(
              children: <Widget>[
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Posted by ',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    ),
                    Expanded(
                      child: Text(
                        widget.email,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    /*IconButton(
                        icon: Icon(Icons
                            .bookmark_border),
                        onPressed: () {
                          //TODO: Add color change
                    })*/
                  ],
                ),
                SizedBox(height: 20),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat.yMMMMd()
                          .format(widget.filingTime.toDate())
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' in ',
                      style: TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.category,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        widget.description,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.status,
                              style: TextStyle(
                                fontSize: 16,
                                color: widget.status == 'Rejected'
                                    ? Colors.red
                                    : widget.status == 'Solved'
                                        ? Colors.green
                                        : widget.status == 'In Progress'
                                            ? Colors.blue
                                            : widget.status == 'Passed'
                                                ? Colors.cyan
                                                : Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Status',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_upward),
                          onPressed: () async {
                            final complaint = await FirebaseFirestore.instance
                                .collection('complaints')
                                .doc(widget.id)
                                .get();
                            final complaintDoc = FirebaseFirestore.instance
                                .collection('complaints')
                                .doc(widget.id);

                            if (complaint.data()['upvotes'].contains(
                                FirebaseAuth.instance.currentUser.uid)) {
                              await complaintDoc.update({
                                'upvotes': FieldValue.arrayRemove(
                                    [FirebaseAuth.instance.currentUser.uid])
                              });
                              setState(() {
                                upvoteArray = complaint.data()['upvotes'];
                              });
                            } else {
                              await complaintDoc.update({
                                'upvotes': FieldValue.arrayUnion(
                                    [FirebaseAuth.instance.currentUser.uid])
                              });
                              setState(() {
                                upvoteArray = complaint.data()['upvotes'];
                              });
                            }
                          },
                        ),
                        Text(
                          upvoteArray.length == 1
                              ? '1 Upvote'
                              : '${upvoteArray.length.toString()} Upvotes',
                          style: TextStyle(
                            fontSize: 13,
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
