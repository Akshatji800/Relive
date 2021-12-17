import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:mental_health/screens/Settings_Pages/new_password.dart';
import 'package:mental_health/screens/patient_dashboard/my_diary/water_view.dart';
import 'package:mental_health/services/database.dart';
import '../../sign_up_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

late User user;
class WaterTaken extends StatefulWidget {
  const WaterTaken({Key? key}) : super(key: key);

  @override
  _WaterTakenState createState() => _WaterTakenState();
}

class _WaterTakenState extends State<WaterTaken> {

  final int _coffee = 180;
  final int _waterGlass = 250;
  final int _waterBottle = 500;
  final int _jug = 750;
  int updateTar=0;

  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    user = auth.currentUser!;

        double stat = (waterconsumed.toDouble()/watertarget.toDouble())*100;
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            title: const Text("Current Hydration",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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
          backgroundColor: const Color(0xFFF2F3F8),
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 0, top: 10),
                child: Column(
                  children: [
                    const SizedBox(width: double.infinity),
                    const SizedBox(height: 10,),
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
                          value: waterconsumed/watertarget,
                          valueColor: AlwaysStoppedAnimation(Colors.cyan.shade200,),
                          backgroundColor: Colors.white,
                          borderColor: Colors.cyan.shade100,
                          borderWidth: 4.0,
                          direction: Axis.vertical,
                          center: Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Today",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.cyan.shade800),
                                ),
                                const SizedBox(height: 3,),
                                Text(
                                  stat.toStringAsFixed(1) + "%",
                                  style: TextStyle(
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.cyan.shade900),
                                ),
                                const SizedBox(height: 3,),
                                Text(
                                  waterconsumed.toString() +" ml",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800),
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  watertarget.toString() +" ml",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 220,
                      width: 300,
                      decoration: const BoxDecoration(
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
                            width: 147,
                            decoration: const BoxDecoration(
                            ),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      waterconsumed = waterconsumed+_coffee;
                                      lastSeen = currentTime();
                                      lastDate = currentDay();
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            const Icon(
                                              Icons.coffee,
                                              color: Colors.black,
                                              size: 24.0,
                                            ),
                                            const SizedBox(width: 2,),
                                            Text(_coffee.toString()+" ml",style: const TextStyle(fontWeight: FontWeight.bold),),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20,),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      waterconsumed = waterconsumed+_waterBottle;
                                      lastSeen = currentTime();
                                      lastDate = currentDay();
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            const Icon(
                                              FontAwesomeIcons.wineBottle,
                                              color: Colors.black,
                                              size: 24.0,
                                            ),
                                            const SizedBox(width: 2,),
                                            Text(_waterBottle.toString()+" ml",style: const TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(width: 6,),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
                            width: 147,
                            decoration: const BoxDecoration(
                            ),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        waterconsumed = waterconsumed+_waterGlass;
                                        lastSeen = currentTime();
                                        lastDate = currentDay();
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Icon(
                                                FontAwesomeIcons.wineGlass,
                                                color: Colors.black,
                                                size: 24.0,
                                              ),
                                              const SizedBox(width: 2,),
                                              Text(_waterGlass.toString()+" ml",style: const TextStyle(fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                                const SizedBox(height: 20,),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        waterconsumed +=_jug;
                                        lastSeen = currentTime();
                                        lastDate = currentDay();
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Icon(
                                                FontAwesomeIcons.glassWhiskey,
                                                color: Colors.black,
                                                size: 24.0,
                                              ),
                                              const SizedBox(width: 2,),
                                              Text(_jug.toString()+" ml",style: const TextStyle(fontWeight: FontWeight.bold),)
                                            ],
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
                    const SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        DatabaseService(uid: user.uid).updateWaterData(waterconsumed,watertarget,lastDate,lastSeen);
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
                          children: const <Widget>[
                            Text("Save",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
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
            title: const Text('Daily consumption',style: TextStyle(fontSize: 16),),
            content: SizedBox(
              height: 174,
              child: Column(
                children: <Widget>[
                  const Text("Change your daily water consumption goal, in milliliters"),
                  const SizedBox(height: 5,),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        updateTar = int.parse(value);
                      });
                    },
                    controller: _textFieldController,
                    decoration: const InputDecoration(hintText: "2500"),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16,),
                  Row(
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
                            children: const <Widget>[
                              Text("CANCEL",style: TextStyle(color: Colors.white),),
                            ],
                          )
                        ),
                      ),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            watertarget = updateTar.toDouble();
                            lastSeen = currentTime();
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
                              children: const <Widget>[
                                Text("OK",style: TextStyle(color: Colors.white),),
                              ],
                            )
                        ),
                      ),
                    ],
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
            title: const Text('Reset',style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),
            content: SizedBox(
              height: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("You will loose your data",style: TextStyle(color: Colors.red.shade500,)),
                  const Text("Do you really want to reset the data.",),
                  const Text("Please confirm",style: TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 16,),
                  Row(
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
                              children: const <Widget>[
                                Text("CANCEL",style: TextStyle(color: Colors.white),),
                              ],
                            )
                        ),
                      ),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            target = updateTar.toDouble();
                            consumed =0;
                            target = 2000;
                            waterFeatureUsedTime = currentTime();
                            DatabaseService(uid: user.uid).updateWaterData(consumed,target,lastDate,waterFeatureUsedTime);
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
                              children: const <Widget>[
                                Text("OK",style: TextStyle(color: Colors.white),),
                              ],
                            )
                        ),
                      ),
                    ],
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
      position: const RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0),      //position where you want to show the menu on screen
      items: [
        const PopupMenuItem<String>(
            child: Text('Update Target'), value: '1'),
        const PopupMenuDivider(
          height: 1,
        ),
        const PopupMenuItem<String>(
            child: Text('Reset Data',style: TextStyle(color: Colors.red),), value: '2'),
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

  String currentTime(){
    var now = DateTime.now();
    var formatter1 = DateFormat('HH:mm:ss');
    String presentTime = formatter1.format(now);
    return presentTime;
  }
  String currentDay(){
    var now = DateTime.now();
    var formatter1 = DateFormat('yyyy-MM-dd');
    String presentday= formatter1.format(now);
    return presentday;
  }
}