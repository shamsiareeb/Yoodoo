import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'validators.dart';
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
      backgroundColor: Color(0xFFE1E1E1),
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: true,
        title: new Text("Create Group",
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
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: TextFormField(
                        maxLength: 30,
                        validator: blankValidator,
                        onSaved: (input) => groupName = input,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          counterText: '',
                          hintText: "Max 30 characters",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Short Description",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: TextFormField(
                        maxLength: 60,
                        maxLines: 2,
                        validator: blankValidator,
                        onSaved: (input) => groupDescription = input,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: "Max 60 characters",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
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
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onTap: (){
                        if (_formkey.currentState.validate()) {
                          _formkey.currentState.save();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ConfigureRewards()),
                          );
                        }
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