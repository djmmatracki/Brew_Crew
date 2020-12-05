import 'package:brew_crew_app/models/brew.dart';
import 'package:brew_crew_app/screens/home/settings_form.dart';
import 'package:brew_crew_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_app/services/database.dart';
import 'package:provider/provider.dart';
import 'brewlist.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }
    return StreamProvider<List<Brew>>.value(
      // passing the stream from the Database
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async{
                  // Using the signOut() method of the AuthService class
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text("logout")),
            FlatButton.icon(
                onPressed: (){
                  return _showSettingsPanel();
                },
                icon: Icon(Icons.settings),
                label: Text("Settings"))
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
