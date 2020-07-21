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


List <String> rewards = List();
List <int> yoodoos = List();
var groupId;

class ConfigureRewards extends StatefulWidget{
  RewardScreen createState() => new RewardScreen();
}

class RewardScreen extends State<ConfigureRewards> {

  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFE1E1E1),
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        automaticallyImplyLeading: false,
        title: new Text("Add Rewards",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
            color: Colors.black
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
                  await updateGnYmapForUser(user);
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
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: BoxDecoration(
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: ListTile(
                  leading: Text('Reward',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Text('Yoodoos',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: yoodoos.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      //margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        leading: Text(rewards[index],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),),
                        trailing: Text(yoodoos[index].toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10),
        alignment: Alignment.bottomCenter,
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.black,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Delete Reward',
                        style: TextStyle(
                          //fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  if (rewards.isNotEmpty || rewards!=null) {
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
            Expanded(
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Add Reward',
                        style: TextStyle(
                          //fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
      ),
    );
  }

  Future initGroup(FirebaseUser user) async{
    groupId = randomAlphaNumeric(10);
    Map <String, int> Reward_Yoodoos = new Map.fromIterables(rewards, yoodoos);
    await groupsCollection.document(groupId).setData({
      'ownerId': user.uid,
      'ownerName': userName,
      'rewards&yoodoos': Reward_Yoodoos,
      //'rewards': FieldValue.arrayUnion(rewards),
      //'yoodoos': FieldValue.arrayUnion(yoodoos),
      'groupCode': groupId,
      'groupName': groupName,
      'groupDescription': groupDescription,
      'members': FieldValue.arrayUnion([user.uid]),
      'taskuids': FieldValue.arrayUnion([])
    });
    //CollectionReference tasksCollection = Firestore.instance.collection('groups/tasks');
    //tasksCollection.document().
  }

  Future updateGnYmapForUser(FirebaseUser user) async{
    //Map <String , int> map = Map.
    return await usersCollection.document(user.uid).setData({
      'groups&yoodoos' : {groupId : 0}
      //'groups' : FieldValue.arrayUnion([groupId]),
      //'myYoodoos' : FieldValue.arrayUnion([0]) //individual yoodoos of user for group
    }, merge: true);
  }
}