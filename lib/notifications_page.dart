import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NotificationsPage extends StatefulWidget{
  @override
  _NotificationsPageState createState() => new _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Notifications',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 25),
              child: Text('CLEAR ALL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
            itemCount: 10,
            itemBuilder: (context, index){
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                trailing: new GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    child: Icon(
                      Icons.clear,
                    ),
                  ),
                ),
                title: new Container(
                  //height: double.maxFinite,
                  child: Text('This is a notification, lets see to what extent it goes. And what if I extend it a bit more?',
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 18,
                      ),
                    ),
                  ),
                );
              },
          ),
        ),
      ),
    );
  }
}