import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:yoodoo/login_screen.dart';

class SignupScreen extends StatefulWidget{
  _SignupForm createState() => new _SignupForm();
}
class _SignupForm extends State<SignupScreen>{

  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

  String _email, _password;

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
    if (value.length < 6) {
      return 'Password must be longer than 6 characters';
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
                    hintText: 'Full Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    )
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                    hintText: 'Email ID',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    )
                ),
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  onSaved: (input) => _password = input,
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
              /*FlatButton(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: Text(
                      'SIGN UP',
                      style: TextStyle(color: Colors.white)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black,
                  ),
                ),
                onPressed: signUp,
              )*/
            ],
          )
      ),
    );
  }

  void signUp() async {
    if (_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email , password: _password);
        FirebaseUser user = authResult.user;
        user.sendEmailVerification();
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }
      catch(e){
        print(e.message);
      }
    }
  }
}

class SignupScreenUI extends StatelessWidget {
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
                        flex: 2,
                        child: SizedBox(),
                      ),
                      _title(),
                      _subtitle(),
                      SignupScreen(),
                      _submitButton(),
                      Expanded(
                          flex: 2,
                          child: SizedBox()
                      ),
                      _loginLabel(),
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
                text: 'Let\'s get started!',
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
                text: 'We are excited to see you here.',
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
            'SIGN UP',
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

  Widget _loginLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Text(
              'Already a member ?  Sign In',
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
