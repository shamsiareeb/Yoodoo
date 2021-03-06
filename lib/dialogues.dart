import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/load_groups.dart';
import 'package:yoodoo/load_tasks.dart';
import 'group_info.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'validators.dart';
import 'configure_rewards.dart';
import 'create_instances.dart';

final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

void popupDisplaySigningYouUp(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
         child:AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          title: Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
            ),
          ),
          content: Text('Signing you up',
            textAlign: TextAlign.center,)
         )
        );
      },
      barrierDismissible: false
  );
}

void popupDisplaySendingVerification(BuildContext context) {
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
                title: Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                  ),
                ),
                content: Text('Sending verification link to email')
            )
        );
      },
      barrierDismissible: false
  );
}

void popupVerifyEmailPrompt(BuildContext context) {
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
                title: Text("Yoodoo",
                    style: TextStyle(
                    fontFamily: 'TypoHoop',
                    fontWeight: FontWeight.w100,
                    fontSize: 25.0,
                    color: Colors.black
                ),),
                content: Text('Please verify your email to login to the app.'),
              actions: <Widget>[
                FlatButton(
                  child: Text("Close",
                    style: TextStyle(
                      color: Colors.black,
                    ),),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreenUI()),
                    );
                  },
                )
              ],
            )
        );
      },
      barrierDismissible: false
  );
}

void popupDisplayError(BuildContext context, String error) {
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
                  child: Text("Close",
                    style: TextStyle(
                      color: Colors.black,
                    ),),
                  onPressed: () {
                    Navigator.of(context).pop();
                    //Navigator.of(context).pop();
                  },
                )
              ],
            )
        );
      },
      barrierDismissible: false
  );
}

void popupDisplayLoggingYouIn(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                  ),
                ),
                content: Text('Logging you in',
                  textAlign: TextAlign.center,),
            )
        );
      },
      barrierDismissible: false
  );
}

void popupDisplayNoSuchUser(BuildContext context) {
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
                content: Text('No such user was found'),
              actions: <Widget>[
                FlatButton(
                  child: Text("Close", 
                    style: TextStyle(
                    color: Colors.black,
                    ),), 
                  onPressed: () {
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

void popupDisplayEmailError(BuildContext context) {
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
                      //Navigator.of(context).pop();
                    },
                  )
                ]
            )
        );
      },
      barrierDismissible: false
  );
}


void popupCancelSetup(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo",
                  style: TextStyle(
                      fontFamily: 'TypoHoop',
                      fontWeight: FontWeight.w100,
                      fontSize: 25.0,
                      color: Colors.black
                  ),),
                content: Text('Cancel profile setup and go back to login screen?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("No",
                      style: TextStyle(
                          color: Colors.black
                      ),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("Yes",
                    style: TextStyle(
                      color: Colors.black
                    ),),
                    onPressed: () {
                      signOut(context);
                      Navigator.of(context).pop();
                    }
                  ),
                ]
            )
        );
      },
      barrierDismissible: false
  );
}

void popupInputYesNo(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo",
                  style: TextStyle(
                      fontFamily: 'TypoHoop',
                      fontWeight: FontWeight.w100,
                      fontSize: 25.0,
                      color: Colors.black
                  ),),
                content: Text('Are you sure?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("No",
                      style: TextStyle(
                          color: Colors.black
                      ),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("Yes",
                      style: TextStyle(
                          color: Colors.black
                      ),),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );

                    },
                  ),
                ]
            )
        );
      },
      barrierDismissible: false
  );
}

/*bool popupDialog10(BuildContext context) {
  bool val;
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo",
                  style: TextStyle(
                      fontFamily: 'TypoHoop',
                      fontWeight: FontWeight.w100,
                      fontSize: 25.0,
                      color: Colors.black
                  ),),
                content: Text('Are you sure?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("No",
                      style: TextStyle(
                          color: Colors.black
                      ),),
                    onPressed: () {
                      val = false;
                    },
                  ),
                  FlatButton(
                    child: Text("Yes",
                      style: TextStyle(
                          color: Colors.black
                      ),),
                    onPressed: () {
                      val = true;
                    },
                  ),

                ]
            )
        );
      },
      barrierDismissible: false
  );
  return val;
}*/

void popupBlankWarning(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child:AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  title: Text("Yoodoo",
                    style: TextStyle(
                        fontFamily: 'TypoHoop',
                        fontWeight: FontWeight.w100,
                        fontSize: 25.0,
                        color: Colors.black
                    ),),
                  content: Text("Values cannot be left blank!"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Got it!",
                      style: TextStyle(
                        color: Colors.black
                      ),),
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

  void popupInputReward(BuildContext context) {
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
            title: Text("Step 1. Type a new reward"),
            content: TextField (
              maxLength: 60,
              decoration: InputDecoration(
                hintText: 'Max 60 characters',
              ),
              controller: c,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel",
                  style: TextStyle(
                      color: Colors.black
                  ),),
                onPressed: () {
                  Navigator.pop(context);
                  //return null;
                },
              ),
              FlatButton(
                child: Text("Next",
                  style: TextStyle(
                      color: Colors.black
                  ),),
                onPressed: () {
                  String input = c.text;
                  input = input.trim();
                  if(input.length == 0){
                    popupBlankWarning(context);
                    //return null;
                  }
                  else{
                     rewards.add(c.text);
                     popupInputYoodoos(context);
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

void popupInputYoodoos(BuildContext context){
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
              child: Text("Back",
                style: TextStyle(
                    color: Colors.black
                ),),
              onPressed: () {
                Navigator.pop(context);
                rewards.removeLast();
              },
            ),
            FlatButton(
              child: Text("Done",
                style: TextStyle(
                    color: Colors.black
                ),),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                if(int.parse(c.text) <= 10 && int.parse(c.text) >0){
                  yoodoos.add(int.parse(c.text));
                }
                else{
                  popupYoodooRangeError(context);
                }
              },
            )
          ],
        ),
      );
    },
  );
}

