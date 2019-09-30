import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mmsfas2_flu/Intro_Slider/IntroSliderPage.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final duration= Duration(seconds: 3);
  @override
  void initState() {
    super.initState();
    Timer(duration, ()=> Navigator.push(context, MaterialPageRoute(builder :(context)=> MySlider())));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SpinKitPouringHourglass(
            color: Colors.indigo,
            size: 80.0,
            duration: duration ,
          ),

        ),

      ),

    );

  }
}