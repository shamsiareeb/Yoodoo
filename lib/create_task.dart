import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yoodoo/validators.dart';

class CreateTask extends StatefulWidget{

  @override
  _CreateTaskState createState() => new _CreateTaskState();
}

enum radioValues { high, medium, low }

class _CreateTaskState extends State<CreateTask> {

  radioValues _values = radioValues.low;

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
              onTap: () {

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
                                child: Text('High Priority (8 Yoodoos)'),
                              ),
                            ),
                          ),
                          leading: Radio(
                            value: radioValues.high,
                            groupValue: _values,
                            onChanged: (radioValues value) {
                              setState(() { _values = value; });
                            },
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
                                child: Text('Medium Priority (4 Yoodoos)'),
                              ),
                            ),
                          ),
                          leading: Radio(
                            value: radioValues.medium,
                            groupValue: _values,
                            onChanged: (radioValues value) {
                              setState(() { _values = value; });
                            },
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
                                child: Text('Low Priority (1 Yoodoos)'),
                              ),
                            ),
                          ),
                          leading: Radio(
                            value: radioValues.low,
                            groupValue: _values,
                            onChanged: (radioValues value) {
                              setState(() { _values = value; });
                            },
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
}