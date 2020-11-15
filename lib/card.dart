import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loading.dart';

var user = FirebaseAuth.instance.currentUser;

class Category {
  String name;
  IconData iconName;
  String text;

  Category({this.name, this.iconName, this.text});
}

List<Category> categories = [
  Category(name: 'Room no.', iconName: Icons.person_pin, text: 'C-304'),
  Category(
      name: 'Hostel Name',
      iconName: Icons.location_on,
      text: 'Ramanujan Hostel'),
];

final List<String> hostels = [
  'C.V. Raman',
  'Morvi',
  'Dhanrajgiri',
  'Rajputana',
  'Limbdi',
  'Vivekanand',
  'Vishwakarma',
  'Vishweshvaraiya',
  'Aryabhatt-I',
  'Aryabhatt-II',
  'S.N. Bose',
  'Ramanujan',
  'Gandhi Smriti Chhatravas (OLD)',
  'Gandhi Smriti Chhatravas (Extension)',
  'IIT (BHU) Girls’ Hostel',
  'S.C. Dey Girls',
];

class CardCategory extends StatefulWidget {
  @override
  _CardCategoryState createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  Future<void> editList1(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(
                children: [
                  Text('Edit '),
                  Text(categories[0].name),
                ],
              ),
              content: TextField(
                controller: customController,
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .update({'roomNo': customController.text.toString()});
                    });

                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Save'),
                )
              ]);
        });
  }

  Future<void> editList2(BuildContext context, String hostelname) {
    return showDialog(
        context: context,
        builder: (context) {
          return EditHostel(hostelname: hostelname);
        });
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .asStream(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
          switch (user.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Loading();
            case ConnectionState.done:
              if (user.hasError) return Text('Error: ${user.error}');
              var hostel = user.data['hostel'];
              return Column(
                children: [
                  Card(
                    elevation: 5.0,
                    margin: EdgeInsets.symmetric(
                        horizontal: query.size.width / 14,
                        vertical: query.size.height / 80),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(categories[0].name,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: 'Roboto',
                                  )),
                              SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Icon(categories[0].iconName),
                                  SizedBox(width: 5.0),
                                  Text(user.data['roomNo'],
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Roboto',
                                      )),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                editList1(context);
                              },
                              icon: Icon(Icons.edit, color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    margin: EdgeInsets.symmetric(
                        horizontal: query.size.width / 14,
                        vertical: query.size.height / 80),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(categories[1].name,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: 'Roboto',
                                  )),
                              SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Icon(categories[1].iconName),
                                  SizedBox(width: 5.0),
                                  Text(user.data['hostel'],
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Roboto',
                                      )),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                editList2(context, user.data['hostel'])
                                    .then((value) => setState(() {}));
                              },
                              icon: Icon(Icons.edit, color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
          return null;
        });
  }
}

class EditHostel extends StatefulWidget {
  String hostelname;
  EditHostel({Key key, @required this.hostelname}) : super(key: key);
  @override
  _EditHostelState createState() => _EditHostelState(hostelname);
}

class _EditHostelState extends State<EditHostel> {
  String hostelname;
  _EditHostelState(this.hostelname);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          children: [
            Text('Edit '),
            Text(categories[1].name),
          ],
        ),
        content: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: hostels
                      .map((e) => RadioListTile(
                            title: Text(e),
                            value: e,
                            groupValue: hostelname,
                            onChanged: (value) {
                              if (value != hostelname) {
                                setState(() {
                                  hostelname = value;
                                });
                              }
                            },
                            selected: hostelname == e,
                          ))
                      .toList(),
                ))),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            elevation: 5.0,
            child: Text('Cancel'),
          ),
          MaterialButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .update({'hostel': hostelname});

              Navigator.of(context).pop();
            },
            elevation: 5.0,
            child: Text('Save'),
          )
        ]);
  }
}
