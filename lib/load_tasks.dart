import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoodoo/load_groups.dart';
import 'home_screen.dart';
import 'create_instances.dart';
import 'login_screen.dart';

var tasks = new List();
var taskDescriptions = new List();
var taskPriorities = new List();
var taskAcceptors = new List();
var taskStatus = new List();
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

Future <void> loadTasksData(int index) async{
  tasks.clear();
  taskDescriptions.clear();
  taskPriorities.clear();
  taskAcceptors.clear();
  taskStatus.clear();
  await groupsCollection.document(groups[index]).get().then((DocumentSnapshot ds) {
    tasks = (ds['taskNames']);
    taskDescriptions = (ds['taskDescriptions']);
    taskPriorities = (ds['taskPriorities']);
    taskAcceptors = (ds['taskAcceptors']);
    taskStatus = (ds['taskStatus']);
  });
  if(taskPriorities.isNotEmpty){
    for (int i = 0; i < taskPriorities.length; i++){
      print(i);
      if(taskPriorities[i] == "Colors.greenAccent") {
        tpc.add(Colors.greenAccent);

      }
      else if(taskPriorities[i] == "Colors.orangeAccent") {
        tpc.add(Colors.orangeAccent);
      }
      else {
        tpc.add(Colors.redAccent);
      }
    }
  }
}