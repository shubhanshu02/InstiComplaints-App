import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();
String category;

class ModifyModerators extends StatefulWidget {
  @override
  _ModifyModeratorsState createState() => _ModifyModeratorsState();
}

class _ModifyModeratorsState extends State<ModifyModerators> {
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Add Moderator"),
          content: new SingleChildScrollView(
              child: Column(
            children: [
              Text(
                "Note: The student must be already registered on the App",
                style: Theme.of(context).textTheme.caption,
              ),
              AddModeratorForm(),
            ],
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Add"),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .where('email', isEqualTo: _emailController.text)
                      .get()
                      .then((QuerySnapshot querySnapshot) async {
                    if (_emailController.text ==
                        FirebaseAuth.instance.currentUser.email) {
                      return errorDialog(
                          context, 'You cannot change your own User type');
                    }
                    if (querySnapshot.docs.length == 0) {
                      return errorDialog(
                          context, 'No User with this Email Found.');
                    }
                    Map<String, dynamic> data = querySnapshot.docs.first.data();
                    if (data['category'] != category) {
                      return errorDialog(context,
                          'You can only add moderators for your category.');
                    }
                    if (data['type'] == 'moderator') {
                      return errorDialog(context,
                          'The given user is already a moderator in some category');
                    }
                    String uid = data['uid'];
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .update({'type': 'moderator', 'category': category});
                  });
                  _emailController.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Container(
      color: Color(0xFF181D3D),
/*      Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF181D3D),
        title: Text(
          'Manage Moderators',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.white),
        ),
        leading: Icon(Icons.arrow_back_ios),
      ),*/
      child: SafeArea(
          child: Scaffold(
              body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.20,
                right: 30,
                left: 30),
            child: Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                  future:
                      users.doc(FirebaseAuth.instance.currentUser.uid).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data.data()['type'] != 'admin') {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'You are no longer an Admin',
                            overflow: TextOverflow.visible,
                          ),
                        );
                      }
                      category = snapshot.data.data()['category'];
                      return StreamBuilder(
                        stream: users
                            .where('category', isEqualTo: category)
                            .where('type', isEqualTo: 'moderator')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> query) {
                          if (query.hasError) {
                            return Text("Something went wrong");
                          }
                          if (query.connectionState == ConnectionState.waiting)
                            return Center(child: CircularProgressIndicator());

                          List<Widget> listofModerators = [];
                          query.data.docs.forEach((doc) {
                            listofModerators.add(Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.5)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 15, top: 6),
                                          child: Text(
                                            doc['name'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 15, bottom: 6),
                                            child: Text(
                                              doc['email'],
                                              style: TextStyle(fontSize: 12),
                                            ))
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: new Text("Confirmation!"),
                                            content: Text(
                                              "Do you really want to remove ${doc['name']} from Moderator of ${category.toString().toUpperCase()} category?",
                                            ),
                                            actions: <Widget>[
                                              new FlatButton(
                                                  child: new Text("Yes"),
                                                  onPressed: () async {
                                                    await users
                                                        .doc(doc['uid'])
                                                        .update({
                                                      'type': 'student'
                                                    });
                                                  }),
                                              new FlatButton(
                                                child: new Text("No"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.remove_circle_outline,
                                      size: 21,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ));
                          });
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: (listofModerators.length != 0)
                                  ? listofModerators
                                  : [
                                      Container(
                                          child: Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        size: 60,
                                      )),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          'No Moderator Found for Your Category',
                                          overflow: TextOverflow.visible,
                                        ),
                                      )
                                    ],
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      child: Text('Add'),
                      color: Color(0xFFF49F1C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      onPressed: () {
                        _showDialog();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 5.0,
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/app_logo_final_jpg_ws.jpg'),
                            radius: 25.0,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'InstiComplaints',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Amaranth'),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 25),
                      Container(
                          child: Text(
                        'Manage Moderators',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      )),
                    ],
                  ),
                )),
          ),
        ],
      ))),
    );
  }
}

class AddModeratorForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
              focusNode: FocusNode(),
              validator: (String value) {
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(value))
                  return 'Enter Valid Email';
                else if (value.substring(value.length - 11) != 'itbhu.ac.in')
                  return 'Enter Valid Institute Email';
                else
                  return null;
              },
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                labelText: 'Email',
              ))
        ],
      ),
    );
  }
}

dynamic errorDialog(context, String message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Warning!"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: new Text("Okay"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
          3.14,
          -3.14 / 2)
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
