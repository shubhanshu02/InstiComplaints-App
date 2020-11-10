import 'dart:async';
import 'loading.dart';
import 'UpdateNotification.dart';
import 'package:InstiComplaints/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'ComplaintDialog.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

ValueNotifier<Map<String, bool>> _filter =
    ValueNotifier<Map<String, bool>>(categoryComaplints);

class Feed extends StatefulWidget {
  const Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    // ..addListener(() {
    // setState(() {
    // _tabController.index = 0;
    // });
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Null> _refresh() {
    return () {}();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      drawer: NavDrawer(),
      body: Stack(
        children: [
          Container(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(
                        right: 20, left: 20, top: 150, bottom: 0),
                    child: Container(
                        child: ValueListenableBuilder(
                      valueListenable: _filter,
                      builder: (BuildContext context, Map<String, bool> value,
                          Widget child) {
                        return Column(
                          children: [
                            Flexible(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('complaints')
                                    .orderBy('filing time', descending: true)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Something went wrong');
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }
                                  List feedcomplaints = snapshot.data.docs
                                      .map((DocumentSnapshot document) {
                                    if (value[document['category']] == true) {
                                      return Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(11)),
                                          child: Container(
                                            // TODO: Adjust height according to generator function
                                            height: 210,
                                            child: InkWell(
                                              splashColor:
                                                  Colors.blue.withAlpha(300),
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        ComplaintDialog(
                                                            document.id));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        document["title"],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Posted by ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Text(
                                                                  document[
                                                                      'email'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        IconButton(
                                                            icon: Icon(Icons
                                                                .bookmark_border),
                                                            onPressed: () {
                                                              //TODO: Add color change
                                                            })
                                                      ],
                                                    ),
                                                    SizedBox(height: 7),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Icon(Icons
                                                              .calendar_today),
                                                          Text(
                                                            DateFormat.yMMMMd()
                                                                .format(document[
                                                                        'filing time']
                                                                    .toDate())
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(' in '),
                                                          Text(
                                                            document[
                                                                "category"],
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 4),
                                                    Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            document[
                                                                "description"],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(height: 7),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          width: 80,
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                    document[
                                                                        "status"],
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: document["status"] ==
                                                                              'Pending'
                                                                          ? Colors
                                                                              .red
                                                                              .withOpacity(0.6)
                                                                          : document["status"] == 'Passed'
                                                                              ? Colors.blue
                                                                              : Colors.green,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    )),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'Status',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          children: <Widget>[
                                                            IconButton(
                                                              icon: Icon(
                                                                  Icons.share),
                                                              onPressed: () {},
                                                            ),
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
                                                            IconButton(
                                                              icon: Icon(Icons
                                                                  .arrow_upward),
                                                              onPressed: () {},
                                                            ),
                                                            Text(
                                                              document[
                                                                      'upvotes']
                                                                  .length
                                                                  .toString(),
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
                                            ),
                                          ));
                                    } else
                                      return Container(
                                        height: 0,
                                      );
                                  }).toList();
                                  feedcomplaints.add(Container(
                                      padding: EdgeInsets.all(10),
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            Divider(
                                              color: Colors.black,
                                            ),
                                            Icon(
                                              Icons.check_circle,
                                              size: 40,
                                              color: Color(0xFF36497E),
                                            ),
                                            Text(
                                              "You're All Caught Up",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            )
                                          ],
                                        ),
                                      )));
                                  return new ListView(children: feedcomplaints);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ))),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 150, bottom: 0),
                  child: Container(
                    // add contents of the bookmark page
                    child: ComplaintList(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.035,
                      color: Color(0xFF181D3D),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ClipPath(
                          clipper: CurveClipper(),
                          child: Container(
                            //constraints: BoxConstraints.expand(),
                            color: Color(0xFF181D3D),
                          )),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //implementation of sidebar
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {
                            _scaffoldState.currentState.openDrawer();
                          },
                        ),
                        SizedBox(
                          width: 35.0,
                        ),
                        Text(
                          'InstiComplaints',
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontFamily: 'Amaranth',
                          ),
                        ),
                        SizedBox(
                          width: 40.0,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Search()));
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    // Implementation of tabbar
                    Center(
                      child: Container(
                        width: 300.0,
                        height: 60,
                        child: TabBar(
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                            color: Color(0xFF606fad),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          tabs: [
                            Tab(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(42.0, 0, 42.0, 0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.mode_comment,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    Text(
                                      'Feed',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 0, 25, 0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    Text(
                                      'Bookmarks',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////

// code for the upper design of appbar

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..addArc(Rect.fromLTWH(0, 0, size.width / 2, size.width / 3), pi, -1.57)
      ..lineTo(9 * size.width / 10, size.width / 3)
      ..addArc(
          Rect.fromLTWH(
              size.width / 2, size.width / 3, size.width / 2, size.width / 3),
          pi + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 6);
    return path;
  }

  @override
  bool shouldReclip(oldCliper) => false;
}

////////////////////////////////////////////////////////////////////////////////

Map<String, bool> categoryComaplints = {
  "Administration": isSwitched1,
  "Gymkhana": isSwitched2,
  "General": isSwitched3,
  "Campus": isSwitched4,
  "Proctor": isSwitched5,
  "C. V. Raman": isSwitched6,
  "Morvi": isSwitched7,
  "Dhanrajgiri": isSwitched8,
  "Rajputana": isSwitched9,
  "Limbdi": isSwitched10,
  "Vivekanand": isSwitched11,
  "Vishwakarma": isSwitched12,
  "Vishweshvariaya": isSwitched13,
  "Aryabhatt-I": isSwitched14,
  "Aryabhatt–II": isSwitched15,
  "S. N. Bose": isSwitched16,
  "S. Ramanujan": isSwitched17,
  "Gandhi Smriti Chhatravas(Old)": isSwitched18,
  "Gandhi Smriti Chhatravas(Extension)": isSwitched19,
  "IIT (BHU) Girls Hostel": isSwitched20,
  "S. C. Dey": isSwitched21,
  "IIT Boys (Saluja)": isSwitched22,
};

// code for the sidebar
bool isSwitched1 = true;
bool isSwitched2 = true;
bool isSwitched3 = true;
bool isSwitched4 = true;
bool isSwitched5 = true;
bool isSwitched6 = true;
bool isSwitched7 = true;
bool isSwitched8 = true;
bool isSwitched9 = true;
bool isSwitched10 = true;
bool isSwitched11 = true;
bool isSwitched12 = true;
bool isSwitched13 = true;
bool isSwitched14 = true;
bool isSwitched15 = true;
bool isSwitched16 = true;
bool isSwitched17 = true;
bool isSwitched18 = true;
bool isSwitched19 = true;
bool isSwitched20 = true;
bool isSwitched21 = true;
bool isSwitched22 = true;

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    print(categoryComaplints);
    return StreamBuilder<DocumentSnapshot>(
      stream: UpdateNotification().userssnap,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/third');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8.0,
                              color: Colors.black54,
                              spreadRadius: 0.9,
                            )
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage:
                              snapshot.data.data()['profilePic'] == ""
                                  ? AssetImage('assets/blankProfile.png')
                                  : NetworkImage(
                                      snapshot.data.data()['profilePic']),
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       image: AssetImage("assets/app_logo_final0.png"),
                    //       fit: BoxFit.fitHeight,
                    //     )),
                  ),
                  Center(
                    child: Container(
                      color: Color(0xFF181D3D),
                      child: ListTile(
                        title: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Hi, ${snapshot.data.data()['name']}",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'JosefinSans',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(2.0),
                      children: [
                        ExpansionTile(
                          leading: Icon(
                            Icons.filter_list,
                            color: Color(0xFF181D3D),
                          ),
                          title: Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          children: [
                            ListTile(
                              leading: Switch(
                                value: isSwitched1,
                                onChanged: (bool value) {
                                  setState(() {
                                    isSwitched1 = value;
                                    categoryComaplints["Administration"] =
                                        isSwitched1;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Administration'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched2,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched2 = value;
                                    categoryComaplints["Gymkhana"] =
                                        isSwitched2;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Gymkhana'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched3,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched3 = value;
                                    categoryComaplints["General"] = isSwitched3;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('General'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched4,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched4 = value;
                                    categoryComaplints["Campus"] = isSwitched4;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Campus'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched5,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched5 = value;
                                    categoryComaplints["Proctor"] = isSwitched5;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Proctor'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched6,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched6 = value;
                                    categoryComaplints["C. V. Raman"] =
                                        isSwitched6;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('C. V. Raman'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched7,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched7 = value;
                                    categoryComaplints["Morvi"] = isSwitched7;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Morvi'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched8,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched8 = value;
                                    categoryComaplints["Dhanrajgiri"] =
                                        isSwitched8;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Dhanrajgiri'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched9,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched9 = value;
                                    categoryComaplints["Rajputana"] =
                                        isSwitched9;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Rajputana'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched10,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched10 = value;
                                    categoryComaplints["Limbdi"] = isSwitched10;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Limbdi'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched11,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched11 = value;
                                    categoryComaplints["Vivekanand"] =
                                        isSwitched11;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Vivekanand'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched12,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched12 = value;
                                    categoryComaplints["Vishwakarma"] =
                                        isSwitched12;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Vishwakarma'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched13,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched13 = value;
                                    categoryComaplints["Vishweshvaraiya"] =
                                        isSwitched13;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Vishweshvaraiya'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched14,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched14 = value;
                                    categoryComaplints["Aryabhatt–I"] =
                                        isSwitched14;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Aryabhatt-I'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched15,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched15 = value;
                                    categoryComaplints["Aryabhatt-II"] =
                                        isSwitched15;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Aryabhatt-II'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched16,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched16 = value;
                                    categoryComaplints["S. N. Bose"] =
                                        isSwitched16;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('S. N. Bose'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched17,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched17 = value;
                                    categoryComaplints["S. Ramanujan"] =
                                        isSwitched17;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('S. Ramanujan'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched18,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched18 = value;
                                    categoryComaplints[
                                            "Gandhi Smriti Chhatravas(Old)"] =
                                        isSwitched18;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('Gandhi Smriti Chhatravas(Old)'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched19,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched19 = value;
                                    categoryComaplints[
                                            "Gandhi Smriti Chhatravas(Extension)"] =
                                        isSwitched19;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title:
                                  Text('Gandhi Smriti Chhatravas(Extension)'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched20,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched20 = value;
                                    categoryComaplints[
                                            "IIT (BHU) Girls Hostel"] =
                                        isSwitched20;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('IIT (BHU) Girls Hostel'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched21,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched21 = value;
                                    categoryComaplints["S. C. Dey"] =
                                        isSwitched21;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('S. C. Dey'),
                            ),
                            ListTile(
                              leading: Switch(
                                value: isSwitched22,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched22 = value;
                                    categoryComaplints["IIT Boys (Saluja)"] =
                                        isSwitched22;
                                    _filter.notifyListeners();
                                  });
                                },
                                activeTrackColor: Colors.grey[800],
                                activeColor: Colors.white,
                              ),
                              title: Text('IIT Boys (Saluja)'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    color: Color(0xFF181D3D),
                    thickness: 0.5,
                    indent: 15.0,
                    endIndent: 15.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Color(0xFF181D3D),
                    ),
                    title: Text('About'),
                    onTap: () => {Navigator.pushNamed(context, '/about')},
                  ),
                  Divider(
                    height: 0.5,
                    color: Color(0xFF181D3D),
                    thickness: 0.5,
                    indent: 15.0,
                    endIndent: 15.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.reply,
                      color: Color(0xFF181D3D),
                    ),
                    title: Text('Log Out'),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      await GoogleSignIn().signOut();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

//////////////////////////////////////////////////////////////////////////////
// code for bookmarks page

var user = FirebaseAuth.instance.currentUser;

class ComplaintList extends StatefulWidget {
  @override
  _ComplaintListState createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<String>>.value(
      value: getComplaintId,
      child: ComplaintTile1(),
    );
  }
}

List<String> getComplaints(DocumentSnapshot snapshot) {
  print(snapshot.data());
  return List.from(snapshot['bookmarked']);
}
// class Comp {
//   String title;
//   String category;
//   String description;
//   Timestamp filingTime;
//   String status;
//   // List<String> upvotes = [];
//   String email;
// }

Stream<List<String>> get getComplaintId {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get()
      .then((snapshot) {
    try {
      return getComplaints(snapshot);
    } catch (e) {
      print(e);
      return null;
    }
  }).asStream();
}

class ComplaintTile1 extends StatefulWidget {
  @override
  _ComplaintTile1State createState() => _ComplaintTile1State();
}

class _ComplaintTile1State extends State<ComplaintTile1> {
  //var arr = new List<Comp>();
  @override
  Widget build(BuildContext context) {
    final complaintIds = Provider.of<List<String>>(context) ?? [];

    return ListView.builder(
      itemCount: complaintIds.length,
      itemBuilder: (context, index) {
        Future<QuerySnapshot> ref = FirebaseFirestore.instance
            .collection('complaints')
            // .orderBy('filing time', descending: true)
            .where(FieldPath.documentId, isEqualTo: complaintIds[index])
            .get();

        // ref.then((value) => value.docs.forEach((element) {
        //   var ss = element.data();
        //   Comp c = new Comp();
        //   c.title = ss['title'];
        //   c.category = ss['category'];
        //   c.description = ss['description'];
        //   c.filingTime = ss['filing time'];
        //   c.status = ss['status'];
        //   c.email = ss['email'];
        //   arr.add(c);
        //   arr.sort((x,y) => y.filingTime.compareTo(x.filingTime));
        // }));

        return FutureBuilder(
          future: ref.then((value) => value.docs[0]),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
            switch (user.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start.');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Text('Awaiting result...');
              case ConnectionState.done:
                if (user.hasError)
                  return Container(
                    width: 0.0,
                    height: 0.0,
                  );
                return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11)),
                    child: Container(
                      // TODO: Adjust height according to generator function
                      height: 210,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(300),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  ComplaintDialog(user.data.id));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(children: [
                                        Text(user.data["title"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18))
                                      ]),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Posted by ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            user.data['email'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.bookmark_border),
                                      onPressed: () {
                                        //TODO: Add color change
                                      })
                                ],
                              ),
                              SizedBox(height: 7),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(Icons.calendar_today),
                                    Text(
                                      DateFormat.yMMMMd()
                                          .format(
                                              user.data['filing time'].toDate())
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(' in '),
                                    Text(
                                      user.data["category"],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      user.data["description"],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 7),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    width: 70,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(user.data["status"],
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: user.data["status"] ==
                                                        'Pending'
                                                    ? Colors.red
                                                        .withOpacity(0.6)
                                                    : user.data["status"] ==
                                                            'Passed'
                                                        ? Colors.blue
                                                        : Colors.green,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
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
                                  ),
                                  Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.share),
                                        onPressed: () {},
                                      ),
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
                                      IconButton(
                                        icon: Icon(Icons.arrow_upward),
                                        onPressed: () {},
                                      ),
                                      Text(
                                        user.data['upvotes'].length.toString(),
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
                      ),
                    ));
            }
            return null; // unreachable
          },
        );
      },
    );
  }
}