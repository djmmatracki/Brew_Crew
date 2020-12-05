import 'package:brew_crew_app/screens/authenticate/rigister.dart';
import 'package:brew_crew_app/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    // !showSignIn returns the opposite value of boolean
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return SignIn(toggleView: toggleView);
    }
    else return Register(toggleView: toggleView);
  }
}
