import 'package:mental_health/screens/patient_dashboard/fitness_app_home_screen.dart';
import 'package:mental_health/screens/sign_in_page.dart';
import 'package:mental_health/screens/splashscreen.dart';
import 'package:mental_health/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/sign_up_page.dart';



class Navigate {
  static Map<String, Widget Function(BuildContext)> routes =   {
    '/' : (context) => WelcomePage(),
    '/sign-in' : (context) => SignInPage(),
    '/sign-up' : (context) => SignUpPage(),
    '/home'  : (context) => FitnessAppHomeScreen(),
    '/initial-screen' : (context) => Splashscreen()
  };
}