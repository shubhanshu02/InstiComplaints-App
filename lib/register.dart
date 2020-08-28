import 'package:InstiComplaints/modals.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// TODO: Controllers for Text Fields
// TODO: Verification that none is empty

class BackgroundMaker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(),
              color: Colors.white,
              child: RegisterPage(),
            ),
            ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  constraints: BoxConstraints.expand(),
                  color: Color(0xFF181D3D),
                  child: Column(children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 8),
                    Text(
                      'Sign Up',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .apply(color: Colors.white),
                    )
                  ]),
                )),
          ],
        ));
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..lineTo(0, size.width / 4)
      ..addArc(
          Rect.fromLTWH(0, size.width / 512, size.width / 2, size.width / 2),
          pi,
          -pi / 2)
      ..lineTo(4 * size.width / 4, size.width / 2)
      ..addArc(
          Rect.fromLTWH(2 * size.width / 4, size.width / 2, size.width / 2,
              size.width / 2),
          3.14 + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 4);
    return path;
  }

  @override
  bool shouldReclip(oldCliper) => false;
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: ListView(children: [
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              RegisterForm()
            ])));
  }
}


class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String hostelname;
  final _nameController = TextEditingController();
  final _rollNoController = TextEditingController();
  final _roomNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  void formProcessor() {
    UserModal _currentDetails = UserModal(_nameController.text, int.parse(_rollNoController.text), hostelname, int.parse(_roomNoController.text));
    // TODO: Send to backend server
  }


  void _showDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF181D3D)),
          ),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text(" Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Name cannot be left Empty';
                  }
                  return null;
                },
                controller: _nameController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  labelText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == "") {
                    return 'Roll Number cannot be left Emply';
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return '"$value" is not a valid number';
                  }
                  return null;
                },
                controller: _rollNoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Roll Number',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.black.withOpacity(0.3)),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Container(
                      padding: EdgeInsets.symmetric(horizontal: 11),
                      child: Text(
                        'Hostel',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 16),
                      ),
                    ),
                    value: hostelname,
                    onChanged: (String newValue) {
                      setState(() {
                        hostelname = newValue;
                      });
                    },
                    isExpanded: true,
                    style: Theme.of(context).textTheme.bodyText1,
                    items: <String>[
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
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 11),
                          child: Text(
                            value,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 16),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Room Number cannot be left Empty';
                  }
                  return null;
                },
                controller: _roomNoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  labelText: 'Room',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 45,
                child: RaisedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.

                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                      _showDialog(context);
                      formProcessor();
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  highlightElevation: 5,
                  color: Color(0xFF181D3D),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 170,
                width: 170,
                child: Image.asset(
                  "assets/app_logo.png",
                ),
              ),
              Text('© InstiComplaints',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ],
          )
        ],
      ),
    );
  }

}
