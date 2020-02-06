import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'dart:async' show Timer;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/home_screen');
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: _myWidget(context),
                ),
              )
            ]
        )
    );
  }
}

Widget _myWidget(BuildContext context) {
  String myString = 'Yoodoo';
  print(myString);
  return Text(
    myString,
    style: TextStyle(
      fontSize: 30.0,
      fontFamily: 'TypoHoop',
    ),
  );
}