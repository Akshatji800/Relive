import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/BodyMesurment/input.dart';
import 'package:mental_health/screens/patient_dashboard/Meals/mealsToday.dart';
import 'package:mental_health/screens/patient_dashboard/MediterranDiet/diet.dart';
import 'package:mental_health/screens/patient_dashboard/water/waterTaken.dart';
import '../fitness_app_theme.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final int index;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const TitleView(
      {Key? key,
        this.titleTxt: "",
        this.subTxt: "",
        this.index=0,
        this.animationController,
        this.animation,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          color: FitnessAppTheme.lightText,
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              switch(index){
                                case 0:
                                  return Diet();
                                case 1:
                                  return meals();
                                case 2:
                                  return InputPage();
                                default:
                                  return watertaken();
                              }
                            }
                        )
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              subTxt,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                letterSpacing: 0.5,
                                color: FitnessAppTheme.nearlyDarkBlue,
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 26,
                              child: Icon(
                                Icons.arrow_forward,
                                color: FitnessAppTheme.darkText,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
