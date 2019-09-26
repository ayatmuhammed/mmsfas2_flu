import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mmsfas2_flu/SplashScreen/loader.dart';
import 'Intro_Slider/IntroSliderPage.dart';
import 'Lectures_stu/Lectures_list.dart';
import 'LoginPages/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
 bool firstRun;
 const firstRunKey= 'firstRun';

List<CameraDescription> cameras;
 Future<void> main() async {
   SharedPreferences ref= await SharedPreferences.getInstance();
   firstRun=ref.getBool(firstRunKey)?? true;
   ref.setBool(firstRunKey, false);

  cameras = await availableCameras();
  runApp(
      MyApp()
  );

}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder<Widget>(
          future: firstPage(),
          builder:
            (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState== ConnectionState.waiting){
            return Center(child: SpinKitDoubleBounce(color: Colors.indigo,));
          }

          return snapshot.data;
        },

        ),
    routes: <String ,WidgetBuilder>{
    '/landingpage':(BuildContext context)=> MyApp(),
    '/register':(BuildContext context)=> LoginSignIn(),
    '/homepage':(BuildContext context)=> Homepage(),
//      '/Myslider':(BuildContext context)=> Slider(),
    }
    );
    }

    Future<Widget> firstPage() async {
      if(firstRun){
        return SplashScreen();
      }

      var user =  await FirebaseAuth.instance.currentUser();
      if(user == null){
        return LoginSignIn();
      }

      return HomePage();
    }
}

// native splash screen