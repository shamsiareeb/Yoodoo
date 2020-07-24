import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yoodoo/create_instances.dart';
import 'package:yoodoo/dialogues.dart';
import 'package:yoodoo/home_screen.dart';
import 'package:yoodoo/load_tasks.dart';
import 'load_groups.dart';
import 'login_screen.dart';

class TaskDetails extends StatefulWidget {
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: true,
        title: new Text('Task Details',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(18.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Group Name",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      //height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Text(myTasks[taskDetailsIndex].substring(7,18),//group name
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.5,
                      indent: 25,
                      endIndent: 25,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Task Name",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      //height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Text(myTaskNames[taskDetailsIndex],//task name
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.5,
                      indent: 25,
                      endIndent: 25,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Task Description",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      //height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Text(taskDescriptions[taskDetailsIndex],//task description
                        style: TextStyle(
                            fontSize: 16,
                          fontWeight: FontWeight.w400
                        ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.5,
                      indent: 25,
                      endIndent: 25,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(18.0),
                child: InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(
                        'CLAIM YOODOOS',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                        color: Colors.green,
                      ),
                    ),
                    onTap: () {

                    }
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(22, 0, 22, 100),
                child: InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(
                        'REJECT TASK',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.red),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                        border: Border.all(
                          color: Colors.red,
                        )
                      ),
                    ),
                    onTap: () async{
                      popupWait(context);
                      String g = myTasks[taskDetailsIndex];
                      int i = groups.indexOf(g.substring(7,17));

                      if(mytpc[i] == Colors.redAccent) {
                        myYoodoos[i] = myYoodoos[i] - 4;
                      }
                      else if (mytpc[i] == Colors.orangeAccent){
                        myYoodoos[i] = myYoodoos[i] - 2;
                      }
                      else{
                        myYoodoos[i] = myYoodoos[i] - 1;
                      }

                      Map <String, int> GroupsYoodoos = new Map.fromIterables(groups, myYoodoos);
                      await usersCollection.document(user.uid).updateData({
                        'myTasks': FieldValue.arrayRemove([myTasks[taskDetailsIndex]]),
                        'groups&yoodoos': GroupsYoodoos
                      });

                      print('Groups[groupIndex]= '+ groups[groupIndex]);
                      CollectionReference tasksCollection = Firestore.instance.collection('groups/'+groups[groupIndex]+'/tasks');
                      await tasksCollection.document(g.substring(24)).updateData({
                        'taskAcceptor': '000',//000 stands for null
                        'taskStatus': 0// 0 stands for null, 1 for accepted, 2 for claimed reward
                      });

                      await loadMyTasks();
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}