import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mental_health/screens/patient_dashboard/fitness_app_theme.dart';
import 'package:mental_health/services/database.dart';
import 'package:mental_health/services/locator.dart';
import 'package:mental_health/services/user_controller.dart';
import '../dashboard_doctor.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

XFile? image;

class _DoctorProfileState extends State<DoctorProfile> {
  String name = "";
  String specialization = "";
  String hospital = "";
  String email = "";
  String phoneNumber = "";
  String about = "";
  String username = "";
  Uint8List? imageBytes;
  Uint8List? newBytes;
  bool picked = false;
  var nameController = TextEditingController();
  var specializationController = TextEditingController();
  var hospitalController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var aboutController = TextEditingController();
  var usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    picked = false;
  }

  @override
  Widget build(BuildContext context) {
    ImagePicker _picker = ImagePicker();
    return Scaffold(
      backgroundColor: FitnessAppTheme.background,
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.cyan,
          elevation: 0.0,
          bottomOpacity: 0.0,
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
        body: StreamBuilder<QuerySnapshot>(
            stream:
            FirebaseFirestore.instance.collection('userdata').snapshots(),
            builder: (context, snapshot) {
              var sn = snapshot.data;
              if (sn != null)
                sn.docs.forEach((element) {
                  if (element.id == activeDoctor.uid) {
                    try {
                      name = element.get("name");
                      email = element.get("email");
                      username = element.get("username");
                    } catch (e) {
                      name = "";
                      email = "";
                      username = "";
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
                    try {
                      about = element.get("about");
                    } catch (e) {
                      about = "";
                    }
                    try {
                      phoneNumber = element.get("phone");
                    } catch (e) {
                      phoneNumber = "";
                    }
                  }
                });
              return FutureBuilder(
                  future: loadProfilePic(),
                  builder: (context, snapshot) {
                    return SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Material(
                              elevation: 5,
                              color: Colors.cyan,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                              child: Container(
                                padding: EdgeInsets.only(left: 16, top: 6, right: 16),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Complete your Profile",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text("Add a profile picture, name and photo to let "
                                          "people know who you are.",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            image = await _picker.pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 80);
                                            if (image != null) {
                                              newBytes =
                                                  File(image!.path).readAsBytesSync();
                                              setState(() {
                                                picked = true;
                                              });
                                            }
                                          },
                                          child: (picked)
                                              ? CircleAvatar(
                                            radius: 60.0,
                                            backgroundImage:
                                            Image
                                                .memory(newBytes!)
                                                .image,
                                            child: addIcon(),
                                          )
                                              : (imageBytes != null)
                                              ? CircleAvatar(
                                            radius: 60.0,
                                            backgroundImage:
                                            Image
                                                .memory(imageBytes!)
                                                .image,
                                            child: addIcon(),
                                          )
                                              : CircleAvatar(
                                            radius: 60.0,
                                            child: Icon(Icons.photo_camera),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: TextField(
                                          controller: nameController..text = name,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white),
                                            ),
                                            hintText: "Enter your full name",
                                            prefixText: "Dr. ",
                                            prefixStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            icon: Icon(Icons.person, color: Colors.white,),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Username"),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                    child: TextField(
                                      controller: usernameController..text = username,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter you username"
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Specialization"),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                    child: TextField(
                                      controller: specializationController
                                        ..text = specialization,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter specialization",
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Hospital"),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                    child: TextField(
                                      controller: hospitalController..text = hospital,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter hospital",
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("E-mail"),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                    child: TextField(
                                      controller: emailController..text = email,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter email",
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Phone number"),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                    child: TextField(
                                      controller: phoneController..text = phoneNumber,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter phone number",
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Bio"),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                    child: TextField(
                                      controller: aboutController..text = about,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Tell us something about your experience",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Container(
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () {
                                      updateUser();
                                      if (image != null) {
                                        locator
                                            .get<UserController>()
                                            .uploadProfilePicture(
                                            File(image!.path));
                                      }
                                    },
                                    child: Text("Update Profile".toUpperCase(),
                                        style: TextStyle(fontSize: 14)),
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.cyan),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(30.0),
                                                side: BorderSide(
                                                    color: Colors.cyan))))),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }

  void updateUser() async {
    await DatabaseService(uid: activeDoctor.uid).updateDoctorUserData(
        nameController.text,
        usernameController.text,
        emailController.text,
        specializationController.text,
        hospitalController.text,
        phoneController.text,
        aboutController.text,
      "doctor",
    );
  }

  void rebuildAll(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  loadProfilePic() async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(
        bucket: "gs://mental-health-e175a.appspot.com");
    await firebaseStorage
        .ref()
        .child("user/profile/${activeDoctor.uid}")
        .getData(100000000)
        .then((value) => {imageBytes = value!});
    return 1;
  }

  Widget addIcon() {
    return Align(
      alignment: Alignment.bottomRight,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 12.0,
        child: Icon(
          Icons.camera_alt,
          size: 15.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
