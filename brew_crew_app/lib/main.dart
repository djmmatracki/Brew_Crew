import 'package:brew_crew_app/models/user.dart';
import 'package:brew_crew_app/screens/wrapper.dart';
import 'package:brew_crew_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    // Returns a StreamProvider of User objects the value is the Stream of Users
    // passed in the AuthService.user method
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        // Then we pass the Stream of Users to the Wrapper class
        home: Wrapper(),
      ),
    );
  }
}