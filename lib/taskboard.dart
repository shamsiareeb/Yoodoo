//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/create_task.dart';
import 'package:yoodoo/home_screen.dart';
import 'dialogues.dart';

class Taskboard extends StatefulWidget{
  @override
  _TaskboardState createState() => new _TaskboardState();
}

class _TaskboardState extends State<Taskboard> {

  int number = 5;

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
                   Navigator.push(context, MaterialPageRoute (builder: (context) => CreateTask()),
                   );
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              //margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
              height: MediaQuery.of(context).size.height*0.85,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: number,
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.fromLTRB(10,10,10,0),
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Card(
                      elevation: 5,
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3.0,
                                color: Colors.redAccent,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                        ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      /*body: Container(
        child: new Center(
            child: new Text('No tasks to show')
        ),
      ),*/
    );
  }
}