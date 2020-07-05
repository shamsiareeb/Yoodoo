import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/create_task.dart';
import 'package:yoodoo/home_screen.dart';
import 'package:yoodoo/load_tasks.dart';
import 'dialogues.dart';

class Taskboard extends StatefulWidget{
  @override
  _TaskboardState createState() => new _TaskboardState();
}

class _TaskboardState extends State<Taskboard> {

  //int number = tasks.length;

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
            tasks.length == 0?new Container(
              child: new Center(
                  child: new Text('No tasks to show')
              ),
            ):
            Container(
              //margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
              height: MediaQuery.of(context).size.height*0.85,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: tasks.length,
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
                                color: taskPriorities[index]
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(tasks[index],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(taskDescriptions[index],
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.bottomRight,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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