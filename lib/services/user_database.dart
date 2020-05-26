import 'package:client/models/client_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {

  final String uid;

  UserDatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection(
      "users");


  Future updateUserData(String name, int difficultyLevel) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'uid': uid,
      'difficulty': difficultyLevel,
    });
  }

  // user list from snapshot
  List<ClientUser> _clientListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ClientUser(
          name: doc.data['name'] ?? '',
          difficulty: doc.data['difficulty'] ?? 5
      );
    }).toList();
  }

  // get users stream
  Stream<List<ClientUser>> get users {
    return userCollection.snapshots()
        .map(_clientListFromSnapshot);
  }

  // user from snapshot
  ClientUser _clientUserFromDocumentSnapshot(DocumentSnapshot snapshot) {
    return ClientUser(
        name: snapshot.data['name'] ?? '',
        uid: snapshot.data['uid'],
        difficulty: snapshot.data['difficulty'] ?? 5
    );
  }

  // get logged-in user stream
  Stream<ClientUser> get thisUser {
    return userCollection.document(uid).snapshots()
        .map(_clientUserFromDocumentSnapshot);
  }
}