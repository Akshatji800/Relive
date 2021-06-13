import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/screens/home_page.dart';
import 'package:mental_health/services/firebase_Service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late String email;
  late String password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    OutlineInputBorder border = OutlineInputBorder(
        borderSide: BorderSide(color: Constants.kBlackColor, width: 1.0));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.cyan[200],
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("assets/images/sign-in.png", width: 300, height: 200),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: Constants.textSignInTitle,
                    style: TextStyle(
                      color: Constants.kBlackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    )),
              ])),
          SizedBox(height: size.height * 0.01),
          Text(
            Constants.textSmallSignIn,
            style: TextStyle(color: Constants.kBlackColor),
          ),
          Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
          SizedBox(
            width: size.width * 0.8,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  hintText: "Enter your mail ID",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  enabledBorder: border,
                  focusedBorder: border),
              onChanged: (value) {
                setState(() {
                  email = value.trim();
                });
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          SizedBox(
            width: size.width * 0.8,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "Enter your password",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                enabledBorder: border,
                focusedBorder: border,
                suffixIcon: Padding(
                  child: FaIcon(
                    FontAwesomeIcons.eye,
                    size: 15,
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.only(top: 15, left: 15),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  password = value.trim();
                });
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
          SizedBox(
            width: size.width * 0.8,
            child: OutlinedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('email', email);
                prefs.setString('password', password);
                auth
                    .signInWithEmailAndPassword(
                        email: email, password: password)
                    .then((_) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Constants.homeNavigate, (route) => false);
                });
              },
              child: Text(Constants.textSignIn),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Constants.kPrimaryColor),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.kBlackColor),
                  side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
            ),
          ),
          buildRowDivider(size: size),
          Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
          GoogleSignIn(),
          Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Don't have an account?"),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, Constants.signUpNavigate, (route) => false);
              },
              child: Container(
                child: Text("Register now",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.deepPurpleAccent)),
              ),
            )
          ]),
        ])));
  }

  Widget buildRowDivider({required Size size}) {
    return SizedBox(
      width: size.width * 0.8,
      child: Row(children: <Widget>[
        Expanded(child: Divider(color: Constants.kDarkGreyColor)),
        Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              "Or",
              style: TextStyle(color: Constants.kDarkGreyColor),
            )),
        Expanded(child: Divider(color: Constants.kDarkGreyColor)),
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
            child: OutlinedButton.icon(
              icon: FaIcon(FontAwesomeIcons.google),
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
                Constants.textSignInGoogle,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.kBlackColor),
                  side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
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
