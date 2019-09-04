import 'package:flutter/material.dart';
import 'Lectures_stu/Lectures_list.dart';
import 'LoginPages/signin.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: new   Login_SigninPage(),
    routes: <String ,WidgetBuilder>{
    '/landingpage':(BuildContext context)=> MyApp(),
    '/register':(BuildContext context)=> Login_SigninPage(),
    '/homepage':(BuildContext context)=> Homepage(),
      //'/slider':(BuildContext context)=> Slider(),
    }
    );
    }

}

