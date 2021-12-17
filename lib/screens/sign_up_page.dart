import 'package:flutter/material.dart';
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
String waterFeatureUsedDate = "";
String waterFeatureUsedTime = "";

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String email, password, username, fullname;
  String errorMessage = "";
  bool _validatePass = false;
  bool _validateEmail = false;
  bool _validateUsername = false;
  bool _validateFullname = false;
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
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
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
            const SizedBox(height: 13),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
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
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
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
                                      padding: const EdgeInsets.all(0),
                                      child: TextFormField(
                                        controller: fullnameController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
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
                              !_validateFullname
                                  ? Container()
                                  : const Text(
                                      "Field cannot be Empty",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
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
                                    TextFormField(
                                      controller: usernameController,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          hintText: "Enter your username",
                                          hintStyle: TextStyle(
                                              color: Colors.black45),
                                          border: InputBorder.none),
                                    ),
                                  ],
                                ),
                              ),
                              !_validateUsername
                                  ? Container()
                                  : const Text(
                                      "Field cannot be Empty",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
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
                                      padding: const EdgeInsets.all(0),
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
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
                              !_validateEmail
                                  ? Container()
                                  : Text(
                                      errorMessage,
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
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
                                      padding: const EdgeInsets.all(0),
                                      child: TextFormField(
                                        controller: passwordController,
                                        keyboardType: TextInputType.text,
                                        obscureText: !_passwordVisible,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.lock),
                                          hintText: 'Enter your password',
                                          hintStyle: const TextStyle(
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
                              !_validatePass
                                  ? Container()
                                  : Text(
                                      errorMessage,
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            password = passwordController.text;
                            username = usernameController.text;
                            fullname = fullnameController.text;
                            setState(() {
                              if (username.isNotEmpty) {
                                _validateUsername = false;
                                if (fullname.isNotEmpty) {
                                  _validateFullname = false;
                                  _signup(email, password);
                                }
                              } else {
                                if (username.isEmpty) {
                                  _validateUsername = true;
                                }
                                if (fullname.isEmpty) {
                                  _validateFullname = true;
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 75),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.cyan.shade500,
                                border: Border.all(color: Colors.black12),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 1,
                                      blurRadius: 4)
                                ]),
                            child: const Center(
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SignInPage()));
                                },
                                child: Text("Sign in",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.cyan.shade500,
                                    )),
                              )
                            ]),
                        const SizedBox(
                          height: 10,
                        ),
                        buildRowDivider(size: size),
                        const SizedBox(
                          height: 10,
                        ),
                        GoogleSignIn(buttonText: "Sign up with Google"),
                        const SizedBox(
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
      child: Row(children: const <Widget>[
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
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Select Role As:'),
                  content: SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            await DatabaseService(uid: user.uid).updateUserData(fullname, username, email,"patient");
                            Navigator.pop(context);
                            password = passwordController.text;
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('login_as', "patient");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const VerifyScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Center(
                                  child: Text('Patient'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await DatabaseService(uid: user.uid).updateUserData(fullname, username, email, "doctor");
                            Navigator.pop(context);
                            password = passwordController.text;
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('login_as', "doctor");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const VerifyScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Center(
                                  child: Text('Doctor'),
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
      errorMessage = error.message.toString();
      setState(() {
        if (errorMessage == "Password should be at least 6 characters") {
          _validatePass = true;
          _validateEmail = false;
        } else {
          if (errorMessage == "The email address is badly formatted.") {
            errorMessage = "Invalid email";
            _validateEmail = true;
            _validatePass = false;
          } else {
            Fluttertoast.showToast(msg: errorMessage, gravity: ToastGravity.TOP);
            _validateEmail = false;
            _validatePass = false;
          }
        }
      });
    }
  }
}
