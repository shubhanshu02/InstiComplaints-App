
import 'package:InstiComplaints/register.dart';

import 'package:flutter/material.dart';
import 'st_profile.dart';
import 'ad_profile.dart';
import 'filed.dart';
import 'resolved.dart';
import 'Compose.dart';
import 'notifications.dart';
import 'navigation.dart';
import 'login.dart';
import 'aboutPage.dart';

class InstiComplaints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'InstiComplaints',  routes: {
      '/filed': (context) => Filed(),
      '/resolved': (context) => Resolved(),
      '/st_profile': (context) => Profile(),
      '/ad_profile': (context) => AdProfile(),
      '/compose': (context) => Compose(),
      '/notifications': (context) => Notifications(),
      '/navigation': (context) => BottomNavigation(),
      '/register': (context) => RegisterPage(),
      '/': (context) => MyLoginPage(),
      '/about': (context)=> AboutPage()
    });
  }
}
