import 'package:brew_crew_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew_app/models/brew.dart';


class DatabaseService {

  final String uid; // Database for the exact user
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection("brews");
  // Creating or referring to the Brews collection
  // Collection of Brews

  Future updateUserData(String sugars, String name, int strength) async {
    // updating the user data for the brew collection
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }
  // brew list from snapshot
  List<Brew> _brewListSnapshot(QuerySnapshot snapshot) {
    // returns a list of Brew objects
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data["name"] ?? '',
        strength: doc.data["strength"] ?? 0,
        sugars: doc.data['sugars'] ?? '0',
      );
    }).toList();
  }
  // userData from snapshot
  UserData _userDataFromSnapshot( DocumentSnapshot snapshot){
    // returns an instance of class UserData converted from a snapshot
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    // returns a stream of brew objects converted by the ._brewListSnapshot
    // returns all of the brews in the collection
    .map(_brewListSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData{
    // gets the userData from the brewCollection for the exact uid
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }


}