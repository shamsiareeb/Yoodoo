import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yoodoo/main.dart';

class RewardList extends StatefulWidget {
  @override
  _RewardListState createState() => _RewardListState();
}

class _RewardListState extends State<MyApp> {
  List<DynamicWidget> listDynamic = [];

  addDynamic() {

    listDynamic.add(new DynamicWidget());
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text("REWARD LIST",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: new C,
    );
  }
}