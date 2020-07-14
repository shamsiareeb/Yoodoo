import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:yoodoo/validators.dart';
import 'package:yoodoo/dialogues.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yoodoo/create_instances.dart';
import 'package:flutter/services.dart';
import 'package:yoodoo/login_screen.dart';

class SignupScreen extends StatefulWidget{
  _SignupForm createState() => new _SignupForm();
}
class _SignupForm extends State<SignupScreen>{

  @override
  void initState() {
    passwordVisible = true;
  }


  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

  String _email = '', _password = '', _error = '';

  final passwordController = TextEditingController();
  final confPassController = TextEditingController();

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
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
                    validator: emailValidator,
                    onSaved: (input) => _email = input,
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
                    keyboardType: TextInputType.emailAddress
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
                  validator: pwdValidator,
                  controller: passwordController,
                  onSaved: (input) => _password = input,
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
                  obscureText: passwordVisible,
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
                    controller: confPassController,
                    validator: (val){
                      if(val.isEmpty)
                        return 'Required';
                      if(val != passwordController.text)
                        return 'Passwords do not match';
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      prefixIcon: new Icon(Icons.lock, color: Colors.black,),
                    ),
                    obscureText: true
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
                    'SIGN UP',
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
                  if (_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    popupDisplaySigningYouUp(context);
                    signUp(_email, _password);
                  }
                },
              )
            ],
          )
      ),
    );
  }
  void signUp(String email, String pass) async {
      try{
        AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email , password: pass);
        FirebaseUser user = authResult.user;
        initUserData(user);
        popupDisplaySendingVerification(context);
        user.sendEmailVerification();
        popupVerifyEmailPrompt(context);
        //user.sendEmailVerification();
        //Navigator.push(
        //    context,
        //    MaterialPageRoute(builder: (context) => LoginScreen()));
      }
      catch(e){
        setState(() => _error = e.message);
        popupDisplayError(context, _error);
      }
    }

  Future initUserData(FirebaseUser user) async{

    Map <String, int> groupNYoodoos = new Map();

    return await usersCollection.document(user.uid).setData({
      'name': '',
      'workplace':'',
      'designation':'',
      'groups&yoodoos': groupNYoodoos,
      'myTasks': FieldValue.arrayUnion([])
    });
  }
}

class SignupScreenUI extends StatelessWidget {
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
                      SignupScreen(),
                      //submitButton(),
                      Expanded(
                          flex: 1,
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
      //margin: EdgeInsets.symmetric(horizontal: 5),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            children: [
              TextSpan(
                text: 'Let\'s get started!',
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
                text: 'We are excited to see you here.',
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

  Widget _loginLabel(BuildContext context) {
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
                MaterialPageRoute(builder: (context) => LoginScreenUI()),
              );
            },
            child: Text(
              'Already a member ?  Sign In',
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
