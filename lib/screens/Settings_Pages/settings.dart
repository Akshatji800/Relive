import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mental_health/screens/Settings_Pages/AboutUs.dart';
import 'package:mental_health/screens/Settings_Pages/NewPassword.dart';
import 'package:mental_health/screens/Settings_Pages/Help.dart';
import 'package:mental_health/screens/patient_dashboard/fitness_app_home_screen.dart';
import 'package:mental_health/screens/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/services/firebase_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:Colors.cyan,
        elevation: 1,
        leading: IconButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (prefs.getString('login_as') == "doctor"){
              Navigator.of(context).pop();
            }
            else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FitnessAppHomeScreen()));
            }
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 6, right: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 16,
            ),
            Text("  Profile",
               style:TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),),
            SizedBox(
              height: 8,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                        leading: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "https://media.giphy.com/media/B1CrvUCoMxhy8/giphy.gif"),
                            ),
                            Positioned(
                              bottom: 0.0,
                              right: 1.0,
                              child: Container(
                                height: 20,
                                width: 20,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.green, shape: BoxShape.circle),
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          "Sujith",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),
                        ),
                        subtitle: Text(
                          "Talking with computer",
                          style: TextStyle(color: Colors.white,fontSize: 10),

                        ),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => FitnessAppHomeScreen()));
                          //open edit profile
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 15,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ChangePassPage()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),

                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.cyan,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 15,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AboutUsPage()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "About us",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),

                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.cyan,
                      size: 16,
                    ),

                  ],
                ),
              ),
            ),
            Divider(
              height: 15,
              thickness: 1,
            ),

            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HelpPage()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Help",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),

                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.cyan,
                      size: 16,
                    ),

                  ],
                ),
              ),
            ),
            Divider(
              height: 15,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () async {
                FirebaseService service = new FirebaseService();
                await service.signOutFromGoogle();
                Navigator.pushAndRemoveUntil (
                  context,
                  MaterialPageRoute (builder: (BuildContext context) =>  SignInPage()),
                  ModalRoute.withName(''),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.cyan,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 15,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
