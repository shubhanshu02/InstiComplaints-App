import 'package:InstiComplaints/ComplaintDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();
  String keyword = "";

  bool isSubstring(String subString, String mainString) {
    subString = subString.toLowerCase();
    mainString = mainString.toLowerCase();
    int m = subString.length;
    int n = mainString.length;
    for (int i = 0; i <= n - m; i++) {
      int j;
      for (j = 0; j < m; j++) if (mainString[i + j] != subString[j]) break;
      if (j == m) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar(context),
      body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('complaints').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> query) {
              if (!query.hasData) {
                return Text(
                  'No Data...',
                );
              }
              List<Widget> list = [];
              query.data.docs.forEach((doc) {
                if (isSubstring(keyword, doc.data()['title']) ||
                    isSubstring(keyword, doc.data()['description']))
                  list.add(Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11)),
                      child: Container(
                        height: 130,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    ComplaintDialog(doc.id));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    doc.data()["title"],
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'Posted by ',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              doc.data()['email'],
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.calendar_today),
                                      Text(
                                        DateFormat.yMd()
                                            .format(doc
                                                .data()['filing time']
                                                .toDate())
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(' in '),
                                      Text(
                                        doc.data()["category"] ?? "",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 7),
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        doc.data()["description"],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )));
              });
              return ListView(
                children: list.length != 0
                    ? list
                    : [
                        Center(
                            child: Column(
                          children: [
                            Container(
                                child: Icon(
                              Icons.sentiment_very_dissatisfied,
                              size: 60,
                            )),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'No Results Found',
                                overflow: TextOverflow.visible,
                              ),
                            )
                          ],
                        ))
                      ],
              );
            },
          )),
    );
  }

  Widget searchBar(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white)),
        onChanged: (String text) {
          setState(() {
            keyword = text;
          });
        },
      ),
      backgroundColor: Color(0xFF181D3D),
      actions: [
        IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                controller.clear();
                keyword = "";
              });
            })
      ],
    );
  }
}
