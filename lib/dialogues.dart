import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/group_info.dart';
import 'package:yoodoo/home_screen.dart';
import 'package:yoodoo/validators.dart';

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

  void popupDialog12(BuildContext context){
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
            title: Text("Step 1. Enter new reward"),
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
                    popupDialog13(context);
                    print(c.text);
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
  double reward = 1;
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
                //return null;
              },
            ),
            FlatButton(
              child: Text("Done"),
              onPressed: () {
                print (c.text);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    },
  );
}