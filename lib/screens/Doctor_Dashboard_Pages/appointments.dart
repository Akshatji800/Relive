import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentsPage extends StatefulWidget {
  @override
  DoctorDashBoardState createState() => DoctorDashBoardState();
}

class DoctorDashBoardState extends State<AppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointments',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
