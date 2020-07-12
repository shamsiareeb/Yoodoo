import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'group_info.dart';
import 'dialogues.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'package:random_string/random_string.dart';
import 'create_instances.dart';


var rewards = List();
var yoodoos = List();
var groupId;

class ConfigureRewards extends StatefulWidget{
  RewardScreen createState() => new RewardScreen();
}

class RewardScreen extends State<ConfigureRewards> {

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text("Rewards",
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
                popupDiscardGroup(context);
              },
              child: Icon(
                  Icons.clear
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: GestureDetector(
              onTap: () async{
                if(rewards.length == 0){
                  popupNoReward(context);
                }
                else{
                  popupWait(context);
                  await initGroup(user);//FirebaseUser user imported from login_screen.dart
                  await updateGroupsArrayForUser(user);
                  await defineHomescreenUI();
                  rewards.clear();
                  yoodoos.clear();
                  Navigator.of(context).pop();//pops popupWait()
                  popupShowGroupId(context, groupId);
                }
              },
              child: Icon(
                  Icons.keyboard_arrow_right
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
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Card(
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text('Reward',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('Yoodoos',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: yoodoos.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
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
                          setState(() {
                            rewards.removeLast();
                            yoodoos.removeLast();
                          });
                        }
                        else {
                          popupNoRewardsWarning(context);
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
                        popupInputReward(context);
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
    groupId = randomAlphaNumeric(10);
    await groupsCollection.document(groupId).setData({
      'ownerId': user.uid,
      'ownerName': userName,
      'rewards': FieldValue.arrayUnion(rewards),
      'yoodoos': FieldValue.arrayUnion(yoodoos),
      'groupCode': groupId,
      'groupName': groupName,
      'groupDescription': groupDescription,
      'members': FieldValue.arrayUnion([user.uid]),
      'taskuids': FieldValue.arrayUnion([])
    });
    //CollectionReference tasksCollection = Firestore.instance.collection('groups/tasks');
    //tasksCollection.document().
  }

  Future updateGroupsArrayForUser(FirebaseUser user) async{
    return await usersCollection.document(user.uid).updateData({
      'groups' : FieldValue.arrayUnion([groupId]),
      'myYoodoos' : FieldValue.arrayUnion([0]) //individual yoodoos of user for group
    });
  }
}