void popupYoodooRangeError(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo",
                  style: TextStyle(
                      fontFamily: 'TypoHoop',
                      fontWeight: FontWeight.w100,
                      fontSize: 25.0,
                      color: Colors.black
                  ),),
                content: Text("Please enter a number between 0 and 10"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Got it!",
                    style: TextStyle(
                      color: Colors.black
                    ),),
                    onPressed: () {
                      rewards.removeLast();
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

void popupNoRewardsWarning(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo",
                  style: TextStyle(
                      fontFamily: 'TypoHoop',
                      fontWeight: FontWeight.w100,
                      fontSize: 25.0,
                      color: Colors.black
                  ),),
                content: Text("No rewards have been set"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Got it!",
                    style: TextStyle(
                      color: Colors.black
                    ),),
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
                title: Text("Yoodoo",
                  style: TextStyle(
                      fontFamily: 'TypoHoop',
                      fontWeight: FontWeight.w100,
                      fontSize: 25.0,
                      color: Colors.black
                  ),),
                content: Text('Discard this group?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("No",
                    style: TextStyle(
                      color: Colors.black
                    ),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("Yes",
                      style: TextStyle(
                          color: Colors.black
                      ),),
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
                title: Text(groupId,
                textAlign: TextAlign.center,),
                content: Text('Members will use this code to join ' + groupName),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Got it!",
                    style: TextStyle(
                      color: Colors.black
                    ),),
                    onPressed: () {
                      Navigator.of(context).pop();//pops this dialog
                      Navigator.of(context).pop();//pops the configure rewards screen
                      Navigator.of(context).pop();//pops the group info screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );//replaces earlier instance of homescreen
                    },
                  )
                ]
            )
        );
      },
      barrierDismissible: false
  );
}

void popupWait(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                  ),
                ),
                content: Text('Please Wait',
                  textAlign: TextAlign.center,)
            )
        );
      },
      barrierDismissible: false
  );
}

void popupNoReward(BuildContext context) {
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
                content: Text('Please enter at least one reward'),
              actions: <Widget>[
            FlatButton(
            child: Text("Close",
              style: TextStyle(
                color: Colors.black,
              ),),
          onPressed: () {
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

void popupJoin(BuildContext context) {
  String _code;
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => true,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text('Join a group'),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                  onSaved: (input) => _code = input,
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
                    child: Text('Cancel',
                      style: TextStyle(
                          color: Colors.black
                      ),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('Submit',
                    style: TextStyle(
                      color: Colors.black
                    ),),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        //joinGroup(code);
                        //void joinGroup(String code) async{
                        //Navigator.of(context).pop();//Closes popupJoin()
                        popupWait(context);
                          //CollectionReference groupsCollection = Firestore.instance.collection('groups');
                          //CollectionReference usersCollection = Firestore.instance.collection('users');
                          try{
                            /* updateData has been used because it does not create a new document unlike setData
                               which creates a new firebase document in case it finds that there is no such document in the db */
                            await groupsCollection.document(_code).updateData({
                              'memberUIDs' : FieldValue.arrayUnion([user.uid]),
                              'memberNames' : FieldValue.arrayUnion([userName]),
                            });
                            print('Group updated');
                            await usersCollection.document(user.uid).setData({
                              'groups&yoodoos' : {_code : 0}
                            }, merge: true);
                            print('user updated');
                            await defineHomescreenUI();
                            Navigator.of(context).pop();//closes popupWait()
                            Navigator.of(context).pop();//closes popupJoin()
                          }
                          catch(e){
                            popupDisplayError(context, e.toString());
                          }
                          }
                    },
                  ),

                ]
            )
        );
      },
      barrierDismissible: true
  );
}

void popupRejectTask(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
              ),
              title: Text("Are you sure?"),
              content: Text('Rejecting a task will incur a panalty on your Yoodoo balance!'),
              actions: <Widget>[
                FlatButton(
                  child: Text("Yes",
                    style: TextStyle(
                      color: Colors.black,
                    ),),
                  onPressed: () async{
                    popupWait(context);
                    await usersCollection.document(user.uid).updateData({
                      //'myTasks': FieldValue.arrayRemove(tasks[index]),
                      //'myYoodoos': //TODO delete task from users and update task attributes in groups
                    });
                  },
                ),
                FlatButton(
                  child: Text("No",
                    style: TextStyle(
                      color: Colors.black,
                    ),),
                  onPressed: () {
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

void popupRewardClaimed(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo",
                  style: TextStyle(
                      fontFamily: 'TypoHoop',
                      fontWeight: FontWeight.w100,
                      fontSize: 25.0,
                      color: Colors.black
                  ),),
                content: Text("You bought a reward!"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Yay!",
                      style: TextStyle(
                          color: Colors.black
                      ),),
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

void popupNotEnoughYoodoos(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child:AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                title: Text("Yoodoo",
                  style: TextStyle(
                      fontFamily: 'TypoHoop',
                      fontWeight: FontWeight.w100,
                      fontSize: 25.0,
                      color: Colors.black
                  ),),
                content: Text("You don't have enough Yoodoos!"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ok",
                      style: TextStyle(
                          color: Colors.black
                      ),),
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

  Future <void> signOut(BuildContext context)  async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreenUI()));
    return null;
  }