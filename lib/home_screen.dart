import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:yoodoo/login_screen.dart';
import 'package:yoodoo/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  AnimationController _controller;

  static const List<IconData> icons = const [Icons.input, Icons.add];

  @override
  void initState() {
    _controller = new AnimationController(vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 25.0,
          title: new Text('Yoodoo',
            style: TextStyle(
              fontFamily: 'TypoHoop',
              fontWeight: FontWeight.w100,
              fontSize: 25.0,
              color: Colors.white
            ),),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: GestureDetector(
                onTap: () {
                  final route = MaterialPageRoute(builder: (BuildContext context) => ProfileScreen());
                  Navigator.of(this.context).pushAndRemoveUntil(route, (Route<dynamic> route) => false);
                },
                child: Icon(
                    Icons.person
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: GestureDetector(
                onTap: () {
                  final route = MaterialPageRoute(builder: (BuildContext context) => LoginScreenUI());
                  Navigator.of(this.context).pushAndRemoveUntil(route, (Route<dynamic> route) => false);
                },
                child: Icon(
                  Icons.exit_to_app
                ),
              ),
            ),
          ],
          backgroundColor: Colors.black,
        ),
        floatingActionButton: new Column(
            mainAxisSize: MainAxisSize.min,
            children: new List.generate(icons.length, (int index) {
              Widget child = new Container(
                height: 70.0,
                width: 56.0,
                alignment: FractionalOffset.topCenter,
                child: new ScaleTransition(
                  scale: new CurvedAnimation(
                    parent: _controller,
                    curve: new Interval(
                        0.0,
                        1.0 - index / icons.length / 2.0,
                        curve: Curves.easeOut
                    ),
                  ),
                  child: new FloatingActionButton(
                    heroTag: null,
                    child: new Icon(icons[index]),
                    onPressed: () {},
                  ),
                ),
              );
              return child;
            }).toList()
              ..add(
                  new FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.black,
                      child: new AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, Widget child) {
                          return new Transform(
                            transform: new Matrix4.rotationZ(
                                _controller.value * 0.5 * math.pi),
                            alignment: FractionalOffset.center,
                            child: new Icon(
                                _controller.isDismissed ? Icons.menu : Icons
                                    .close),
                          );
                        },
                      ),
                      onPressed: () {
                        if (_controller.isDismissed) {
                          _controller.forward();
                        } else {
                          _controller.reverse();
                        }
                      }
                  )
              )
        ),
        //floatingActionButton: FancyFab(),
        body: new Center(
            child: new Text('No groups to show')
        )
    );
  }

}