import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dialogues.dart';

var rewards = List();
var yoodoos = List();

class ConfigureRewards extends StatefulWidget{
  _RewardScreen createState() => new _RewardScreen();
}

class _RewardScreen extends State<ConfigureRewards> {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text("ADD GROUP",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        //color: Colors.red,
        child: Container(
          height: 60,
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: Text(
                      'Delete a Reward',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    if(rewards.isNotEmpty){
                      rewards.removeLast();
                      yoodoos.removeLast();
                    }
                    else{
                      popupDialog15(context);
                    }
                  },
                ),
              ),
              SizedBox(
                child: Divider(
                  color: Colors.white,
                  thickness: 100,
                ),
              ),
              Expanded(
                child: InkWell(
                  child:  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: Text(
                      'Add a reward',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    popupDialog12(context);
                  },
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
