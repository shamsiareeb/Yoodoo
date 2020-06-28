import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yoodoo/load_groups.dart';
import 'home_screen.dart';
import 'create_instances.dart';
import 'login_screen.dart';

var tasks = new List();
var taskDescriptions = new List();
var taskPriorities = new List();

Future <void> checkGroupOwner(int index) async{
  String ownerId;
  await groupsCollection.document(groups[index]).get().then((DocumentSnapshot ds) {
    ownerId = (ds['ownerId']);
  });
  if(user.uid == ownerId){
    ownerFlag = true;
  }
  else{
    ownerFlag = false;
  }
}

Future <void> loadTasksData(int index) async{
  tasks.clear();
  taskDescriptions.clear();
  taskPriorities.clear();
  await groupsCollection.document(groups[index]).get().then((DocumentSnapshot ds) {
    tasks = (ds['taskNames']);
    taskDescriptions = (ds['taskDescriptions']);
    taskPriorities = (ds['taskPriorities']);
  });
}

