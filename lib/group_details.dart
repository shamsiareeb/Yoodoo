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
      backgroundColor: Color(0xFFE1E1E1),
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        automaticallyImplyLeading: true,
        title: new Text('Group Details',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              ownerFlag == true ?
              new Container(
                margin: EdgeInsets.all(18.0),
                alignment: Alignment.centerLeft,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Unique ID",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 18.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(17))
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      //height: 75,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(groups[groupIndex],
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'AzoSans-Black',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.5,
                      indent: 25,
                      endIndent: 25,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ):
              new Container(
                //height: 0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 18.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Group Description",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      //height: 75,
                      width: MediaQuery.of(context).size.width,
                      child: Text(groupDescriptions[groupIndex],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.5,
                      indent: 25,
                      endIndent: 25,
                    ),
                    SizedBox(
                      height: 28,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 18.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(17))
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Your yoodoo balance for this group is',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'AzoSans-Black',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(myYoodoos[groupIndex].toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'AzoSans-Black',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 18.0),
                child: Divider(
                  color: Colors.black,
                  thickness: 0.5,
                  indent: 25,
                  endIndent: 25,
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Group Members",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Divider(
                          indent: 25,
                          endIndent: 25,
                          color: Colors.black,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 10,
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
                              child: Text('Member Name',
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