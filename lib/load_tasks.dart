import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/load_groups.dart';
import 'home_screen.dart';
import 'create_instances.dart';
import 'login_screen.dart';

var tasks = new List();
var taskNames = new List();
var taskDescriptions = new List();
var taskPriorities = new List();
var taskAcceptors = new List();
var taskStatuses = new List();
List<MaterialAccentColor> tpc= new List<MaterialAccentColor>();

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

Future <void> loadTasksData(int index) async {
  try {
    tasks.clear();
    taskDescriptions.clear();
    taskPriorities.clear();
    taskAcceptors.clear();
    taskStatuses.clear();
  }
  catch(NoSuchMethodError) {
    print('Array contains nothing');
  }
    await groupsCollection.document(groups[index]).get().then((
        DocumentSnapshot ds) {
      tasks = (ds['taskuids']);
    });
    if (tasks.length != 0) {
      CollectionReference tasksCollection = Firestore.instance.collection('groups/'+groups[groupIndex]+'/tasks');
      for (int i = 0; i < tasks.length; i++) {
        await tasksCollection.document(tasks[i]).get().then((
            DocumentSnapshot ds){
          taskNames[i] = (ds['taskName']);
          taskDescriptions[i] = (ds['taskDescription']);
          taskPriorities[i] = (ds['taskPriority']);
          taskAcceptors[i] = (ds['taskAcceptor']);
          taskStatuses[i] = (ds['taskStatus']);
          if(taskPriorities[i] == "Colors.redAccent")
            tpc[i] = Colors.redAccent;
          else if (taskPriorities[i] == "Colors.orangeAccent")
            tpc[i] = Colors.orangeAccent;
          else
            tpc[i] = Colors.greenAccent;
        });
      }
    }
    else{
      print(tasks);
    }
  }