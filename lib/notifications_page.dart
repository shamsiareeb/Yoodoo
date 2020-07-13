import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NotificationsPage extends StatefulWidget{
  @override
  _NotificationsPageState createState() => new _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: true,
        title: Text('Notifications',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w300,
            color: Colors.black
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 25),
              child: Text('CLEAR ALL',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(
            indent: 25,
            endIndent: 25,
            color: Colors.black,
          ),
          itemCount: 10,
          itemBuilder: (context, index){
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              trailing: new GestureDetector(
                onTap: (){

                },
                child: Container(
                  child: Icon(
                    Icons.clear,
                    //color: Colors.red,
                  ),
                ),
              ),
              title: new Container(
                //height: double.maxFinite,
                child: Text('This is a notification, lets see to what extent it goes. And what if I extend it a bit more?',
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}