import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_sign_in/google_sign_in.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

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

  List<ComplaintBox> _listBuilder() {
    List<ComplaintBox> _list = [];
    for (int i = 0; i < 10; i++) {
      _list.insert(0, ComplaintBox());
    }
    return _list;
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
                      // add contents of the feed page
                      child: ListView.builder(
                          itemBuilder: (_, index) => ComplaintBox())),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 150, bottom: 0),
                  child: Container(
                      // add contents of the bookmark page
                      child: ListView.builder(
                          itemBuilder: (_, index) => ComplaintBox())),
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
                          onPressed: () {},
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
                                padding: const EdgeInsets.fromLTRB(
                                    42.0, 5.0, 42.0, 0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.mode_comment,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                    SizedBox(
                                      height: 1.0,
                                    ),
                                    Text(
                                      'Feed',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 5.0, 25, 0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      height: 1.0,
                                    ),
                                    Text(
                                      'Bookmarks',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
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

// code for the sidebar

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
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

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: NetworkImage('${FirebaseAuth.instance.currentUser.photoURL}'),// AssetImage("assets/profilePic.jpg"),
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
                        'Hi, ${FirebaseAuth.instance.currentUser.displayName}',
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
                          onChanged: (value) {
                            setState(() {
                              isSwitched1 = value;
                              print(isSwitched1);
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
                              print(isSwitched2);
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
                              print(isSwitched3);
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
                              print(isSwitched4);
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
                              print(isSwitched5);
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
                              print(isSwitched6);
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
                              print('Hello');
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
                              print(isSwitched8);
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
                              print(isSwitched9);
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
                              print(isSwitched10);
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
                              print(isSwitched11);
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
                              print(isSwitched12);
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
                              print(isSwitched13);
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
                              print(isSwitched14);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Aryabhatt'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched15,
                          onChanged: (value) {
                            setState(() {
                              isSwitched15 = value;
                              print(isSwitched15);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('S.N.Bose'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched16,
                          onChanged: (value) {
                            setState(() {
                              isSwitched16 = value;
                              print(isSwitched16);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Dr. S. Ramanujan'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched17,
                          onChanged: (value) {
                            setState(() {
                              isSwitched17 = value;
                              print(isSwitched17);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Gandhi Smriti Chatravas (Old)'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched18,
                          onChanged: (value) {
                            setState(() {
                              isSwitched18 = value;
                              print(isSwitched18);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Gandhi Smriti Chatravas(Extension)'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched19,
                          onChanged: (value) {
                            setState(() {
                              isSwitched19 = value;
                              print(isSwitched19);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('IIT Boys (Saluja)'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched20,
                          onChanged: (value) {
                            setState(() {
                              isSwitched20 = value;
                              print(isSwitched20);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('IIT(BHU) Girls'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched21,
                          onChanged: (value) {
                            setState(() {
                              isSwitched21 = value;
                              print(isSwitched21);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('S. C. Dey'),
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
            Divider(
              height: 0.75,
              color: Color(0xFF181D3D),
              thickness: 0.75,
              indent: 15.0,
              endIndent: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}

class ComplaintBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        child: Container(
          // TODO: Adjust height according to generator function
          height: 210,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(300),
            onTap: () {
              //TODO: Add navigator to other card
            },
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 70,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Pending  ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red.withOpacity(0.6),
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
          ),
        ));
  }
}
