import 'package:brew_crew_app/services/auth.dart';
import 'package:brew_crew_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_app/shared/constans.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  // passing the toggleView function as an argument
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  // The _auth instance of class AuthService responsible for authentication
  final AuthService _auth = AuthService();
  // Creating a GlobalKey that will track the state of the forms
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
      elevation: 0.0,
      title: Text("Sign In to brew crew"),
      actions: [
        FlatButton.icon(onPressed: (){
          // set the showSignIn to false
          widget.toggleView();
        },
            icon: Icon(Icons.person),
            label: Text("Register"))
      ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                // if the email is empty then fire an error
                validator: (val) => val.isEmpty ? "Enter an email" : null,
                onChanged: (val){
                setState(() {
                  email = val;
                });
              },),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                // if the password is less then 6 characters then fire an error
                validator: (val) => val.length < 6 ? "Enter a password 6+ chars" : null,
                onChanged: (val){
                password = val;
              },
                obscureText: true,
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                onPressed: () async {
                  // Checking if the email and password is valid using the formKey
                    if (_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      // Signing in with email and password
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      // if the response from the firebase is null then fire an error
                      if(result == null){
                      setState(() {
                        error = 'WRONG PASSWORD OR EMAIL!!!!!!!!';
                        loading = false;
                      });
                    }
                  //print(email);
                  //print(password);
                }},
                color: Colors.pink[400],
                child: Text("Sign In", style: TextStyle(color: Colors.white),)),
              SizedBox(height: 12.0),
              Text(error, style: TextStyle(color: Colors.red, fontSize: 18.0),),
            ],
          ),
        )
      ),
    );
  }
}
