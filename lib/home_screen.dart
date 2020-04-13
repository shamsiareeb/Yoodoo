import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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
          title: new Text('GROUPS',
            style: TextStyle(
              //fontFamily: 'AzoSans-Regular',
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: Colors.white
            ),),
          backgroundColor: Colors.black,
          leading: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Material(
              shape: new CircleBorder(),
              //color: Colors.grey,
            ),
          ),
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