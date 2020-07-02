import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'create_instances.dart';
import 'home_screen.dart';
import 'validators.dart';
import 'dialogues.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {

  //String _name1, _name2, _designation, _company;
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  @override

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text('PROFILE',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),),
      ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Full Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        initialValue: userName,
                        validator: blankValidator,
                        onSaved: (input) => userName = input,
                        decoration: InputDecoration(
                          hintText: 'John Doe',
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
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Workplace',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        initialValue: company,
                        validator: blankValidator,
                        onSaved: (input) => company = input,
                        decoration: InputDecoration(
                          hintText: 'Company Name',
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
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Designation',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        initialValue: designation,
                        validator: blankValidator,
                        onSaved: (input) => designation = input,
                        decoration: InputDecoration(
                          hintText: 'Job Title',
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
                        height: 100,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                alignment: Alignment.center,
                                child: Text(
                                  'CANCEL',
                                  style: TextStyle(fontSize: 20, color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                if (userName.isEmpty){
                                  popupCancelSetup(context);
                                }
                                else {
                                  popupInputYesNo(context);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                alignment: Alignment.center,
                                child: Text(
                                  'SAVE',
                                  style: TextStyle(fontSize: 20, color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () async {
                                if (_formKey.currentState.validate()){
                                  _formKey.currentState.save();
                                 // if (popupDialog10(context) == true){
                                    save(userName, company, designation);
                                    await defineHomescreenUI();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeScreen()),
                                  );
                                  //}
                                  /*else{
                                    Navigator.of(context).pop();
                                  }*/
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
  Future save(_userName, _company, _designation) async{
    _userName = _userName.trim();
    userName = _userName;
    return await usersCollection.document(user.uid).setData({
      'name': _userName,
      'workplace': _company,
      'designation': _designation,
      'groups': FieldValue.arrayUnion([])
    });
  }
}

/*class ProfileScreenUI extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                    ProfileScreen(),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}*/

