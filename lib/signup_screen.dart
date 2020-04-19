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

  String _email = '', _password = '', _error = '';
  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'Password must be longer than 6 characters';
    } else {
      return null;
    }
  }

  String emailValidator(String value) {

    value = value.trim();

    if (value.endsWith('@gmail.com'))
      return (null);
    else if (value.endsWith('@iul.ac.in'))
      return (null);
    else
      return ('Email not supported');

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
                validator: emailValidator,
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                    hintText: 'Email ID',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    )
                ),
                keyboardType: TextInputType.emailAddress
              ),
              TextFormField(
                  validator: pwdValidator,
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      )
                  ),
                obscureText: true
              ),
              FlatButton(
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
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    dynamic result = await signUp(_email, _password);
                    if (result == null) {
                      setState (() => _error = 'Sign up failed :(');
                    }
                  }
                },
              ),
              Text(
                _error
              )
            ],
          )
      ),
    );
  }
  Future signUp(String email, String pass) async {
      try{
        AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email , password: pass);
        FirebaseUser user = authResult.user;
        user.sendEmailVerification();

        if(user.isEmailVerified)
          return user;
        else
          return null;
        //user.sendEmailVerification();
        //Navigator.push(
        //    context,
        //    MaterialPageRoute(builder: (context) => LoginScreen()));
      }
      catch(e){
        print(e.message);
        return null;
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
                      //submitButton(),
                      Expanded(
                          flex: 2,
                          child: SizedBox()
                      ),
                      _loginLabel(context),
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

 /* Widget submitButton() {
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
        onPressed: () async {
          if ()
        },
      ),
    );
  }*/

  Widget _loginLabel(BuildContext context) {
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
                MaterialPageRoute(builder: (context) => LoginScreenUI()),
              );
            },
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

  void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
            title: Text("User Created"),
            content: Text("Please verify your email to log in to the app."),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

}
