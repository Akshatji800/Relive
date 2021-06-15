import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/home_page.dart';
import 'package:mental_health/screens/sign_in_page.dart';
import 'package:mental_health/screens/welcome_page.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final auth = FirebaseAuth.instance;

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (FirebaseAuth.instance.currentUser?.uid == null) {
      // signed in
      Timer(
          Duration(seconds: 2),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WelcomePage())));
    } else {
      Timer(
          Duration(seconds: 2),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage())));
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _showPassword = false;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.cyan.shade700,
                Colors.cyan.shade300,
                Colors.cyanAccent
              ])),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(),
                Image.asset("assets/images/ReliveLogo.png",
                    width: double.infinity, height: 90),
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                )
              ])),
    );
  }
}
