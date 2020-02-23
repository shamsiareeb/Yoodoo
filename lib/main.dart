import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
      //const primaryColor: const Color(0xFF2529052),
      primaryColor: Colors.red,
      accentColor: Colors.yellowAccent),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
));