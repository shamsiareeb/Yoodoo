import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yoodoo/group_info.dart';
import 'package:yoodoo/home_screen.dart';
import 'package:yoodoo/load_groups.dart';

class GroupDetails extends StatefulWidget {
  @override
  _GroupDetailsState createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        title: new Text('Group Details',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              ownerFlag == true ?
              new Container(
                padding: EdgeInsets.all(18.0),
                alignment: Alignment.centerLeft,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Unique ID",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.only(top: 21, bottom: 15),
                        height: 75,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(groups[groupIndex],
                            style: TextStyle(
                                //fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'AzoSans-Black',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ):
              new Container(),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(18.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Group Description",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 75,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Text(groupDescriptions[groupIndex],
                      style: TextStyle(
                        fontSize: 16
                      ),),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 125,
                padding: EdgeInsets.all(18.0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.only(top: 21, bottom: 15),
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Your yoodoo balance for this group is: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'AzoSans-Black',
                            ),
                          ),
                          Text(myYoodoos[groupIndex],
                            style: TextStyle(
                              //fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'AzoSans-Black',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              /*Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          height: 75,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text('Yoodoo Balance',
                                  style: TextStyle(
                                    //fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text('8',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.only(top: 21, bottom: 15),
                          height: MediaQuery.of(context).size.width*0.25,
                          width: MediaQuery.of(context).size.width*0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Skips Remaining',
                                style: TextStyle(
                                  //fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('3',
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(18.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Group Members",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: (allGroupMembers[groupIndex]).length,
                        itemBuilder: (context, index){
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 30),
                            trailing: ownerFlag == true ? new GestureDetector(
                              onTap: (){

                              },
                              child: Container(
                                child: Icon(
                                  Icons.do_not_disturb,
                                  color: Colors.red,
                                ),
                              ),
                            ): Container(),
                            title: Container(
                              //padding: EdgeInsets.all(15),
                              child: Text(allGroupMembers[groupIndex].elementAt(index),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
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
      ),
    );
  }
}