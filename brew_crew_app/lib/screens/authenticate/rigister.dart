import 'package:brew_crew_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_app/services/auth.dart';
import 'package:brew_crew_app/shared/constans.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // main authentication variable
  final AuthService _auth = AuthService();
  // creating a global key that tracks the form and tries to validate it
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      // if loading is true then present the Loading widget else present the Register widget
      backgroundColor: Colors.brown[100],
      appBar: AppBar(backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign up to brew crew"),
        actions: [
          FlatButton.icon(onPressed: (){
            // changes the showSignIn value to true
            widget.toggleView(); // change the widget to the sign in screen
          },
              icon: Icon(Icons.person),
              label: Text("Sign In"))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                // Text form for the email
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  // If the email is empty then fire an error
                  validator: (val) => val.isEmpty ? "Enter an email" : null,
                  onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },),
                SizedBox(height: 20.0,),
                // Text form for the password
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Password"),
                  // If the password is less then 6 characters then fire an error
                  validator: (val) => val.length < 6 ? "Enter a password 6+ chars" : null,
                  onChanged: (val){
                  password = val;
                },
                  obscureText: true,
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  onPressed: () async {
                    // Checking if the validation is correct
                    if (_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      // registering a new user with email and password
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      // If the result from the firebase authentication is null then fire an error
                      if(result == null){
                        setState(() {
                          error = 'please supply a valid email';
                          loading = false;
                        });
                      //print(email);
                      //print(password);
                    }
                  }},
                  color: Colors.pink[400],
                  child: Text("Register",
                    style: TextStyle(color: Colors.white))
                ),
                SizedBox(height: 12.0),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),),
              ],
            ),
          )
      ),
    );
  }
}
