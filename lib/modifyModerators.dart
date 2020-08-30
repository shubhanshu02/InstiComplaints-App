import 'package:flutter/material.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();

class ModifyModerators extends StatefulWidget {
  @override
  _ModifyModeratorsState createState() => _ModifyModeratorsState();
}

class _ModifyModeratorsState extends State<ModifyModerators> {
  //TODO: Add a function to fetch the list from backend
  List<String> list = [
    'Mahatma Gandhi',
    "Jeff Bezos",
    'Elon Musk',
    "Steve Jobs"
  ];

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

  List<Widget> prepareModeratorList(context) {
    return list.map((String value) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.5)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        //TODO: Change the number of passes for the moderator based on fetched data
                        '3',
                        style: TextStyle(color: Colors.green, fontSize: 17),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Passed',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () {
                      setState(() {
                        //TODO: Remove entry from the backend too
                        list.remove(value);
                      });
                    },
                    child: Icon(
                      Icons.remove_circle_outline,
                      size: 21,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Color(0xFFF49F1C),
        onPressed: () {
          _showDialog();
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
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
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: prepareModeratorList(context),
              ),
            ),
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
