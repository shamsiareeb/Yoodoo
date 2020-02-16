import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'dart:async' show Timer;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Timer(const Duration(seconds: 2), onClose);
  }

  void onClose() {
    Navigator.of(context).pushReplacement(new PageRouteBuilder(
        maintainState: true,
        opaque: true,
        pageBuilder: (context, _, __) => new LoginScreenUI(),
        /*transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, anim1, anim2, child) {
          return new FadeTransition(
            child: child,
            opacity: anim1,
          );
        }*/
    ));
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