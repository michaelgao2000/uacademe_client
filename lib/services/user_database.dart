import 'package:client/models/client_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {

  final String uid;
  UserDatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection("users");


  Future updateUserData(String name, int difficultyLevel) async {
    print('add data');
    print(uid);
    return await userCollection.document(uid).setData({
      'name': name,
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

  // get brews stream
  Stream<List<ClientUser>> get users {
    return userCollection.snapshots()
        .map(_clientListFromSnapshot);
  }

}