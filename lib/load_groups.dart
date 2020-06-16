import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yoodoo/login_screen.dart';

var groups = List(); // stores IDs of groups which the user is a member of
var groupNames = List();
var groupDescriptions = List();
var groupOwners = List();

CollectionReference groupsCollection = Firestore.instance.collection('groups');

void loadGroupsData(FirebaseUser user){

  usersCollection.document(user.uid).get().then((DocumentSnapshot ds){
    groups = (ds['groups']);
  });

  if (groups.length == 0){
    //TODO display 'no groups to show' on homescreen
  }
  else{
    for (int i = 0; i < groups.length ; i++){
      groupsCollection.document(groups[i]).get().then((DocumentSnapshot ds){
        groupNames.add(ds['groupName']);
        groupDescriptions.add(ds['groupDescription']);
        groupOwners.add(ds['ownerName']);
      });
    }
  }
}