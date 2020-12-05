import 'package:brew_crew_app/models/user.dart';
import 'package:brew_crew_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  // Creating a firebase auth instance
  // The main instance responsible for authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  // converting a FirebaseUser into a custom User class
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }


  // auth change user stream
  // returns a converted Stream(list) of Firebase users whenever there is a change of authentication
  // Stream is something like a list but its a Stream of data. That's why we can use .map method
  Stream<User> get user {
    return _auth.onAuthStateChanged // Notifies if there is a change in authentication
    // .map((FirebaseUser user) => _userFromFirebaseUser(user)); same thing as down
    .map(_userFromFirebaseUser);
  }

  // sigh in anon
  Future signInAnon() async {
    try {
      // using the .signInAnonymously() method on our main _auth instance
      // getting the result which is a list of different data
      AuthResult result = await _auth.signInAnonymously();
      //print(result);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      //print(result);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch (e){
      print(e.toString());
      return null;
    }}

  //register with email
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // Creating a user with email and password
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData("0", 'new member', 100);
      // Updating user data to the Database
      return _userFromFirebaseUser(user);
    }catch (e){
      print(e.toString());
      return null;
    }

  }

  // sign out
  Future signOut() async {
    try {
      // using a .signOut() method on our main _auth instance
      return await _auth.signOut();
    }catch (e){
      print(e.toString());
      return null;
    }
  }
}