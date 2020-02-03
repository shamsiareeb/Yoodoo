import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MaterialApp(
  theme:
    ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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