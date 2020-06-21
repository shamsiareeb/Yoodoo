import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/group.dart';
import 'package:yoodoo/login_screen.dart';
import 'package:yoodoo/profile_screen.dart';
import 'package:yoodoo/signup_screen.dart';
import 'package:yoodoo/home_screen.dart';
import 'splash_screen.dart';
import 'package:yoodoo/group_info.dart';

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