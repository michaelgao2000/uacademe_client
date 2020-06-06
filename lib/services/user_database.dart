import 'dart:html';

import 'package:client/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {

  final String uid;

  UserDatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection(
      "users");

  Future updateUserData(String name, int difficultyLevel) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'difficulty': difficultyLevel,
    });
  }

  // user list from snapshot
  List<User> _clientListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
          name: doc.data['name'] ?? '',
          difficulty: doc.data['difficulty'] ?? 5
      );
    }).toList();
  }

  // get users stream
  Stream<List<User>> get users {
    return userCollection.snapshots()
        .map(_clientListFromSnapshot);
  }

  // user from snapshot
  User _userFromDocumentSnapshot(DocumentSnapshot snapshot) {
    return User(
        name: snapshot.data['name'] ?? '',
        uid: snapshot.data['uid'],
        difficulty: snapshot.data['difficulty'] ?? 5
    );
  }

  // get logged-in user stream
  Stream<User> get thisUser {
    return userCollection.document(uid).snapshots()
        .map(_userFromDocumentSnapshot);
  }

  Future addStrategy(String category, DocumentReference question,
      String mistake, String strategy) async {
    return await userCollection.document(uid).collection(category).add({
      'questionPath': question,
      'mistake': mistake,
      'strategy': strategy,
    });
  }


}