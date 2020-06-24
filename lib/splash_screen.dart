import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/home_screen.dart';
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
    FirebaseAuth.instance.currentUser().then((currentUser) {
      if(currentUser != null) {
        user = currentUser;
        defineUI();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),);
      }
      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreenUI()),
        );
      }
    });
    //new Timer(const Duration(seconds: 2), onClose);
  }

  void onClose() {
    /*Navigator.of(context).pushReplacement(new PageRouteBuilder(
        maintainState: true,
        opaque: true,
        pageBuilder: (context, _, __) => new LoginScreenUI(),
    ));*/
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreenUI()),
    );
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
      fontSize: 50.0,
      fontFamily: 'TypoHoop',
    ),
  );
}
