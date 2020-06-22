import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference usersCollection = Firestore.instance.collection('users');
final CollectionReference groupsCollection = Firestore.instance.collection('groups');
