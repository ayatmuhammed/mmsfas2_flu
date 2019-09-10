import 'dart:async';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mmsfas2_flu/main.dart';
import 'package:path_provider/path_provider.dart';
class ScanScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraApp(),
    );
  }
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;
  Timer _timer;
  String _barcodeRead = "";

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});

      _startTimer();
    });
  }

  void _startTimer() {
    _timer = new Timer(Duration(seconds: 3), _timerElapsed);
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  Future<void> _timerElapsed() async {
    _stopTimer();

    File file = await _takePicture();
    await _readBarcode(file);
    _startTimer();
  }

  Future _readBarcode(File file) async {
    FirebaseVisionImage firebaseImage = FirebaseVisionImage.fromFile(file);
    final BarcodeDetector barcodeDetector = FirebaseVision.instance
        .barcodeDetector();

    final List<Barcode> barcodes = await barcodeDetector.detectInImage(
        firebaseImage);

    _barcodeRead = "";
    for (Barcode barcode in barcodes) {
      _barcodeRead += barcode.rawValue + ", ";
    }
    setState(() {});
  }

//}
  Future<File> _takePicture() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/barcode';
    await Directory(dirPath).create(recursive: true);
    final File file = new File('$dirPath/barcode.jpg');

    if (await file.exists())
      await file.delete();

    await controller.takePicture(file.path);
    return file;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AspectRatio(
            aspectRatio:
            controller.value.aspectRatio,
            child: CameraPreview(controller)
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Text(
              _barcodeRead.length > 0 ? _barcodeRead : "No Barcode",
              textAlign: TextAlign.center
          ),
        )
      ],
    );
  }
}

//import 'dart:async';
//import 'package:barcode_scan/barcode_scan.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//
//class ScanScreen extends StatefulWidget {
//  @override
//  _ScanState createState() => new _ScanState();
//}
//
//class _ScanState extends State<ScanScreen> {
//  String barcode = "";
//
//  @override
//  initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: new AppBar(
//          backgroundColor: Colors.indigo,
//          title: new Text('take a scaner'),
//        ),
//        body: new Center(
//          child: new Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.end,
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                child: RaisedButton(
//                    color: Colors.indigo,
//                    textColor: Colors.white,
//                    splashColor: Colors.blueGrey,
//                    onPressed: scan,
//                    child: const Text('START CAMERA SCAN')
//                ),
//              )
//              ,
//              Padding(
//                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                child: Text(barcode, textAlign: TextAlign.center,),
//              )
//              ,
//            ],
//          ),
//        ));
//  }
//  Future scan() async {
//    try {
//      String barcode = await BarcodeScanner.scan();
//      setState(() => this.barcode = barcode);
//    } on PlatformException catch (e) {
//      if (e.code == BarcodeScanner.CameraAccessDenied) {
//        setState(() {
//          this.barcode = 'The user did not grant the camera permission!';
//        });
//      } else {
//        setState(() => this.barcode = 'Unknown error: $e');
//      }
//    } on FormatException{
//      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
//    } catch (e) {
//      setState(() => this.barcode = 'Unknown error: $e');
//    }
//  }
//}
