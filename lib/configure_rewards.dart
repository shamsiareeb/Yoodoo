import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dialogues.dart';
import 'package:yoodoo/login_screen.dart';

var rewards = List();
var yoodoos = List();

class ConfigureRewards extends StatefulWidget{
  _RewardScreen createState() => new _RewardScreen();
}

class _RewardScreen extends State<ConfigureRewards> {

  final CollectionReference groupsCollection = Firestore.instance.collection('groups');
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text("REWARDS",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: GestureDetector(
              onTap: () {
                popupDialog9(context);
              },
              child: Icon(
                  Icons.clear
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: GestureDetector(
              onTap: () {
              },
              child: Icon(
                  Icons.save
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: yoodoos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Text(rewards[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(yoodoos[index].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: 60,
              width: MediaQuery.of(context).size.width,
              //margin: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              //padding: EdgeInsets.symmetric(vertical: 60),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.black,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        child: Text(
                          'Delete Reward',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        if (rewards.isNotEmpty) {
                          rewards.removeLast();
                          yoodoos.removeLast();
                        }
                        else {
                          popupDialog15(context);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      color: Colors.white,
                      height: 60,
                      width: 0.5,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        child: Text(
                          'Add Reward',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        popupDialog12(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future initGroup(FirebaseUser user) async{

      return await groupsCollection.document(user.uid).setData({
        'flag': true,
        'name': '',
        'workplace':'',
        'designation':''
      });
  }
}
