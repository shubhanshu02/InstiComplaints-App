import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
    await _handleGoogleSignin();
    final User user = FirebaseAuth.instance.currentUser;
    // Times for checking if the user is a new user or not
    final creationTime = user.metadata.creationTime;
    final lastSignin = user.metadata.lastSignInTime;

    if (creationTime == lastSignin) {
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
                    padding: EdgeInsets.fromLTRB(58.0, 12.0, 58.0, 10.0),
                    elevation: 20.0,
                    shape: loginChange
                        ? RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 3.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)))
                        : RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.transparent, width: 3.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
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
                  padding: EdgeInsets.fromLTRB(44.0, 12.0, 44.0, 10.0),
                  elevation: 20.0,
                  shape: registerChange
                      ? RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 3.0),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)))
                      : RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent),
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0))),
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

Future<UserCredential> _handleGoogleSignin() async {
  // Start Authentication Process
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
    
  );
 
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
