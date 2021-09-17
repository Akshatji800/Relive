import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/Settings_Pages/NewPassword.dart';
import 'package:mental_health/screens/patient_dashboard/BodyMesurment/input.dart';
import 'package:mental_health/screens/patient_dashboard/BodyMesurment/models.dart';
import 'package:mental_health/screens/patient_dashboard/fitness_app_home_screen.dart';
import 'package:mental_health/screens/patient_dashboard/BodyMesurment/BodyM_shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:mental_health/services/database.dart';

late User user;
class Result extends StatefulWidget {
  final String status, msg;
  final String statusNumber,currentCalorie,goalCalorie,bmr,heightCm,weight,age,gender;
  Result({required this.status,required this.msg,required this.statusNumber,required this.currentCalorie,required this.goalCalorie,required this.bmr,required this.heightCm,required this.weight,required this.age, required this.gender});

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final _preferencesService = PreferencesService();
  var _BMW = "";
  var _status = '';
  var _BMR = "";
  var _height = "";
  var _weight = "";
  var _Date = "";
  var _age,_gender = "";
  @override
  Widget build(BuildContext context) {
    setState(() {
      _BMW = widget.statusNumber;
      _status = widget.status;
      _BMR = widget.bmr;
      _height = widget.heightCm;
      _weight = widget.weight;
      _Date = formattedDate;
      _age = widget.age;
      _gender = widget.gender;
    });
    user = auth.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        // centerTitle: true,
        backgroundColor:  Colors.cyan,
      ),
      backgroundColor: Color(0xFFF2F3F8),
      body: ListView(
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  height: 170,
                  width: 150,
                  decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black45
                              .withOpacity(0.2),
                          offset: const Offset(1.1, 4.0),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Body Mass Weight",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan,
                        ),
                      ),
                      Divider(height: 2,thickness: 1,color: Colors.grey,indent: 25,endIndent: 25,),
                      Container(
                        // margin: EdgeInsets.only(left: 60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Your Status: ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      // fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    _status,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "BMW Value: ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey[600],
                                      // fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    _BMW.toString(),
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.msg,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  height: 260,
                  width: 150,
                  decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black45
                              .withOpacity(0.2),
                          offset: const Offset(1.1, 4.0),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Basal Metabolic Rate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan,
                        ),
                      ),
                      Divider(height: 2,thickness: 1,color: Colors.grey,indent: 25,endIndent: 25,),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "BMR Value: ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey[600],
                                      // fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    _BMR.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 27,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      Text(
                        "Current Calories",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.cyan,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Divider(height: 2,thickness: 1,color: Colors.grey,indent: 25,endIndent: 25,),
                      Text(
                        widget.currentCalorie,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "(As per Activity)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Daily Calories Required",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.cyan,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Divider(height: 2,thickness: 1,color: Colors.grey,indent: 25,endIndent: 25,),
                      Text(
                        widget.goalCalorie,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "(As per Activity)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),

          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>InputPage()), (Route<dynamic> route) => false,);
            },
            child: Container(
              height: 50,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              constraints: BoxConstraints(minWidth: 50,maxWidth: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.cyan,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black45
                          .withOpacity(0.2),
                      offset: const Offset(1.1, 4.0),
                      blurRadius: 8.0),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'Recalculate',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _saveDetails();
              DatabaseService(uid: user.uid).updateBodyMesurmentData(int.parse(_height),int.parse(_weight),double.parse(_BMR),double.parse(_BMW),_status,_Date,_age,_gender);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>FitnessAppHomeScreen()), (Route<dynamic> route) => false,);
            },
            child: Container(
              height: 50,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              constraints: BoxConstraints(minWidth: 50,maxWidth: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.red,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black45
                          .withOpacity(0.2),
                      offset: const Offset(1.1, 4.0),
                      blurRadius: 8.0),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  void _saveDetails(){
    final newDetails = BodyM(
        height: _height.toString(),
        weight: _weight.toString(),
        BMW: _BMW.toString(),
        BMR: _BMR.toString(),
        Status: _status,
        Time: _Date
    );
    print(newDetails);
    _preferencesService.saveFinalDetails(newDetails);
  }
}
