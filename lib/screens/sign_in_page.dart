import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mental_health/screens/home_page.dart';
import 'package:mental_health/screens/reset_password.dart';
import 'package:mental_health/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/utils/google_sign_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_doctor.dart';
late User user;
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late String email, password;
  bool _validate_pass = false;
  bool _validate_email = false;
  String error_message = "";
  final auth = FirebaseAuth.instance;
  bool _passwordVisible = true;
  final passwordController = TextEditingController();

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
              height: 50,
            ),
            Image.asset("assets/images/sign-in.png",
                width: double.infinity, height: 200),
            SizedBox(
              height: 6,
            ),
            Padding(
              padding: EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(Constants.textSignInTitle,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w300)),
                      SizedBox(
                        height: 1,
                      ),
                      Center(
                        child: Text(
                          Constants.textSmallSignIn,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
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
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
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
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
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
                                            hintText: "Enter your mail ID",
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
                                  height: 10,
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
                                        child: TextFormField(
                                          controller: passwordController,
                                          keyboardType: TextInputType.text,
                                          obscureText: !_passwordVisible,
                                          //This will obscure text dynamically
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Forgot Password?"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ResetScreen()));
                                },
                                child: Container(
                                  child: Text("To Reset Click Here!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.cyan.shade500,
                                      )),
                                ),
                              )
                            ]),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            password = passwordController.text;
                            _signin(email, password);
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
                                "Sign In",
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
                        buildRowDivider(size: size),
                        SizedBox(
                          height: 10,
                        ),
                        GoogleSignIn(buttonText: "Sign in with Google"),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text("Don't have an account?"),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      Constants.signUpNavigate,
                                      (route) => false);
                                },
                                child: Container(
                                  child: Text("Register now",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.cyan.shade500,
                                      )),
                                ),
                              )
                            ]),
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
              "or",
              style: TextStyle(color: Colors.grey),
            )),
        Expanded(child: Divider(color: Colors.grey)),
      ]),
    );
  }

  _signin(String _email, String _password) async {
    try {
      //Create Get Firebase Auth User
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('password', password);
        await auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((_) {
          user = auth.currentUser!;
              if (user.emailVerified) {
                if (prefs.getString('login_as') == "doctor") {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(
                          builder: (context) => DoctorDashBoard()));
                } else if (prefs.getString('login_as') == "patient") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              }
              else {
                Fluttertoast.showToast(msg: "Please verify your email before signing-in", gravity: ToastGravity.TOP);
              }
        });
    } on FirebaseAuthException catch (error) {
      error_message = error.message.toString();
      setState(() {
        if (error_message == "The password is invalid or the user does not have a password.") {
          error_message = "Invalid Password";
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
