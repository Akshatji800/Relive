import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class DoctorAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
        GoogleFonts.varelaRoundTextTheme(Theme.of(context).textTheme),
      ),
      home: HomeScreen(),
    );
  }
}