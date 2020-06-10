import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/group_info.dart';
import 'package:yoodoo/home_screen.dart';
import 'package:yoodoo/login_screen.dart';
import 'package:yoodoo/validators.dart';
import 'dart:convert';
import 'package:yoodoo/configure_rewards.dart';

final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

void popupDialog1(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
         child:AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          title: Text("Don't close the app"),
          content: Text('Signing you up')
         )
        );
      },
      barrierDismissible: false
  );
}

void popupDialog2(BuildContext context) {
  Navigator.of(context).pop();
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Don't close the app"),
                content: Text('Sending verification link to email')
            )
        );
      },
      barrierDismissible: false
  );
}

void popupDialog3(BuildContext context) {
  Navigator.of(context).pop();
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("YOODOO"),
                content: Text('Please verify your email to login to the app.'),
              actions: <Widget>[
                FlatButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
        );
      },
      barrierDismissible: false
  );
}

void popupDialog4(BuildContext context, String error) {
  Navigator.of(context).pop();//closes last dialogue box
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
              ),
              title: Text("Whoops!"),
              content: Text(error),
              actions: <Widget>[
                FlatButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
        );
      },
      barrierDismissible: false
  );
}

void popupDialog5(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Just a sec"),
                content: Text('Logging you in')
            )
        );
      },
      barrierDismissible: false
  );
}

void popupDialog6(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Woops!"),
                content: Text('No such user was found')
            )
        );
      },
      barrierDismissible: false
  );
}

void popupDialog7(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Woops!"),
                content: Text('Either email was not verified or this email does not exist'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  )
                ]
            )
        );
      },
      barrierDismissible: false
  );
}


void popupDialog8(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo"),
                content: Text('Cancel profile setup and go back to login screen?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      //TODO insert proper log out code
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]
            )
        );
      },
      barrierDismissible: false
  );
}

void popupDialog9(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo"),
                content: Text('Are you sure?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );

                    },
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]
            )
        );
      },
      barrierDismissible: false
  );
}

bool popupDialog10(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo"),
                content: Text('Are you sure?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      return true;
                    },
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed: () {
                      return false;
                    },
                  )
                ]
            )
        );
      },
      barrierDismissible: false
  );
}

void popupDialog11(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child:AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  title: Text("Yoodoo"),
                  content: Text("Please enter something!"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Got it!"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        //Navigator.of(context).pop();
                        //acceptGroupName(context);
                      },
                    ),
                  ]
              )
          );
        },
        barrierDismissible: false
    );
  }

  void popupDialog12(BuildContext context) {
    TextEditingController c = new TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
            ),
            title: Text("Step 1. Type the new reward"),
            content: TextField (
              maxLength: 60,
              decoration: InputDecoration(
                hintText: 'Max 60 characters.',
              ),
              controller: c,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                  //return null;
                },
              ),
              FlatButton(
                child: Text("Next"),
                onPressed: () {
                  String input = c.text;
                  input = input.trim();
                  if(input.length == 0){
                    popupDialog11(context);
                    //return null;
                  }
                  else{
                     rewards.add(c.text);
                     popupDialog13(context);
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

void popupDialog13(BuildContext context){
  TextEditingController c = new TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return new WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          title: Text("Step 2. Set Yoodoos"),
          content: TextField (
            keyboardType: TextInputType.number,
            maxLength: 2,
            decoration: InputDecoration(
              hintText: 'min=1 and max=10',
            ),
            controller: c,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Back"),
              onPressed: () {
                Navigator.pop(context);
                rewards.removeLast();
              },
            ),
            FlatButton(
              child: Text("Done"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                if(int.parse(c.text) <= 10 && int.parse(c.text) >0){
                  yoodoos.add(int.parse(c.text));
                }
                else{
                  popupDialog14(context);
                }
              },
            )
          ],
        ),
      );
    },
  );
}

void popupDialog14(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo"),
                content: Text("Please enter a number between 0 and 10"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Got it!"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      //Navigator.of(context).pop();
                      //acceptGroupName(context);
                    },
                  ),
                ]
            )
        );
      },
      barrierDismissible: false
  );
}

void popupDialog15(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo"),
                content: Text("No rewards have been set"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Got it!"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      //Navigator.of(context).pop();
                      //acceptGroupName(context);
                    },
                  ),
                ]
            )
        );
      },
      barrierDismissible: false
  );
}

void popupDiscardGroup(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo"),
                content: Text('Discard this group?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      yoodoos.clear();
                      rewards.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]
            )
        );
      },
      barrierDismissible: false
  );
}

void popupShowGroupId(BuildContext context, var groupId) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text(groupId),
                content: Text('Members will use this code to join ' + groupName),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Got it!"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  )
                ]
            )
        );
      },
      barrierDismissible: false
  );
}

void popupJoin(BuildContext context) {
  String code;
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text('Join a group'),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                  onSaved: (input) => code,
                  validator: blankValidator,
                  decoration: InputDecoration(
                    hintText: 'Enter group code',
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
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Submit'),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        joinGroup(code);
                      }
                    },
                  ),
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]
            )
        );
      },
      barrierDismissible: false
  );
  void joinGroup(String code) async{
    final CollectionReference groupsCollection = Firestore.instance.collection('groups');
    try{
      groupsCollection.document(code).updateData({"members" : FieldValue.arrayUnion([user.uid])}).then((_) {
        //TODO update UI on homescreen
      });
    }
    catch(e){

          }
  }
}