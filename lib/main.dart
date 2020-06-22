import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yoodoo',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),
      home:LoginScreenUI(),
    );
  }
}