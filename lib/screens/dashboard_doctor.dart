import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/services/firebase_Service.dart';
import 'package:mental_health/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoctorDashBoard extends StatefulWidget {
  DoctorDashBoard({Key? key}) : super(key: key);

  @override
  _DoctorDashBoardState createState() => _DoctorDashBoardState();
}

class _DoctorDashBoardState extends State<DoctorDashBoard> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                FirebaseService service = new FirebaseService();
                await service.signOutFromGoogle();
                Navigator.pushReplacementNamed(
                    context, Constants.signInNavigate);
              },
            )
          ],
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
          title: Text("Doctor's DashBoard"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user!.email!),
          ],
        )));
  }
}
