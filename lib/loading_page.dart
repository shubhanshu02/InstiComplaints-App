import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      child: Scaffold(
        body: Center(
          child: SpinKitChasingDots(color: Color(0xFFFAFAFA)),
          
        ),
      ),
    );
  }
}