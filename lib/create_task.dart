import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yoodoo/create_instances.dart';
import 'package:yoodoo/dialogues.dart';
import 'package:yoodoo/load_tasks.dart';
import 'package:yoodoo/taskboard.dart';
import 'package:yoodoo/validators.dart';
import 'home_screen.dart';
import 'load_groups.dart';

class CreateTask extends StatefulWidget{

  @override
  _CreateTaskState createState() => new _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {

  List radioValues = [2, 4, 8];// low, medium, high priorities
  int _value;// used to store task priority
  String _taskName = "", _taskDescription = "";

  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text("Create Task",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: GestureDetector(
              onTap: () async {
                popupWait(context);
                await createTask();
                Navigator.of(context).pop();// pops popupWait
                Navigator.of(context).pop();// pops CreateTaskScreen
                loadTasksData(groupIndex);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Taskboard()),);
              },
              child: Icon(
                Icons.navigate_next
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Task Name",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onSaved: (input) => _taskName = input,
                      maxLength: 30,
                      maxLines: 1,
                      validator: blankValidator,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: "Max 30 characters",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onSaved: (input) => _taskDescription = input,
                      maxLength: 140,
                      maxLines: 5,
                      validator: blankValidator,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: "Max 140 characters",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Priority Level",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: Container(
                            height: 50,
                            width: double.maxFinite,
                            child: Card(
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.redAccent,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      activeColor: Colors.redAccent,
                                      value: radioValues[2],
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() { _value = value; });
                                      },
                                    ),
                                    Text('High Priority (8 Yoodoos)'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Container(
                            height: 50,
                            width: double.maxFinite,
                            child: Card(
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.orangeAccent,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    //Text('Medium Priority (4 Yoodoos)'),
                                    Radio(
                                      activeColor: Colors.orangeAccent,
                                      value: radioValues[1],
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() { _value = value; });
                                      },
                                    ),
                                    Text('Medium Priority (4 Yoodoos)'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Container(
                            height: 50,
                            width: double.maxFinite,
                            child: Card(
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.greenAccent,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      activeColor: Colors.greenAccent,
                                      value: radioValues[0],
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() { _value = value; });
                                      },
                                    ),
                                    Text('Low Priority (1 Yoodoo)'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future <void> createTask() async{
    await groupsCollection.document(groups[groupIndex]).setData({
      'taskNames': FieldValue.arrayUnion([_taskName]),
      'taskDescriptions': FieldValue.arrayUnion([_taskDescription]),
      'taskPriorities': FieldValue.arrayUnion([_value]),
      'taskAcceptors': FieldValue.arrayUnion([null]),
      'taskStatus': FieldValue.arrayUnion([0]),
    });
  }
}