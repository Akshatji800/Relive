import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:mental_health/screens/Settings_Pages/NewPassword.dart';
import 'package:mental_health/screens/patient_dashboard/models/waterData.dart';
import 'package:mental_health/screens/patient_dashboard/water/waterTaken_shared_preferences.dart';
import 'package:mental_health/services/database.dart';
import '../../sign_up_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

late User user;
class watertaken extends StatefulWidget {
  const watertaken({Key? key}) : super(key: key);

  @override
  _watertakenState createState() => _watertakenState();
}

class _watertakenState extends State<watertaken> {

  int _coffee = 180;
  int _waterGlass = 250;
  int _waterBottle = 500;
  int _jug = 750;
  int updateTar=0;

  TextEditingController _textFieldController = TextEditingController();
  final _preferencesService = WaterPreferencesServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _waterDetails();
  }

  @override
  Widget build(BuildContext context) {

    double stat = (consumed.toDouble()/target.toDouble())*100;
    String presentDate = CurrentDay();
    user = auth.currentUser!;

    FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('water_track').doc(formattedDate).get().then((value){
      consumed = value.data()!["consumed(ml)"];
      target = value.data()!["target(ml)"];
      WaterFeatureUsedDate = value.data()!["last seen"];
      WaterFeatureUsedTime = value.data()!["time"];
      _saveWaterData();
    });

    if(presentDate != WaterFeatureUsedDate){
      consumed = 0;
      target=2000;
      stat = 0;
      WaterFeatureUsedDate = presentDate;
    }

    DatabaseService(uid: user.uid).updateWaterData(consumed,target,WaterFeatureUsedDate,WaterFeatureUsedTime);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Current Hydration",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
              onPressed: (){
                _showPopupMenu();
              },
            icon: Icon(Platform.isAndroid ? Icons.more_vert : Icons.more_horiz,color: Colors.white,),
          ),
        ],
      ),
      backgroundColor: Color(0xFFF2F3F8),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 0, top: 10),
            child: Column(
              children: [
                SizedBox(width: double.infinity),
                SizedBox(height: 10,),
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black45
                              .withOpacity(0.2),
                          offset: const Offset(1.1, 4.0),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: LiquidCircularProgressIndicator(
                      value: consumed/target,
                      valueColor: AlwaysStoppedAnimation(Colors.cyan.shade200,),
                      backgroundColor: Colors.white,
                      borderColor: Colors.cyan.shade100,
                      borderWidth: 4.0,
                      direction: Axis.vertical,
                      center: Padding(
                        padding: EdgeInsets.only(top: 70),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Today",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.cyan.shade800),
                              ),
                              SizedBox(height: 3,),
                              Text(
                                stat.toStringAsFixed(1) + "%",
                                style: TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.cyan.shade900),
                              ),
                              SizedBox(height: 3,),
                              Text(
                                consumed.toString() +" ml",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade800),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                target.toString() +" ml",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade800),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 220,
                  width: 300,
                  decoration: BoxDecoration(
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
                        width: 147,
                        decoration: BoxDecoration(
                        ),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  consumed = consumed+_coffee;
                                  WaterFeatureUsedTime = CurrentTime();
                                });
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.purple.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black45
                                            .withOpacity(0.1),
                                        offset: const Offset(1.1, 4.0),
                                        blurRadius: 8.0),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.coffee,
                                            color: Colors.black,
                                            size: 24.0,
                                          ),
                                          SizedBox(width: 2,),
                                          Text(_coffee.toString()+" ml",style: TextStyle(fontWeight: FontWeight.bold),),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  consumed = consumed+_waterBottle;
                                  WaterFeatureUsedTime = CurrentTime();
                                });
                              },
                              child:Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black45
                                            .withOpacity(0.1),
                                        offset: const Offset(1.1, 4.0),
                                        blurRadius: 8.0),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.wineBottle,
                                            color: Colors.black,
                                            size: 24.0,
                                          ),
                                          SizedBox(width: 2,),
                                          Text(_waterBottle.toString()+" ml",style: TextStyle(fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(width: 6,),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
                        width: 147,
                        decoration: BoxDecoration(
                        ),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    consumed = consumed+_waterGlass;
                                    WaterFeatureUsedTime = CurrentTime();
                                  });
                                },
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.black45
                                              .withOpacity(0.1),
                                          offset: const Offset(1.1, 4.0),
                                          blurRadius: 8.0),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.wineGlass,
                                              color: Colors.black,
                                              size: 24.0,
                                            ),
                                            SizedBox(width: 2,),
                                            Text(_waterGlass.toString()+" ml",style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            SizedBox(height: 20,),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    consumed = consumed+_jug;
                                    WaterFeatureUsedTime = CurrentTime();
                                  });
                                },
                                child:Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.cyan.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.black45
                                              .withOpacity(0.1),
                                          offset: const Offset(1.1, 4.0),
                                          blurRadius: 8.0),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.glassWhiskey,
                                              color: Colors.black,
                                              size: 24.0,
                                            ),
                                            SizedBox(width: 2,),
                                            Text(_jug.toString()+" ml",style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    _saveWaterData();
                    Fluttertoast.showToast(
                        msg: "Saved",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.teal.shade200,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black45
                                .withOpacity(0.1),
                            offset: const Offset(1.1, 4.0),
                            blurRadius: 8.0),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Save",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Daily consumption',style: TextStyle(fontSize: 16),),
            content: Container(
              height: 174,
              child: Column(
                children: <Widget>[
                  Text("Change your daily water consumption goal, in milliliters"),
                  SizedBox(height: 5,),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        updateTar = int.parse(value);
                      });
                    },
                    controller: _textFieldController,
                    decoration: InputDecoration(hintText: "2500"),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                            height: 35,
                            width: 80,

                            decoration: BoxDecoration(
                                color: Colors.red,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("CANCEL",style: TextStyle(color: Colors.white),),
                              ],
                            )
                          ),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              target = updateTar;
                              WaterFeatureUsedTime = CurrentTime();
                              Navigator.pop(context);
                            });
                            Fluttertoast.showToast(
                              msg: "Target Updated",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                            );
                          },
                          child: Container(
                              height: 35,
                              width: 80,

                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("OK",style: TextStyle(color: Colors.white),),
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
  Future<void> _resetData(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reset',style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
            content: Container(
              height: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("You will loose your data",style: TextStyle(color: Colors.red.shade500,)),
                  Text("Do you really want to reset the data.",),
                  Text("Please confirm",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                              height: 35,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("CANCEL",style: TextStyle(color: Colors.white),),
                                ],
                              )
                          ),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              target = updateTar;
                              consumed =0;
                              target = 2000;
                              _saveWaterData();
                              WaterFeatureUsedTime = CurrentTime();
                              Navigator.pop(context);
                            });
                            Fluttertoast.showToast(
                              msg: "Successfully Reset Completed",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                          },
                          child: Container(
                              height: 35,
                              width: 80,

                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("OK",style: TextStyle(color: Colors.white),),
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _showPopupMenu(){
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0),      //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(
            child: const Text('Update Target'), value: '1'),
        PopupMenuDivider(
          height: 1,
        ),
        PopupMenuItem<String>(
            child: const Text('Reset Data',style: TextStyle(color: Colors.red),), value: '2'),
      ],
      elevation: 8.0,
    ).then<void>((itemSelected) async {
      if (itemSelected == null) {
        return;
      }
      if(itemSelected == "1"){
        _displayTextInputDialog(context);
      }else if(itemSelected == "2"){
        _resetData(context);
      }
    });
  }

  String CurrentTime(){
    var now = new DateTime.now();
    var formatter1 = new DateFormat('HH:mm:ss');
    String presentTime = formatter1.format(now);
    return presentTime;
  }
  String CurrentDay(){
    var now = new DateTime.now();
    var formatter1 = new DateFormat('yyyy-MM-dd');
    String presentday= formatter1.format(now);
    return presentday;
  }

  void _saveWaterData(){
    final newData =  WaterData(
      consumed: consumed.toString(),
      target: target.toString(),
      last_seen: WaterFeatureUsedDate,
      time: WaterFeatureUsedTime,
    );
    _preferencesService.saveWaterDetails(newData);
  }

  void _waterDetails() async{
    final details = await _preferencesService.getFinalDetails();
    setState(() {
      consumed = int.parse(details.consumed);
      target = int.parse(details.target);
      WaterFeatureUsedDate = details.last_seen;
      WaterFeatureUsedTime = details.time;
    });
  }
}