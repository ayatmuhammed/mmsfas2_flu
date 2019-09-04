import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SpinKitPouringHourglass(
            color: Colors.indigo,
            size: 80.0,
            duration:  Duration(seconds: 5),

          ),

        ),

      ),

    );

  }


}