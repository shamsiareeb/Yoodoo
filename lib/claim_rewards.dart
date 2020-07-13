import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ClaimRewardsPage extends StatefulWidget{
  @override
  _ClaimRewardsPageState createState() => new _ClaimRewardsPageState();
}

class _ClaimRewardsPageState extends State<ClaimRewardsPage> {

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1E1E1),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: true,
        title: Text('Claim Rewards',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index){
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 25),
                trailing: new GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      border: Border.all(
                        color: Colors.green
                      ),
                    ),
                    child: Text('CLAIM',
                      style: TextStyle(
                        fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.green
                      ),),
                  ),
                ),
                title: new Column(
                  children: [
                    Text('This is a notification, lets see to what extent it goes. And what if I extend it a bit more?',
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [

                    Text('Yoodoos : ',
                      style: TextStyle(
                        fontSize: 17,
                      ),),
                    Text('8',
                      style: TextStyle(
                        fontSize: 17,
                      ),),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}