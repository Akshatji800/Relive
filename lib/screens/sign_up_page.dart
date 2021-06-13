import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mental_health/screens/home_page.dart';
import 'package:mental_health/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/services/firebase_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String email, password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    bool _showPassword = false;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.cyan.shade700,
          Colors.cyan.shade300,
          Colors.cyanAccent
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Create Your Account",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        " Please enter your info to create account",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      //Text("Register", style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  //Image.asset("assets/images/sign.png",width: 120,height: 100),
                ],
              ),
            ),
            SizedBox(height: 13),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 25,
                          offset: Offset(0, 10))
                    ]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "  Sign up",
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //Text("    Full name",style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                    // boxShadow: [BoxShadow(
                                    //     color: Colors.black12,
                                    //     blurRadius: 25,
                                    //     offset: Offset(0, 2)
                                    // )]
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.person),
                                              hintText: "Enter your full name",
                                              hintStyle: TextStyle(
                                                  color: Colors.black45),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //Text("    Username",style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                    // boxShadow: [BoxShadow(
                                    //     color: Colors.black12,
                                    //     blurRadius: 25,
                                    //     offset: Offset(0, 2)
                                    // )]
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: TextField(
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.person),
                                              hintText: "Enter your username",
                                              hintStyle: TextStyle(
                                                  color: Colors.black45),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //Text("    Mail id",style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                    // boxShadow: [BoxShadow(
                                    //     color: Colors.black12,
                                    //     blurRadius: 25,
                                    //     offset: Offset(0, 2)
                                    // )]
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: TextField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.mail),
                                            hintText: "Enter your mail id",
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              email = value.trim();
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //Text("    Password",style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                    // boxShadow: [BoxShadow(
                                    //     color: Colors.black12,
                                    //     blurRadius: 25,
                                    //     offset: Offset(0, 2)
                                    // )]
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: TextField(
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.lock),
                                              hintText: "Enter your password",
                                              hintStyle: TextStyle(
                                                  color: Colors.black45),
                                              border: InputBorder.none),
                                          onChanged: (value) {
                                            setState(() {
                                              password = value.trim();
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('email', email);
                            prefs.setString('password', password);
                            auth
                                .createUserWithEmailAndPassword(
                                    email: email, password: password)
                                .then((_) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            });
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 75),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.cyan.shade500,
                                border: Border.all(color: Colors.black12),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 1,
                                      blurRadius: 4)
                                ]),
                            child: Center(
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?"),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      Constants.signInNavigate,
                                      (route) => false);
                                },
                                child: Container(
                                  child: Text("Sign in",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.cyan.shade500,
                                      )),
                                ),
                              )
                            ]),
                        SizedBox(
                          height: 10,
                        ),
                        buildRowDivider(size: size),
                        SizedBox(
                          height: 10,
                        ),
                        GoogleSignIn()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRowDivider({required Size size}) {
    return SizedBox(
      width: size.width * 0.8,
      child: Row(children: <Widget>[
        Expanded(child: Divider(color: Colors.grey)),
        Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              "Or",
              style: TextStyle(color: Colors.grey),
            )),
        Expanded(child: Divider(color: Colors.grey)),
      ]),
    );
  }
}

class GoogleSignIn extends StatefulWidget {
  GoogleSignIn({Key? key}) : super(key: key);

  @override
  _GoogleSignInState createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !isLoading
        ? SizedBox(
            width: size.width * 0.8,
            height: 50,
            child: OutlinedButton.icon(
              icon: Image.asset("assets/images/google-logo.png",
                  width: 30, height: 30),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                FirebaseService service = new FirebaseService();
                try {
                  await service.signInwithGoogle();
                  Navigator.pushNamedAndRemoveUntil(
                      context, Constants.homeNavigate, (route) => false);
                } catch (e) {
                  if (e is FirebaseAuthException) {
                    showMessage(e.message!);
                  }
                }
                setState(() {
                  isLoading = false;
                });
              },
              label: Text(
                Constants.textSignUpGoogle,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.cyan.shade500,
                  shadowColor: Colors.black45,
                  elevation: 8,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
            ),
          )
        : CircularProgressIndicator();
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
