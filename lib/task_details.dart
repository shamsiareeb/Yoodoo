import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TaskDetails extends StatefulWidget {
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: true,
        title: new Text('Task Details',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(18.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Group Name",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      //height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Text('The description of a particular group will be shown here.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.5,
                      indent: 25,
                      endIndent: 25,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Task Name",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      //height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Text('The description of a particular group will be shown here. As you can see, this is not much.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.5,
                      indent: 25,
                      endIndent: 25,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Task Description",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      //height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Text('The description of a particular group will be shown here. As you can see, this is not much'
                          'coz we dont have enough data as for now. But in a while, we will have everything we dont have right now.',
                        style: TextStyle(
                            fontSize: 16,
                          fontWeight: FontWeight.w400
                        ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.5,
                      indent: 25,
                      endIndent: 25,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(18.0),
                child: InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(
                        'CLAIM YOODOOS',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                        color: Colors.green,
                      ),
                    ),
                    onTap: () {

                    }
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(22, 0, 22, 100),
                child: InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(
                        'REJECT TASK',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.red),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                        border: Border.all(
                          color: Colors.red,
                        )
                      ),
                    ),
                    onTap: () {

                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}