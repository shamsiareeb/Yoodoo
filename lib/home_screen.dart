import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('GROUPS',
        style: TextStyle (
          fontFamily: 'AzoSans-Regular',
          fontWeight: FontWeight.w400,
          fontSize: 17.0,
        ),),
        backgroundColor: Color(0xFF2529052),
        leading: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Material(
            shape: new CircleBorder(),
          ),
        ),
      ),
      body: new Center(
        child: new Text('No groups to show'),
      ),
    );
  }
}