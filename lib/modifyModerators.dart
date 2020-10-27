import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();

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
              onPressed: () {
                //TODO: Edit function for backend POST request
                if (_formKey.currentState.validate()) {
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
    return Scaffold(
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
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Moderators',
                  style: Theme.of(context).textTheme.headline5,
                )),
            Divider(
              color: Colors.black,
            ),
            FutureBuilder<DocumentSnapshot>(
              future: users.doc(FirebaseAuth.instance.currentUser.uid).get(),
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
                  String category = snapshot.data.data()['category'];
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    .update(
                                                        {'type': 'student'});
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
            RaisedButton(
              child: Text('Add'),
              color: Color(0xFFF49F1C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              onPressed: () {
                _showDialog();
              },
            )
          ],
        ),
      ),
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
