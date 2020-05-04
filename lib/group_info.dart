import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yoodoo/validators.dart';

class GroupInfo extends StatefulWidget {
  @override
  _GroupInfoState createState() => new _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {

  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();

  final myRewardController = TextEditingController();
  final myPointsController = TextEditingController();

  void dispose() {
    myRewardController.dispose();
    myPointsController.dispose();
    super.dispose();
  }

  List<DataRow> tiles, row = [];
  int index = 0;

  /*final List<Map<String, String>> listOfColumns = [
    {"Name": "AAAAAA", "Number": "1", "State": "Yes"},
    {"Name": "BBBBBB", "Number": "2", "State": "no"},
    //{"Name": "CCCCCC", "Number": "3", "State": "Yes"}
  ];*/

  @override

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text("ADD GROUP",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),

          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Short Description",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      maxLength: 60,
                      validator: blankValidator,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: "Max 60 characters",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    validator: blankValidator,
                                    controller: myRewardController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter reward name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    validator: blankValidator,
                                    controller: myPointsController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter points',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    this.row.add(
                                      row[index] = new DataRow(
                                          cells: [
                                            DataCell(Text(myRewardController.text),),
                                            DataCell(Text(myPointsController.text),),
                                          ])
                                    );
                                  });
                                  index = index+1;
                                  return this.row;
                                },
                                child: Icon(Icons.add),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                                ),
                              )
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text(
                                  'Reward',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                                ),
                                DataColumn(label: Text(
                                  'Points',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                                  numeric: true,
                                ),
                              ],
                              rows: (index > 0) ? row: [],
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                )
              ],
            ),
          )
        ),
      ),
    );
  }

}