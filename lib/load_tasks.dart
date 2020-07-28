import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/load_groups.dart';
import 'home_screen.dart';
import 'create_instances.dart';
import 'login_screen.dart';

List <String> tasks = new List();
var taskNames = new List();
var taskDescriptions = new List();
var taskPriorities = new List();
var taskAcceptors = new List();
List <int> taskStatuses = new List();
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

Future <void> loadTasksOfGroup(int index) async {
  try {
    tasks.clear();
    taskNames.clear();
    taskDescriptions.clear();
    taskPriorities.clear();
    taskAcceptors.clear();
    taskStatuses.clear();
    tpc.clear();
  }
  catch(NoSuchMethodError) {
    print('Array contains nothing');
  }
    await groupsCollection.document(groups[index]).get().then((
        DocumentSnapshot ds) {
      tasks = (ds['taskuids']);
      print(tasks);
    });
    if (tasks.length != 0) {
      CollectionReference tasksCollection = Firestore.instance.collection('groups/'+groups[groupIndex]+'/tasks');
      for (int i = 0; i < tasks.length; i++) {
        await tasksCollection.document(tasks[i]).get().then((
            DocumentSnapshot ds){
          taskNames.add((ds['taskName']));
          taskDescriptions.add((ds['taskDescription']));
          taskPriorities.add((ds['taskPriority']));
          taskAcceptors.add((ds['taskAcceptor']));
          taskStatuses.add((ds['taskStatus']));
          if(taskPriorities.elementAt(i) == "Colors.redAccent")
            tpc.add(Colors.redAccent);
          else if (taskPriorities.elementAt(i) == "Colors.orangeAccent")
            tpc.add(Colors.orangeAccent);
          else
            tpc.add(Colors.greenAccent);
        });
      }
      print(taskNames);
      print(taskDescriptions);
      print(taskAcceptors);
      print(taskStatuses);
      print(tpc);
    }
    else{
      print(tasks);// for unit testing
    }
  }