import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:yoodoo/home_screen.dart';
import 'package:yoodoo/signup_screen.dart';
import 'package:yoodoo/validators.dart';
import 'package:yoodoo/dialogues.dart';

class LoginScreen extends StatefulWidget{
  _LoginForm createState() => new _LoginForm();
}
class _LoginForm extends State<LoginScreen>{

  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  String _email = '', _password = '', _error = '';
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 60),
      child: Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Email ID',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            prefixIcon: new Icon(Icons.email, color: Colors.black,),
        ),
          validator: emailValidator,
          keyboardType: TextInputType.emailAddress,
          onSaved: (input) => _email = input,
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
              ),
            prefixIcon: new Icon(Icons.lock, color: Colors.black,),
          ),
        obscureText: true,
        validator: pwdValidator,
        onSaved: (input) => _password = input,
      ),
              SizedBox(
                height: 50,
              ),
              InkWell(
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
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    popupDialog5(context);
                    logIn(_email, _password);
                  }
                }
              )
      ],
      ),
    ),
    );
  }

  void logIn(String email, String pass) async {
    try{
      AuthResult authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email , password: pass);
      FirebaseUser user = authResult.user;
      if(user == null)
        popupDialog6(context);
      else
        {
          if(user.isEmailVerified)
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
          else
            {
              popupDialog7(context);
            }
        }
      //popupDialog2(context);
      //user.sendEmailVerification();
      //popupDialog3(context);
      //user.sendEmailVerification();
      //Navigator.push(
      //    context,
      //    MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    catch(e){
      setState(() => _error = e.message);
      popupDialog4(context, _error);
    }
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
                      flex: 3,
                      child: SizedBox(),
                    ),
                    _title(),
                    _subtitle(),
                    LoginScreen(),
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
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            children: [
              TextSpan(
                text: 'Welcome Back!',
                style: TextStyle(
                  fontSize: 45,
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
      margin: EdgeInsets.fromLTRB(10, 5, 10, 40),
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