import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientsDataPage extends StatefulWidget {
  @override
  DoctorDashBoardState createState() => DoctorDashBoardState();
}

class DoctorDashBoardState extends State<PatientsDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patients Data',
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
