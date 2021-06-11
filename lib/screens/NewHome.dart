
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/sign_in_page.dart';

class HomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: FlatButton(child: Text('Logout'),onPressed: (){
        auth.signOut();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignInPage()));
      },),),
    );
  }
}