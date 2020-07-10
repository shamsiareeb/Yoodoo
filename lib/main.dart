import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/configure_rewards.dart';
import 'package:yoodoo/create_task.dart';
import 'package:yoodoo/group_details.dart';
import 'package:yoodoo/home_screen.dart';
import 'package:yoodoo/profile_screen.dart';
import 'package:yoodoo/splash_screen.dart';
import 'package:yoodoo/task_details.dart';
import 'package:yoodoo/taskboard.dart';
import 'login_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yoodoo',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),
      home:SplashScreen(),
    );
  }
}