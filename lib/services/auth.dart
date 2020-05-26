import 'package:client/services/user_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:client/models/auth_user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  AuthUser _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? new AuthUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AuthUser> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }


  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      // create user
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // make user in database with the uid and pass in default value for difficulty
      await UserDatabaseService(uid: user.uid).updateUserData("Name", 5);

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}