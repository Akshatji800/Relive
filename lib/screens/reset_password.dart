import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mental_health/screens/sign_in_page.dart';


class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late String _email;
  final auth = FirebaseAuth.instance;
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SignInPage()));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
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
                // boxShadow: [BoxShadow(
                //     color: Colors.black12,
                //     blurRadius: 25,
                //     offset: Offset(0, 2)
                // )]
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(1),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          hintText: "Enter your email",
                          hintStyle: TextStyle(
                              color: Colors.black45),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  _email = emailController.text;
                  auth.sendPasswordResetEmail(email: _email);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignInPage()));
                  Fluttertoast.showToast(msg: "A reset password email has been sent to ${_email}", gravity: ToastGravity.TOP);
                },
                child: Container(
                  height: 50,
                  width: 150,
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
                      "Send Request",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),

        ],),
    );
  }
}