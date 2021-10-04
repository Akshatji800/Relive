import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health/screens/Doctor_Dashboard_Pages/appointments.dart';
import 'package:mental_health/screens/Doctor_Dashboard_Pages/availability.dart';
import 'package:mental_health/screens/Doctor_Dashboard_Pages/important_notifications.dart';
import 'package:mental_health/screens/Doctor_Dashboard_Pages/interaction.dart';
import 'package:mental_health/screens/Doctor_Dashboard_Pages/patients_data.dart';
import 'package:mental_health/screens/Doctor_Dashboard_Pages/reports.dart';
import 'Doctor_Dashboard_Pages/edit_profile.dart';
import 'Settings_Pages/NewPassword.dart';
import 'Settings_Pages/settings.dart';

class DoctorDashBoard extends StatefulWidget {
  @override
  DoctorDashBoardState createState() => new DoctorDashBoardState();
}
User activeDoctor = auth.currentUser!;
class DoctorDashBoardState extends State<DoctorDashBoard> {
  String name = "";
  String specialization = "";
  String hospital = "";
  Uint8List? dashBytes;

  void initState() {
    super.initState();
    activeDoctor = auth.currentUser!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Doctor \'s Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.cyan,
          elevation: 1,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notification_add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ImportantNotificationsPage()));
              },
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('userdata').snapshots(),
          builder: (context, snapshot) {
            var sn = snapshot.data;
            if (sn != null)
              sn.docs.forEach((element) {
                if (element.id == activeDoctor.uid) {
                  try {
                    name = element.get("name");
                  } catch (e) {
                    name = "";
                  }
                  try {
                    specialization = element.get("specialization");
                  } catch (e) {
                    specialization = "";
                  }
                  try {
                    hospital = element.get("hospital");
                  } catch (e) {
                    hospital = "";
                  }
                }
              });
            return FutureBuilder(
              future: ProfilePic(),
              builder: (context, snapshot) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                    Colors.cyan.shade700,
                    Colors.cyan.shade300,
                    Colors.cyanAccent
                  ])),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder:(BuildContext context) => DoctorProfile()));
                          },
                          child: Row(
                            children: <Widget>[
                              (dashBytes!=null) ?CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                Image
                                    .memory(dashBytes!)
                                    .image,
                              ) :
                              CircleAvatar(
                                radius: 30.0,
                                child: Icon(Icons.photo_camera),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Dr. " + name,
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "$specialization ($hospital)",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      OptionsCreater()
                    ],
                  ),
                );
              }
            );
          }
        ));
  }
  ProfilePic() async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(
        bucket: "gs://mental-health-e175a.appspot.com");
    await firebaseStorage
        .ref()
        .child("user/profile/${activeDoctor.uid}")
        .getData(100000000)
        .then((value) => {dashBytes = value!});
    return 1;
  }
}

// ignore: must_be_immutable
class OptionsCreater extends StatelessWidget {
  Items item1 = new Items(
    title: "Patients Data",
    subtitle: "About assigned patients",
    event: "3 Patients",
    img: "assets/patient.png",
  );
  Items item2 = new Items(
    title: "Appointments",
    subtitle: "Info about appointments ",
    event: "4 appointments",
    img: "assets/appointment.png",
  );
  Items item3 = new Items(
    title: "Availability",
    subtitle: "Set your available timings",
    event: "3 slots",
    img: "assets/available.png",
  );
  Items item4 = new Items(
    title: "Interaction",
    subtitle: "Interact with random patients",
    event: "3 random available",
    img: "assets/interaction.png",
  );
  Items item5 = new Items(
    title: "Report",
    subtitle: "Report a patient",
    event: "1 reported",
    img: "assets/report.png",
  );
  Items item6 = new Items(
    title: "Settings",
    subtitle: "Access different settings",
    event: "2 Items",
    img: "assets/settings.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return InkWell(
              onTap: () {
                if (data.title == "Settings") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SettingsPage(role: "doctor")));
                } else if (data.title == "Report") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ReportsPage()));
                } else if (data.title == "Interaction") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => InteractionPage()));
                } else if (data.title == "Availability") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AvailabilityPage()));
                } else if (data.title == "Appointments") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AppointmentsPage()));
                } else if (data.title == "Patients Data") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PatientsDataPage()));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 40,
                          offset: Offset(0, 8))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 58,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.event,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items(
      {required this.title,
      required this.subtitle,
      required this.event,
      required this.img});
}
