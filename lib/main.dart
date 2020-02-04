import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
      primaryColor: Colors.red,
      accentColor: Colors.yellowAccent),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
));