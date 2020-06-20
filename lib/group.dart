

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Group extends StatefulWidget{
  @override
  _GroupState createState() => new _GroupState();
}

class _GroupState extends State<Group> {

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text("Taskboard",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: GestureDetector(
              onTap: (){},
              child: Icon(
                Icons.info
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: new Center(
            child: new Text('No tasks to show')
        ),
      ),
    );
  }
}