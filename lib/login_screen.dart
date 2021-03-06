import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import 'validators.dart';
import 'dialogues.dart';
import 'profile_screen.dart';
import 'create_instances.dart';
import 'package:flutter/services.dart';


String userName, company, designation;
FirebaseUser user;
bool passwordVisible;

class LoginScreen extends StatefulWidget{
  _LoginForm createState() => new _LoginForm();
}
class _LoginForm extends State<LoginScreen>{

  @override
  void initState() {
    passwordVisible = true;
  }

  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

  String _email = '', _password = '', _error = '';
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 60),
      child: Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email ID',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  prefixIcon: new Icon(Icons.email, color: Colors.black,),
                ),
                validator: emailValidator,
                keyboardType: TextInputType.emailAddress,
                onSaved: (input) => _email = input,
              ),
            ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: TextFormField(
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      prefixIcon: new Icon(Icons.lock, color: Colors.black,),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      )
                  ),
                  validator: pwdValidator,
                  onSaved: (input) => _password = input,
                ),
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
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.green.shade500,
                  ),
                ),
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    popupDisplayLoggingYouIn(context);
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
      user = authResult.user;
      if(user == null) {
        popupDisplayNoSuchUser(context);
      }
      else
        {
          if(user.isEmailVerified)
            {
              //check if flag is true
              checkFlag(user);
            }
          else
            {
              popupDisplayEmailError(context);
            }
        }
    }
    catch(e){
      setState(() => _error = e.message);
      popupDisplayError(context, _error);
    }
}
void checkFlag(FirebaseUser user) async {
  usersCollection.document(user.uid).get().then((DocumentSnapshot ds) async {
     userName = (ds['name']);
     company = (ds['workplace']);
     designation = (ds['designation']);

     if (userName.isEmpty) {
       Navigator.of(context).pop(); //pops popupDialog5
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => ProfileScreen()),
       );
     }
     else{
       await defineHomescreenUI();
       await loadMyTasks();
       Navigator.of(context).pop();//pops popupDialog5
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => HomeScreen()),
       );
     }
  });
}
}

class LoginScreenUI extends StatelessWidget {
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFE1E1E1),
    ));
    return Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
      //margin: EdgeInsets.symmetric(horizontal: 5),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            children: [
              TextSpan(
                text: 'Welcome Back!',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
            ]),
      ),
    );
  }

  Widget _subtitle() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 0, 40),
        child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
              children: [
                TextSpan(
                  text: 'It\'s good to see you again.',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w300,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignupScreenUI()),
              );
            },
            child: Text(
              'Don\'t have an account ?  Register',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}