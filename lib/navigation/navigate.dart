import 'package:mental_health/screens/patient_dashboard/fitness_app_home_screen.dart';
import 'package:mental_health/screens/sign_in_page.dart';
import 'package:mental_health/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/sign_up_page.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes =   {
    '/initial-screen' : (context) => Splashscreen(),
    '/sign-in' : (context) => SignInPage(),
    '/sign-up' : (context) => SignUpPage(),
    '/home'  : (context) => FitnessAppHomeScreen(),
  };
}