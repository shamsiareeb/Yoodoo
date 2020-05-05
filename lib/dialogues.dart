import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/group_info.dart';
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

void groupName(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return new WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
            ),
            title: Text("Name your new group"),
            content: TextField(
              maxLength: 30,
              decoration: InputDecoration(
                hintText: 'Max 30 characters.',
              )),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Next"),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => GroupInfo()),
                  );
                },
              )
            ],
          ),

        /*child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Name your new group"
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),*/
      );
    },
  );
}