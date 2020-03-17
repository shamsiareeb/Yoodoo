import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:yoodoo/home_screen.dart';

class LoginScreen extends StatefulWidget{
  _LoginForm createState() => new _LoginForm();
}
class _LoginForm extends State<LoginScreen>{
  final formKey = GlobalKey<FormState>();
  Widget build(BuildContext context){
    return Form(
        child: Padding(
            padding: EdgeInsets.only(
                left: 25.0,
                top: 280.0,
                right: 25.0
            ),
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'example@xyz.com',
                      labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 24
                      ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.red)
                    )
                  ),
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 24
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.red)
                      ),
                    hintText: 'NAI DOONGA!!!!'
                  )
                ),

                RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen())
                    );
                  },
                  child: Text(
                      'ENTER',
                       style: TextStyle(color:Colors.white))
                )
              ],
            )
        )
    );
  }
}
class LoginScreenUI extends StatelessWidget {
  Widget build(BuildContext context){
    return new Material(
        child: CustomPaint(
            painter: MyPainter(),
            child: LoginScreen()
        )
    );
  }
}
class MyPainter extends CustomPainter{
  void paint(Canvas canvas, Size size){
    final greenCenter = Offset(330, 75);
    final greenRadius = 120.0;
    final greenPaint = Paint()
      ..color = Colors.green;
    canvas.drawPaint(new Paint()..color = Colors.white);
    canvas.drawCircle(greenCenter, greenRadius, greenPaint);
    final yellowCenter = Offset(-23, 200);
    final yellowRadius = 80.0;
    final yellowPaint = Paint()
      ..color = Colors.yellow;
    canvas.drawCircle(yellowCenter, yellowRadius, yellowPaint);
    final redCenter = Offset(230, 250);
    final redRadius = 50.0;
    final redPaint = Paint()
      ..color = Colors.red;
    canvas.drawCircle(redCenter, redRadius, redPaint);

    TextSpan loginSpan = new TextSpan(
        style: new TextStyle(
            color: Colors.green,
            fontSize: 32.0,
            fontWeight: FontWeight.w400
        ),
        text: 'LOGIN'
    );

    TextPainter tp = new TextPainter(
        text: loginSpan,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr
    );
    tp.layout();
    tp.paint(canvas, Offset(25,135));
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return null;
  }
}
