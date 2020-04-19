import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:yoodoo/home_screen.dart';
import 'package:yoodoo/signup_screen.dart';

class LoginScreen extends StatefulWidget{
  _LoginForm createState() => new _LoginForm();
}
class _LoginForm extends State<LoginScreen>{

  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 60),
      child: Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
        TextFormField(
        decoration: InputDecoration(
            //icon: new Icon(Icons.email),
            hintText: 'Email ID',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            )
        ),
          validator: emailValidator,
          keyboardType: TextInputType.emailAddress,
      ),
      SizedBox(
        height: 20,
      ),
      TextFormField(
          decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              )
          ),
        obscureText: true,
        validator: pwdValidator,
      ),
      ],
      ),
    ),
    );
  }
}

class LoginScreenUI extends StatelessWidget {
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    _title(),
                    _subtitle(),
                    LoginScreen(),
                    _submitButton(),
                    Expanded(
                        flex: 2,
                        child: SizedBox()
                    ),
                    _createAccountLabel(context),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  Widget _title() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            children: [
              TextSpan(
                text: 'Welcome Back!',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ]),
      ),
    );
  }

  Widget _subtitle() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 10, 70),
        child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
              children: [
                TextSpan(
                  text: 'It\'s good to see you again.',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ]),
        ),
    );
  }

  Widget _submitButton() {
    return Container(
      child: FlatButton(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          child: Text(
            'LOG IN',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.black,
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _createAccountLabel(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreenUI()),
              );
            },
            child: Text(
              'Don\'t have an account ?  Register',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}