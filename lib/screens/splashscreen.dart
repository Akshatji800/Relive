import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/dashboard_doctor.dart';
import 'package:mental_health/screens/patient_dashboard/fitness_app_home_screen.dart';
import 'package:mental_health/screens/sign_in_page.dart';
import 'package:mental_health/screens/welcome_page.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final auth = FirebaseAuth.instance;
  String nullCheckErrorMessage = "";

  checkLogin() async {
    try {
      user = auth.currentUser!;
    }
    catch (error){
      nullCheckErrorMessage = error.toString();
      if (nullCheckErrorMessage == "Null check operator used on a null value") {
        Timer(
            const Duration(seconds: 1),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const WelcomePage())));
      }
    }
    if (FirebaseAuth.instance.currentUser?.uid == null || user.emailVerified == false) {
      // signed in
      Timer(
          const Duration(seconds: 1),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const WelcomePage())));
    } else {
      //if (user.emailVerified) {
        Timer(const Duration(seconds: 1), () => userExistAuth());
      //}
    }
  }

  userExistAuth() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('login_as') == "doctor") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const DoctorDashBoard()));
    } else if (pref.getString('login_as') == "patient") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const FitnessAppHomeScreen()));
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
                const SizedBox(),
                Image.asset("assets/images/ReliveLogo.png",
                    width: double.infinity, height: 90),
                const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                )
              ])),
    );
  }
}
