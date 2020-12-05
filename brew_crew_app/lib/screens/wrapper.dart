import 'package:brew_crew_app/screens/authenticate/authenticate.dart';
import 'package:brew_crew_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_app/models/user.dart';


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // getting the data from the main Widget
    final user = Provider.of<User>(context);
    // returns either an instance of user or null

    // return either Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}
