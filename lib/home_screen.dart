import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/create_instances.dart';
import 'package:yoodoo/load_tasks.dart';
import 'dialogues.dart';
import 'taskboard.dart';
import 'group_info.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'load_groups.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool UIflag;
bool ownerFlag;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future <void> _signOut()  async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreenUI()));
    return null;
  }

 Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 25.0,
          title: new Text('Yoodoo',
            style: TextStyle(
              fontFamily: 'TypoHoop',
              fontWeight: FontWeight.w100,
              fontSize: 25.0,
              color: Colors.white
            ),),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: Icon(
                    Icons.person
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: GestureDetector(
                onTap: () {
                  _signOut();
                },
                child: Icon(
                  Icons.exit_to_app
                ),
              ),
            ),
          ],
          backgroundColor: Colors.black,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Expanded(
                child: UIflag == false ? new Container(
                  child: new Center(
                      child: new Text('No groups to show')
                  ),
                ) : new Container(
                  margin: EdgeInsets.fromLTRB(0,20,0,0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () async {

                            popupWait(context);
                            await defineTaskboardUI(index);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Group()),);

                            },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10,10,10,0),
                        height: 175,
                        width: double.maxFinite,
                        child: Card(
                            elevation: 5,
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      width: 4.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(groupNames[index],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold
                                            ),),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(groupDescriptions[index],
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                            ),),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text('Admin: ',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 17,
                                                  fontStyle: FontStyle.italic,
                                                ),),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(groupOwners[index],
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 17,
                                                  fontStyle: FontStyle.italic,
                                                ),),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ),
                        )
                      );
                      },
                  ),
                ),
              ),
              Container(
                height: 60,
                alignment: Alignment.bottomCenter,
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
                            'Join',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          popupJoin(context);
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
                        child:  Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          child: Text(
                            'Create',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GroupInfo()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
    );
  }
}

Future<void> defineHomescreenUI() async{
  UIflag = await loadGroupsData(user);
  printArrays();
}
void printArrays(){
  print('groups are:');
  print(groups);
  print('group names are:');
  print(groupNames);
  print('group descriptions are:');
  print(groupDescriptions);
  print('group owners are:');
  print(groupOwners);
  print('Ui flag is:');
  print(UIflag);
}

Future <void> defineTaskboardUI(int index) async {
  await checkGroupOwner(index);
  await loadTasksData(index);
}


      /*new Center(
            child: new Text('No groups to show')
        )*/
        /*Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: numbers.length, itemBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Card(
                color: Colors.lightBlueAccent,
                //shadowColor: Colors.black,
                child: Container(
                  child: Center(child: Text(numbers[index].toString(), style: TextStyle(color: Colors.white, fontSize: 36.0),)),
                ),
              ),
            );
          }),
        ),*/
