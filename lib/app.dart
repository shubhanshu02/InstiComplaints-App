import 'package:flutter/material.dart';
import 'st_profile.dart';

import 'filed.dart';
import 'resolved.dart';

class InstiComplaints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'InstiComplaints', home: Profile(), routes: {
      '/filed': (context) => Filed(),
      '/resolved': (context) => Resolved(),
    });
  }
}
