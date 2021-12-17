import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/Settings_Pages/new_password.dart';
import 'package:mental_health/screens/patient_dashboard/ui_view/wave_view.dart';
import 'package:hexcolor/hexcolor.dart';
import '../fitness_app_theme.dart';
import 'my_diary_screen.dart';

late User user;
double waterconsumed=1;
double watertarget=2000;
String lastSeen="";
String lastDate="";
class WaterView extends StatefulWidget {
  const WaterView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _WaterViewState createState() => _WaterViewState();
}

class _WaterViewState extends State<WaterView> with TickerProviderStateMixin {
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = auth.currentUser!;

    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('userdata')
                    .doc(user.uid)
                    .collection('water_track')
                    .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    waterconsumed=0;
                    watertarget=2000;
                    lastSeen="";
                    lastDate="";
                    var sn =snapshot.data!;
                    for (var element in sn.docs) {
                      if(element.id == formattedDate){
                        waterconsumed=element.get("consumed(ml)").toDouble();
                        watertarget=element.get("target(ml)").toDouble();
                        lastDate=element.get("last seen");
                        lastSeen=element.get("time");
}
                    }
                  }
                  return Container(
                    decoration: BoxDecoration(
                      color: FitnessAppTheme.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(68.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: FitnessAppTheme.grey.withOpacity(0.2),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 3),
                                          child: Text(
                                            waterconsumed.toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 32,
                                              color: FitnessAppTheme.nearlyDarkBlue,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8, bottom: 8),
                                          child: Text(
                                            'ml',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              letterSpacing: -0.2,
                                              color: FitnessAppTheme.nearlyDarkBlue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, top: 2, bottom: 5),
                                      child: Text(
                                        'of daily goal '+(watertarget*1/1000).toString()+'L',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          color: FitnessAppTheme.darkText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 4, top: 8, bottom: 16),
                                  child: Container(
                                    height: 2,
                                    decoration: const BoxDecoration(
                                      color: FitnessAppTheme.background,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4),
                                            child: Icon(
                                              Icons.access_time,
                                              color: FitnessAppTheme.grey
                                                  .withOpacity(0.5),
                                              size: 16,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 4.0),
                                            child: Text(
                                              (formattedDate != formatter.format(now))? 'Last drink ' + lastDate  :
                                              'Last drink '+lastSeen,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                letterSpacing: 0.0,
                                                color: FitnessAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: Image.asset(
                                                  'assets/fitness_app/bell.png'),
                                            ),
                                            Flexible(
                                              child: Text(
                                                waterconsumed==0?
                                                'Your bottle is empty, refill it!.':
                                                ((waterconsumed.toDouble()/watertarget.toDouble())*100)>=100?'Keep it up': 'Keep going',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  letterSpacing: 0.0,
                                                  color: HexColor('#F65283'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8, right: 8, top: 16),
                            child: Container(
                              width: 60,
                              height: 160,
                              decoration: BoxDecoration(
                                color: HexColor('#E8EDFE'),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(80.0),
                                    bottomLeft: Radius.circular(80.0),
                                    bottomRight: Radius.circular(80.0),
                                    topRight: Radius.circular(80.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: FitnessAppTheme.grey.withOpacity(0.4),
                                      offset: const Offset(2, 2),
                                      blurRadius: 4),
                                ],
                              ),
                              child: WaveView(
                                percentageValue: (waterconsumed.toDouble()/watertarget.toDouble())*100,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        );
      },
    );
  }
}
