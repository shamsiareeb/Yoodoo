import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_string/random_string.dart';
import 'package:yoodoo/create_instances.dart';
import 'package:yoodoo/dialogues.dart';
import 'package:yoodoo/taskboard.dart';
import 'package:yoodoo/validators.dart';
import 'home_screen.dart';
import 'load_groups.dart';

class CreateTask extends StatefulWidget{

  @override
  _CreateTaskState createState() => new _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {

  List radioValues = ["Colors.green", "Colors.orangeAccent", "Colors.redAccent"];// low, medium, high priorities
  var _value;// used to store task priority
  String _taskName = "", _taskDescription = "";

  GlobalKey<FormState>_formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: true,
        title: new Text("Create Task",
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 22.0,
          color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: GestureDetector(
              onTap: () async {
                if (_formkey.currentState.validate()){
                  _formkey.currentState.save();
                }
                popupWait(context);
                await createTheTask();
                await defineTaskboardUI(groupIndex);
                Navigator.of(context).pop();// pops popupWait
                Navigator.of(context).pop();// pops CreateTaskScreen
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
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: TextFormField(
                        onSaved: (input) => _taskName = input,
                        maxLength: 50,
                        maxLines: 1,
                        validator: blankValidator,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          counterText: '',
                          hintText: "Max 50 characters",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Divider(
                        color: Colors.black,
                        thickness: 0.5,
                        indent: 25,
                        endIndent: 25,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: TextFormField(
                        onSaved: (input) => _taskDescription = input,
                        maxLength: 140,
                        maxLines: 5,
                        validator: blankValidator,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          counterText: '',
                          hintText: "Max 140 characters",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Divider(
                        color: Colors.black,
                        thickness: 0.5,
                        indent: 25,
                        endIndent: 25,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Priority Level",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: Container(
                            width: double.maxFinite,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _value = radioValues[2];
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 1.5,
                                      color: Colors.redAccent,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
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
                                    Text('High Priority (8 Yoodoos)',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Container(
                            width: double.maxFinite,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _value = radioValues[1];
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.orangeAccent,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      activeColor: Colors.orangeAccent,
                                      value: radioValues[1],
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() { _value = value; });
                                      },
                                    ),
                                    Text('Medium Priority (4 Yoodoos)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Container(
                            width: double.maxFinite,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _value = radioValues[0];
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.green,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      activeColor: Colors.green,
                                      value: radioValues[0],
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() { _value = value; });
                                      },
                                    ),
                                    Text('Low Priority (1 Yoodoo)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),),
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
  Future <void> createTheTask() async{
    String uid = randomAlphaNumeric(10);
    await groupsCollection.document(groups[groupIndex]).updateData({
      'taskuids': FieldValue.arrayUnion([uid]),
    });
    CollectionReference tasksCollection = Firestore.instance.collection('groups/'+groups[groupIndex]+'/tasks');
    return await tasksCollection.document(uid).setData({
      'taskName': _taskName,
      'taskDescription': _taskDescription,
      'taskPriority': _value,
      'taskAcceptor': "000",//000 stands for null
      'taskStatus': 0,// 0 stands for null, 1 for accepted, 2 for claimed reward
      });
  }
}