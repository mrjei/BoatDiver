import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//device_preview shows phone screen on desktop
import 'package:device_preview/device_preview.dart';

// main function startup

void main() {
  if (kDebugMode) {
    // in debug mode enable device preview
    runApp(DevicePreview(builder: (_) => BoatDiverApp()));
  } else {
    runApp(BoatDiverApp());
  }
}

// main app widget
class BoatDiverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      // Enable device preview
     debugShowCheckedModeBanner: false, //remove debug banner
     title: 'BoatDiver - Login Workflow',
     theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

//logo widget
class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({this.size = 60, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.anchor,
            size: size, color: Theme.of(context).colorScheme.primary),
        SizedBox(width: 10),
        Text('BoatDiver',
            style: TextStyle(
                fontSize: size / 2,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
      ],
    );
  }
}

//splash screen widget
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();
    _ctrl = 
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _ctrl.forward();

    //after delay, goto welcome screen
    _navTimer = Timer(Duration(milliseconds: 900), () {
      if (mounted)
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => WelcomeScreen()));
    });
  }

  @override
  void dispose() {