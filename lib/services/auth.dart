import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/models/user.dart' as u;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create a user obj based on firebase user
  u.User? _userFromFirebaseUser(User? user) {
    return user != null ? u.User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<u.User?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //  sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // sign in with email nd password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user; // Change type to User?

      if (user == null) return null;

      // create a new document for a user with uid
      await DatabaseService(uid: user.uid).updateUserData('0', 100, 'new crew member');
      debugPrint('--------------------------- User data updated in the brew collections');
      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
