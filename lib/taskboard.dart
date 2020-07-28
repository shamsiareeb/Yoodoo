import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:yoodoo/create_instances.dart';
import 'package:yoodoo/create_task.dart';
import 'package:yoodoo/group_details.dart';
import 'package:yoodoo/home_screen.dart';
import 'package:yoodoo/load_tasks.dart';
import 'package:yoodoo/dialogues.dart';
import 'package:yoodoo/load_groups.dart';
import 'package:yoodoo/login_screen.dart';
import 'package:yoodoo/claim_rewards.dart';

class Taskboard extends StatefulWidget{
  @override
  _TaskboardState createState() => new _TaskboardState();
}

class _TaskboardState extends State<Taskboard> {

  //int number = tasks.length;
  int index;
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: true,
        title: new Text("Taskboard",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
             Padding(
               padding: EdgeInsets.only(right: 25.0),
               child: GestureDetector(
                 onTap: (){
                   Navigator.push(context,
                     MaterialPageRoute (builder: (context) => ClaimRewardsPage()),
                   );
                 },
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text('CLAIM',
                       style: TextStyle(
                         fontWeight: FontWeight.w400,
                         color: Colors.black,
                       ),
                     ),
                     Text('REWARDS',
                       style: TextStyle(
                         fontWeight: FontWeight.w400,
                         color: Colors.black,
                       ),
                     ),
                   ],
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
              padding: EdgeInsets.fromLTRB(0, 50, 0, 16),
              height: MediaQuery.of(context).size.height*0.85,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.fromLTRB(16,75,5,75),
                    width: MediaQuery.of(context).size.width*0.8,
                    child: GestureDetector(
                      child: Container(

                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 2,
                              color: tpc.elementAt(index)
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0, bottom: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(taskNames.elementAt(index),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                    ),),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  //flex: 3,
                                  child: Text(taskDescriptions.elementAt(index),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),),
                                ),
                                Expanded(
                                  child: SizedBox(),
                                ),
                                Container(
                                  child: _status(index),
                                ),
                              ],
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
  Future <void> updateAfterAcceptTaskAttributes(int index) async{
    CollectionReference taskCollection = Firestore.instance.collection('groups/'+groups[groupIndex]+'/tasks');
    await taskCollection.document(tasks[index]).updateData({
      'taskStatus': 1,// 1 for accepted
      'taskAcceptor': userName
    });
  }

  Future <void> addToMyTasks(int index, String userid) async{
    String taskPath = ('groups/'+ groups[groupIndex]+'/tasks/'+tasks[index]);
    await usersCollection.document(userid).updateData({
      'myTasks': FieldValue.arrayUnion([taskPath])
    });
  }

  Widget _status(int index){
    if (taskStatuses[index] == 0) {
      return Row(
        children: <Widget>[
          ownerFlag == true ? new Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                border: Border.all(
                  color: Colors.orange,
                  width: 1.0,
                ),
              ),
              child: GestureDetector(
                onTap: ()async{
                  popupWait(context);
                  var memberList = new List();
                  memberList = allGroupMemberUIDs[groupIndex];
                  memberList.shuffle();
                  await updateAfterAcceptTaskAttributes(index);
                  await addToMyTasks(index, memberList.first);
                  await loadMyTasks();
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('ALLOCATE',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ) : Expanded(
            child: SizedBox(),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: GestureDetector(
                onTap: () async {
                  popupWait(context);
                  await updateAfterAcceptTaskAttributes(index);
                  await addToMyTasks(index, user.uid);
                  await defineHomescreenUI();
                  await defineTaskboardUI(groupIndex);
                  Navigator.of(context).pop();//pops popupWait
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Taskboard()),);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('ACCEPT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
    else if(taskStatuses[index]==1){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.done,
            color: Colors.green,
          ),
          Text('This task has been assigned.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      );
    }
    else{// if status = 2, i.e. yoodoos have been claimed
        return Row(
          children: [
            ownerFlag == true ? new Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 35,
                width: 125,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  border: Border.all(
                    color: Colors.green,
                    width: 1.0,
                  ),
                ),
                child: GestureDetector(
                  onTap: ()async{
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('GIVE YOODOOS',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ) : Expanded(
              child: SizedBox(),
            ),
          ],
        );
      }
  }
}