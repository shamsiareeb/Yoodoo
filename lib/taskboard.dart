import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/create_instances.dart';
import 'package:yoodoo/create_task.dart';
import 'package:yoodoo/group_details.dart';
import 'package:yoodoo/home_screen.dart';
import 'package:yoodoo/load_tasks.dart';
import 'dialogues.dart';
import 'load_groups.dart';
import 'login_screen.dart';

class Taskboard extends StatefulWidget{
  @override
  _TaskboardState createState() => new _TaskboardState();
}

class _TaskboardState extends State<Taskboard> {

  //int number = tasks.length;
  int index;
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
             Padding(
               padding: EdgeInsets.only(right: 25.0),
               child: GestureDetector(
                 onTap: (){
                   Navigator.push(context,
                     MaterialPageRoute (builder: (context) => CreateTask()),
                   );
                 },
                 child: Align(
                   alignment: Alignment.center,
                   child: Text('CLAIM REWARDS',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ),
               ),
             ),
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GroupDetails()));
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
            tasks.length == 0 ? new Container(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
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
                    padding: EdgeInsets.fromLTRB(10,75,10,75),
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Card(
                      elevation: 5,
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 5.0,
                                color: tpc[index]
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0, bottom: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(taskNames[index],
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
                                          child: Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.lightGreen,
                                              borderRadius: BorderRadius.all(Radius.circular(45.0)),
                                            ),
                                            child: GestureDetector(
                                              onTap: () async {
                                                popupWait(context);
                                                await updateTaskAttributes(index);
                                                await addToMyTasks(index);
                                                Navigator.of(context).pop();//pops popupWait
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.arrow_downward,
                                                    color: Colors.white,
                                                  ),
                                                  Text('ACCEPT',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
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
            ),
          ],
        ),
      ),
      floatingActionButton: ownerFlag == true ? new FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute (builder: (context) => CreateTask()),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ): new Container(),
      /*body: Container(
        child: new Center(
            child: new Text('No tasks to show')
        ),
      ),*/
    );
  }
  Future <void> updateTaskAttributes(int index) async{
    CollectionReference taskCollection = Firestore.instance.collection('groups/'+groups[groupIndex]+'/tasks');
    await taskCollection.document(tasks[index]).updateData({
      'taskStatus': 1,
      'taskAcceptor': user.uid
    });
  }

  Future <void> addToMyTasks(int index) async{
    String taskPath = 'groups/'+ groups[groupIndex]+'/tasks'+tasks[index];
    await usersCollection.document(user.uid).updateData({
      'myTasks': FieldValue.arrayUnion([taskPath])
    });
  }
}