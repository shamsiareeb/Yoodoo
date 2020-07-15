import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/create_instances.dart';
import 'package:yoodoo/load_tasks.dart';
import 'package:yoodoo/notifications_page.dart';
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
var myTasks = new List();
var myTaskNames = new List();
var myTaskPriorities = new List();
List<MaterialAccentColor> mytpc= new List<MaterialAccentColor>();

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

  Future <void> _signOut()  async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreenUI()));
    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: 25.0,
                  backgroundColor: Colors.white,
                  primary: true,
                  floating: false,
                  pinned: false,
                  //snap: true,
                  flexibleSpace: FlexibleSpaceBar(
                    //centerTitle: true,
                    titlePadding: EdgeInsets.fromLTRB(25, 15, 25, 12),
                    title: new Text('Yoodoo',
                      style: TextStyle(
                          fontFamily: 'TypoHoop',
                          fontWeight: FontWeight.w100,
                          fontSize: 25.0,
                          color: Colors.black
                      ),),
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NotificationsPage()),
                          );
                        },
                        child: Icon(
                          Icons.notifications,
                          color: Colors.black,
                        ),
                      ),
                    ),
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
                            Icons.person,
                          color: Colors.black,
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
                            Icons.exit_to_app,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      indicator: BoxDecoration(
                        color: Color(0xFFE1E1E1),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.0),
                          topLeft: Radius.circular(25.0),
                        ),
                      ),
                      labelColor: Colors.black,
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
                                Text('My Groups',
                                ),
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
                  pinned: true,
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
                          //height: MediaQuery.of(context).size.height,
                          margin: EdgeInsets.fromLTRB(10,10,10,10),
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
                                  padding: EdgeInsets.fromLTRB(10,10,10,5),
                                  height: 175,
                                  width: double.maxFinite,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: Colors.white,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(groupNames[index],
                                              overflow: TextOverflow.visible,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400
                                              ),),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(groupDescriptions[index],
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15,
                                              ),),

                                            Expanded(
                                              child: SizedBox(),
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
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.bottomCenter,
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              //flex: 2,
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
                                        Icons.group_add,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'Join Group',
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
                                  popupJoin(context);
                                },
                              ),
                            ),
                            Expanded(
                              //flex: 2,
                              child: InkWell(
                                child:  Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  alignment: Alignment.center,
                                  child:Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.create,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Create Group',
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
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  //margin: EdgeInsets.fromLTRB(0,20,0,0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: myTasks.length,
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
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1.5,
                                  color: //Colors.redAccent,
                                  mytpc[index],
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0, top: 19.0, right: 20.0, bottom: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(myTaskNames[index],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400
                                          ),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
      ),
    );
  }
}

Future <void> loadMyTasks() async{
  myTasks.clear();
  myTaskNames.clear();
  myTaskPriorities.clear();
  await usersCollection.document(user.uid).get().then((DocumentSnapshot ds){
    myTasks = (ds['myTasks']);
  });
  print('My tasks array is $myTasks');
  if(myTasks != null){
    for (int i = 0; i<myTasks.length; i++){
      int x = myTasks.elementAt(i).lastIndexOf('/');
      String path = myTasks.elementAt(i).substring(0, x);
      CollectionReference taskCollection = Firestore.instance.collection(path);
      await taskCollection.document(myTasks.elementAt(i).substring(x+1)).get().then((DocumentSnapshot ds){
        myTaskNames.add(ds['taskName']);
        myTaskPriorities.add(ds['taskPriority']);
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
      color: Color(0xFFFFFFFF),
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
