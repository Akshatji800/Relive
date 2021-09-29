import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mental_health/screens/sign_in_page.dart';
import 'package:mental_health/screens/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/services/database.dart';
import 'package:mental_health/utils/google_sign_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

late User user;
double consumed = 0;
double target = 2000;
String WaterFeatureUsedDate = "";
String WaterFeatureUsedTime = "";

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String email, password, username, fullname;
  String error_message = "";
  bool _validate_pass = false;
  bool _validate_email = false;
  bool _validate_username = false;
  bool _validate_fullname = false;
  final auth = FirebaseAuth.instance;
  bool _passwordVisible = true;
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final fullnameController = TextEditingController();

  @override
  // ignore: must_call_super
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
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
                    ],
                  ),
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
                          height: 2,
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: TextFormField(
                                          controller: fullnameController,
                                          keyboardType: TextInputType.text,
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
                                !_validate_fullname
                                    ? Container()
                                    : Text(
                                        "Field cannot be Empty",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: TextFormField(
                                          controller: usernameController,
                                          keyboardType: TextInputType.text,
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
                                !_validate_username
                                    ? Container()
                                    : Text(
                                        "Field cannot be Empty",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
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
                                !_validate_email
                                    ? Container()
                                    : Text(
                                        "$error_message",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: TextFormField(
                                          controller: passwordController,
                                          keyboardType: TextInputType.text,
                                          obscureText: !_passwordVisible,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.lock),
                                            hintText: 'Enter your password',
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                // Based on passwordVisible state choose the icon
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.black45,
                                              ),
                                              onPressed: () {
                                                // Update the state i.e. toogle the state of passwordVisible variable
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                !_validate_pass
                                    ? Container()
                                    : Text(
                                        "$error_message",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            password = passwordController.text;
                            username = usernameController.text;
                            fullname = fullnameController.text;
                            setState(() {
                              if (username.length > 0) {
                                _validate_username = false;
                                if (fullname.length > 0) {
                                  _validate_fullname = false;
                                  _signup(email, password);
                                }
                              } else {
                                if (username.length == 0) {
                                  _validate_username = true;
                                }
                                if (fullname.length == 0) {
                                  _validate_fullname = true;
                                }
                              }
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
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignInPage()));
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
                        GoogleSignIn(buttonText: "Sign up with Google"),
                        SizedBox(
                          height: 10,
                        ),
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

  _signup(String _email, String _password) async {
    try {
      //Create Get Firebase Auth User
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('password', password);
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((_) async {
        user = auth.currentUser!;
        await DatabaseService(uid: user.uid).updateUserData(fullname, username, email);
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Select Role As:'),
                  content: Container(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                            password = passwordController.text;
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('login_as', "patient");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifyScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                  child: const Text('Patient'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                            password = passwordController.text;
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('login_as', "doctor");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifyScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                  child: const Text('Doctor'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
      });
    } on FirebaseAuthException catch (error) {
      error_message = error.message.toString();
      setState(() {
        if (error_message == "Password should be at least 6 characters") {
          _validate_pass = true;
          _validate_email = false;
        } else {
          if (error_message == "The email address is badly formatted.") {
            error_message = "Invalid email";
            _validate_email = true;
            _validate_pass = false;
          } else {
            Fluttertoast.showToast(msg: error_message, gravity: ToastGravity.TOP);
            _validate_email = false;
            _validate_pass = false;
          }
        }
      });
    }
  }
}
