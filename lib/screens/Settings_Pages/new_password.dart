import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/screens/sign_in_page.dart';
import 'package:mental_health/services/firebase_service.dart';

final auth = FirebaseAuth.instance;
User user = auth.currentUser!;
bool reauthChecker = false;

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<ChangePassPage> {
  final oldpassController = TextEditingController();
  final newpassController = TextEditingController();
  final confirmpassController = TextEditingController();
  bool newpasswordVisible = false;
  bool confirmpasswordVisible = false;
  bool oldpasswordVisible = false;

  @override
  // ignore: must_call_super
  void initState() {
    newpasswordVisible = false;
    confirmpasswordVisible = false;
    oldpasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
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
                      // boxShadow: [BoxShadow(
                      //     color: Colors.black12,
                      //     blurRadius: 25,
                      //     offset: Offset(0, 2)
                      // )]
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(0),
                          child: TextFormField(
                            controller: oldpassController,
                            keyboardType: TextInputType.text,
                            obscureText: !oldpasswordVisible,
                            //This will obscure text dynamically
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Enter your old password',
                              hintStyle: const TextStyle(color: Colors.black45),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  oldpasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black45,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    oldpasswordVisible = !oldpasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                          padding: const EdgeInsets.all(0),
                          child: TextFormField(
                            controller: newpassController,
                            keyboardType: TextInputType.text,
                            obscureText: !newpasswordVisible,
                            //This will obscure text dynamically
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Enter your new password',
                              hintStyle: const TextStyle(color: Colors.black45),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  newpasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black45,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    newpasswordVisible = !newpasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                          padding: const EdgeInsets.all(0),
                          child: TextFormField(
                            controller: confirmpassController,
                            keyboardType: TextInputType.text,
                            obscureText: !confirmpasswordVisible,
                            //This will obscure text dynamically
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Confirm the new password',
                              hintStyle: const TextStyle(color: Colors.black45),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  confirmpasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black45,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    confirmpasswordVisible =
                                        !confirmpasswordVisible;
                                  });
                                },
                              ),
                            ),
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
                  if (newpassController.text == confirmpassController.text) {
                    AuthCredential credential = EmailAuthProvider.credential(
                        email: user.email.toString(),
                        password: oldpassController.text);
                    try {
                      await user.reauthenticateWithCredential(credential);
                      reauthChecker = true;
                    } catch (e) {
                      reauthChecker = false;
                    }
                    if (reauthChecker == true) {
                      updatePassword(newpassController.text);
                      Fluttertoast.showToast(
                          msg: "Password has been reset",
                          gravity: ToastGravity.TOP);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Invalid old password",
                          gravity: ToastGravity.TOP);
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg:
                            "The new password and confirm password does not match",
                        gravity: ToastGravity.TOP);
                  }
                  if (reauthChecker == true) {
                    FirebaseService service = FirebaseService();
                    await service.signOutFromGoogle();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const SignInPage()),
                      ModalRoute.withName(''),
                    );
                    Fluttertoast.showToast(
                        msg: "Please login again with new password",
                        gravity: ToastGravity.TOP);
                  }
                },
                child: Container(
                  height: 50,
                  width: 150,
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
                      "Send Request",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> updatePassword(String password) async {
    user.updatePassword(password);
  }
}
