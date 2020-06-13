import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yoodoo/validators.dart';
import 'package:yoodoo/home_screen.dart';
import 'package:yoodoo/dialogues.dart';
import 'configure_rewards.dart';


String groupName='', groupDescription = '';
class GroupInfo extends StatefulWidget {
  @override
  _GroupInfoState createState() => new _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {

  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();

  final myRewardController = TextEditingController();
  final myPointsController = TextEditingController();

  void dispose() {
    myRewardController.dispose();
    myPointsController.dispose();
    super.dispose();
  }

  List<DataRow> tiles, row = [];
  int index = 0;

  @override

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text("ADD GROUP",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Group's Name",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      maxLength: 30,
                      validator: blankValidator,
                      onSaved: (input) => groupName = input,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: "Max 30 characters",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Short Description",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      maxLength: 60,
                      validator: blankValidator,
                      onSaved: (input) => groupDescription = input,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: "Max 60 characters",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        child: Text(
                          'NEXT',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.black,
                        ),
                      ),
                      onTap: (){
                        if (_formkey.currentState.validate()) {
                          _formkey.currentState.save();
                          }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ConfigureRewards()),
                        );
                      },
                    )
            ],
          )
            ]
        ),
      ),
    )
      )
    );
  }
}