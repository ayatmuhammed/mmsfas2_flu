import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'Lectures_stu/Lectures_list.dart';
import 'LoginPages/signin.dart';
import 'Qr_ScanPages/BarCode.dart';

List<CameraDescription> cameras;
 Future<void> main() async {
  cameras = await availableCameras();
  runApp(
      MyApp()
  );

}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: new   ScanScreen(),
    routes: <String ,WidgetBuilder>{
    '/landingpage':(BuildContext context)=> MyApp(),
    '/register':(BuildContext context)=> Login_SigninPage(),
    '/homepage':(BuildContext context)=> Homepage(),
      //'/slider':(BuildContext context)=> Slider(),
    }
    );
    }

}

