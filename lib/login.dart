import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool loginChange = true;
  bool registerChange = true;
  bool loginStateChange() {
    setState(() {
      loginChange = !loginChange;
    });
    return loginChange;
  }

  bool registerStateChange() {
    setState(() {
      registerChange = !registerChange;
    });
    return registerChange;
  }

  Future<void> _handleButtonClick() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Internet Connection'),
            content: SingleChildScrollView(
              child: Text(
                  "You need to have an active internet connection to access this. Please try again later."),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    // Start Authentication Process
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final String email = googleUser.email;
    if (email.substring(email.length - 11) != 'itbhu.ac.in') {
      await GoogleSignIn().signOut();
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.error),
                Text(' Sorry!'),
              ],
            ), //
            content: SingleChildScrollView(
              child: Text(
                  "This email doesn't seem to belong to the IIT BHU domain. Please try again with your institute email"),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential _currentUser =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (_currentUser.additionalUserInfo.isNewUser) {
      // The user is just created
      Navigator.pushNamed(context, '/register');
    } else {
      // The user is already there, so redirect to feed
      Navigator.pop(context);
      Navigator.pushNamed(context, '/navigation');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment(0.0, 0.0),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/login_finalfinal.jpg"), //adding background image
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListView(children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),

                // code for separately attaching logo and title of app on the background
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Image.asset("assets/app_logo_final0.png",
                //       height: 300, width: 300, fit: BoxFit.fill,
                //     ),
                //     Text(
                //       "InstiComplaints",
                //       style: TextStyle(
                //         fontFamily: 'Amaranth',
                //         fontSize: 20.0,
                //         fontWeight: FontWeight.w500,
                //         decoration: TextDecoration.none,
                //         color: Color(0xFF181D3D),
                //       ),
                //     ),
                //   ],
                // ),

                SizedBox(
                  height: 500.0,
                ),

                Container(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(48.0, 12.0, 48.0, 9.0),
                    elevation: 20.0,
                    shape: loginChange
                        ? RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 3.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0)))
                        : RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.transparent, width: 3.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0))),
                    color: loginChange ? Colors.transparent : Color(0xFFF49F1C),
                    onPressed: () {
                      loginStateChange();
                      _handleButtonClick();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontFamily: 'JosefinSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: loginChange ? Colors.white : Color(0xFF181D3D),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34.0, 12.0, 34.0, 9.0),
                  elevation: 20.0,
                  shape: registerChange
                      ? RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 3.0),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)))
                      : RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0))),
                  color:
                      registerChange ? Colors.transparent : Color(0xFFF49F1C),
                  onPressed: () {
                    registerStateChange();
                    _handleButtonClick();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'JosefinSans',
                        fontSize: 18.0,
                        color:
                            registerChange ? Colors.white : Color(0xFF181D3D),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
//.only(topLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)) -- differently shaped button
