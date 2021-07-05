import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/dashboard_doctor.dart';
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
  String null_check_error_message = "";

  checkLogin() async {
    try {
      user = auth.currentUser!;
    }
    catch (error){
      null_check_error_message = error.toString();
      if (null_check_error_message == "Null check operator used on a null value") {
        Timer(
            Duration(seconds: 1),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomePage())));
      }
    }
    if (FirebaseAuth.instance.currentUser?.uid == null || user.emailVerified == false) {
      // signed in
      Timer(
          Duration(seconds: 1),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WelcomePage())));
    } else {
      //if (user.emailVerified) {
        Timer(Duration(seconds: 1), () => user_exist_auth());
      //}
    }
  }

  user_exist_auth() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('login_as') == "doctor") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DoctorDashBoard()));
    } else if (pref.getString('login_as') == "patient") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                )
              ])),
    );
  }
}
