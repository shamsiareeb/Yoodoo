import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/home_screen.dart';
import 'dialogues.dart';

class Taskboard extends StatefulWidget{
  @override
  _TaskboardState createState() => new _TaskboardState();
}

class _TaskboardState extends State<Taskboard> {

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        title: new Text("Taskboard",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
         ownerFlag == true ? new Row(
           children: <Widget>[
             Padding(
               padding: EdgeInsets.only(right: 25.0),
               child: GestureDetector(
                 onTap: (){
                   popupNoRewardsWarning(context);
                 },
                 child: Icon(
                     Icons.add
                 ),
               ),
             ),
              Padding(
               padding: EdgeInsets.only(right: 25.0),
               child: GestureDetector(
                 onTap: (){
                   popupNoRewardsWarning(context);
                 },
                 child: Icon(
                     Icons.info
                 ),
               ),
             ),
           ],
         ) :
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: GestureDetector(
              onTap: (){
                popupNoRewardsWarning(context);
              },
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