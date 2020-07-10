import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/create_instances.dart';
import 'package:yoodoo/load_tasks.dart';
import 'package:yoodoo/task_details.dart';
import 'dialogues.dart';
import 'taskboard.dart';
import 'group_info.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'load_groups.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool uiFlag;
bool ownerFlag;
int groupIndex;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

var myTasks = new List();
var myTaskNames = new List();
var myTaskPriorities = new List();

List<MaterialAccentColor> mytpc= new List<MaterialAccentColor>();

  Future <void> _signOut()  async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreenUI()));
    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                titleSpacing: 25.0,
                backgroundColor: Colors.black,
                primary: true,
                floating: false,
                pinned: true,
                //snap: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: new Text('Yoodoo',
                    style: TextStyle(
                        fontFamily: 'TypoHoop',
                        fontWeight: FontWeight.w100,
                        fontSize: 25.0,
                        color: Colors.white
                    ),),
                ),
                leading: Padding(
                  padding: EdgeInsets.only(left: 25.0),
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
                actions: <Widget>[
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
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicator: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                          color: Colors.white,
                          width: 4
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    //labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.white,
                    indicatorWeight: 2,
                    tabs: <Widget>[
                      Tab(
                        child: Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.group),
                              SizedBox(width: 10),
                              Text('My Groups'),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.work),
                              SizedBox(width: 10),
                              Text('My Tasks'),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pinned: false,
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: uiFlag == false ? new Container(
                          child: new Center(
                              child: new Text('No groups to show')
                          ),
                        ) : new Container(
                          //margin: EdgeInsets.fromLTRB(0,20,0,0),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: groups.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {

                                  groupIndex = index;
                                  popupWait(context);
                                  await defineTaskboardUI(index);
                                  Navigator.of(context).pop();//pops popupWait()
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Taskboard()),);

                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10,10,10,0),
                                  height: 175,
                                  width: double.maxFinite,
                                  child: Card(
                                    elevation: 5,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            width: 5.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Text(groupNames[index],
                                                  overflow: TextOverflow.visible,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
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
                                                    fontSize: 15,
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
                                                        //fontSize: 16,
                                                        fontStyle: FontStyle.italic,
                                                      ),),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.bottomLeft,
                                                    child: Text(groupOwners[index],
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                        //fontSize: 17,
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
                                  ),
                                ),
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                //margin: EdgeInsets.fromLTRB(0,20,0,0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 5,//myTasks.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TaskDetails()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10,10,10,0),
                          height: 75,
                          width: double.maxFinite,
                          child: Card(
                              elevation: 5,
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3.0,
                                      color: Colors.redAccent,
                                      //mytpc.elementAt(index),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20.0, top: 15.0, right: 20.0, bottom: 10.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text('The quick brown fox jumped over the lazy dog',
                                              overflow: TextOverflow.ellipsis,
                                              //myTaskNames.elementAt(index),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),),
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
            ],
          ),
        ),
      ),
    );
  }

 /*Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: Scaffold(
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
            bottom: TabBar(
              tabs: <Widget>[
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.group),
                      SizedBox(width: 10),
                      Text('My Groups'),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox(width: 10),
                      Text('My Tasks'),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: uiFlag == false ? new Container(
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

                                      groupIndex = index;
                                      popupWait(context);
                                      await defineTaskboardUI(index);
                                      Navigator.of(context).pop();//pops popupWait()
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Taskboard()),);

                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(10,10,10,0),
                                      height: 175,
                                      width: double.maxFinite,
                                      child: Card(
                                          elevation: 5,
                                          child: Container(
                                            padding: EdgeInsets.only(top: 10, bottom: 10),
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
                                                padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(groupNames[index],
                                                        overflow: TextOverflow.visible,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 24,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(groupDescriptions[index],
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 18,
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
                                                              fontSize: 16,
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
                                      ),
                                    ),
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.fromLTRB(0,20,0,0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 5,//myTasks.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TaskDetails()),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10,10,10,0),
                            height: 100,
                            width: double.maxFinite,
                            child: Card(
                                elevation: 5,
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 3.0,
                                        color: Colors.redAccent,
                                        //mytpc.elementAt(index),
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0, bottom: 10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text('The quick brown fox jumped over the lazy dog',
                                                overflow: TextOverflow.ellipsis,
                                                //myTaskNames.elementAt(index),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold
                                                ),),
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
              ],
          ),
        ),
    );
  }*/

  Future <void> loadMyTasks() async{
    myTasks.clear();
    myTaskNames.clear();
    myTaskPriorities.clear();
    await usersCollection.document(user.uid).get().then((DocumentSnapshot ds){
      myTasks = (ds['myTasks']);
    });
    if(myTasks.isNotEmpty){
      for (int i = 0; i<myTasks.length; i++){
        int x = myTasks.elementAt(i).lastIndexOf('/');
        String path = myTasks.elementAt(i).substring(0, x);
        CollectionReference taskCollection = Firestore.instance.collection(path);
        await taskCollection.document(myTasks.elementAt(i).substring(x+1)).get().then((DocumentSnapshot ds){
          myTaskNames.add(ds['taskNames']);
          myTaskPriorities.add(ds['taskPriorities']);
          if(myTaskPriorities.elementAt(i) == "Colors.redAccent")
            mytpc.add(Colors.redAccent);
          else if(myTaskPriorities.elementAt(i) == "Colors.orangeAccent")
            mytpc.add(Colors.orangeAccent);
          else
            mytpc.add(Colors.greenAccent);
        });
      }
    }
  }
}

Future<void> defineHomescreenUI() async{
  uiFlag = await loadGroupsData(user);
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
  print(uiFlag);
}

Future <void> defineTaskboardUI(int index) async {
  await checkGroupOwner(index);
  await loadTasksOfGroup(index);
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
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
