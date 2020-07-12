import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'create_instances.dart';

var groups = List(); // stores IDs of groups which the user is a member of
var groupNames = List();
var groupDescriptions = List();
var groupOwners = List();
var myYoodoos = List();
var individualGroupMembers = List();
List allGroupMembers = List();
bool check;

Future <bool> loadGroupsData(FirebaseUser user) async {
  groups.clear();
  groupNames.clear();
  groupOwners.clear();
  groupDescriptions.clear();
  await usersCollection.document(user.uid).get().then((DocumentSnapshot ds) {
    groups = (ds['groups']);
    myYoodoos = (ds['myYoodoos']);
  });
  return await calcArrayLength();
}

Future<bool> calcArrayLength() async{

  if (groups.length == 0){
    return false;
  }
  else{
    for (int i = 0; i < groups.length ; i++){
      await groupsCollection.document(groups[i]).get().then((DocumentSnapshot ds){
        groupNames.add(ds['groupName']);
        groupDescriptions.add(ds['groupDescription']);
        groupOwners.add(ds['ownerName']);
        individualGroupMembers.add(ds['members']);
        allGroupMembers.add(individualGroupMembers.last);
      });
    }
  }
  return true;
}

