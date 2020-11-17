import 'package:InstiComplaints/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'st_profile.dart';
import 'ad_profile.dart';
import 'filed.dart';
import 'resolved.dart';
import 'Compose.dart';
import 'notifications.dart';
import 'navigation.dart';
import 'login.dart';
import 'aboutPage.dart';
import 'admin_pending_complaints.dart';
import 'admin_resolved_complaints.dart';

class InstiComplaints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(title: 'InstiComplaints', routes: {
      '/ad_pending': (context) => AdPending(),
      '/ad_resolved': (context) => AdResolved(),
      '/filed': (context) => Filed(),
      '/resolved': (context) => Resolved(),
      '/st_profile': (context) => Profile(),
      '/ad_profile': (context) => AdProfile(),
      '/compose': (context) => Compose(),
      '/notifications': (context) => Notifications(),
      '/navigation': (context) => User1(),
      '/register': (context) => RegisterPage(),
      '/': (context) =>
          (FirebaseAuth.instance.currentUser == null) ? MyLoginPage() : User1(),
      '/about': (context) => AboutPage()
    });
  }
}
