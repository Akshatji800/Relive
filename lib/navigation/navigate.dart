import 'package:mental_health/screens/home_page.dart';
import 'package:mental_health/screens/sign_in_page.dart';
import 'package:mental_health/screens/welcome_page.dart';
import 'package:flutter/material.dart';




class Navigate {
  static Map<String, Widget Function(BuildContext)> routes =   {
    '/' : (context) => WelcomePage(),
    '/sign-in' : (context) => SignInPage(),
    '/home'  : (context) => HomePage()
  };
}