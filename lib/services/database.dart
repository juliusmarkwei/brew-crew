import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, int strength, String name) async {
    debugPrint('Logged in user id is - $uid');
    final DocumentReference docRef = brewCollection.doc(uid);

    return await docRef.get().then((doc) {
      if (doc.exists) {
        // If the document exists, update it
        return docRef.update({'sugars': sugars, 'strength': strength, 'name': name});
      } else {
        // If the document does not exist, create it
        return docRef.set({'sugars': sugars, 'strength': strength, 'name': name});
      }
    }).catchError((error) {
      debugPrint('Error updating/creating document: $error');
      throw error;
    });
  }

  // brew list from snapshot
  List<Brew> _brewLiatFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map(
          (doc) => Brew(
              name: (doc.data() as Map<String, dynamic>)['name'] ?? '',
              strength: (doc.data() as Map<String, dynamic>)['strength'] ?? 0,
              sugar: (doc.data() as Map<String, dynamic>)['sugars'] ?? '0'),
        )
        .toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>; // Casting to the correct type
    return UserData(
      uid: uid!,
      name: data['name'],
      strength: data['strength'],
      sugars: data['sugars'],
    );
  }

  // get brews stream
  Stream<List<Brew>> get brew {
    return brewCollection.snapshots().map(_brewLiatFromSnapshot);
  }

  // get user docs stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
