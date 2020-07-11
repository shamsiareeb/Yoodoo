import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/dialogues.dart';
import 'package:yoodoo/home_screen.dart';
import 'login_screen.dart';
import 'create_instances.dart';
import 'dart:async' show Timer;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((currentUser) async{
      if(currentUser != null) {
        user = currentUser;
        //new Timer(const Duration(seconds: 3), onClose);
        //popupWait(context);
        usersCollection.document(user.uid).get().then((
            DocumentSnapshot ds) async {
          userName = (ds['name']);
          await defineHomescreenUI();
          //Navigator.of(context).pop();
          await loadMyTasks();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      }
      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreenUI()),
        );
      }
    });
    //new Timer(const Duration(seconds: 2), onClose);
  }

  void onClose() {
    /*Navigator.of(context).pushReplacement(new PageRouteBuilder(
        maintainState: true,
        opaque: true,
        pageBuilder: (context, _, __) => new LoginScreenUI(),
    ));*/
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreenUI()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 175),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Center(
                        child: Text('Yoodoo',
                          style: TextStyle(
                            fontSize: 50.0,
                            fontFamily: 'TypoHoop',
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: SizedBox(),
                    )
                  ],
                ),
              )
            ]
        )
    );
  }
}
