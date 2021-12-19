import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/Settings_Pages/new_password.dart';
import 'package:mental_health/screens/patient_dashboard/Food_Tracking/dinner.dart';
import 'package:mental_health/screens/patient_dashboard/models/meals_list_data.dart';
import 'package:hexcolor/hexcolor.dart';
import '../fitness_app_theme.dart';
import 'my_diary_screen.dart';

double calorie1= 0;
double calorie2= 0;
double calorie3= 0;
double calorie4= 0;
double targetbreakfast = 0;
double targetlunch = 0;
double targetsnack = 0;
double targetdinner = 0;
double rCalorie = 2500;
double rCarbs = 300;
double rProtein = 56;
double rCholesterol = 0.3;
double rSugars = 38;
double rFat = 70;
late User user2;
class MealsListView extends StatefulWidget {
  const MealsListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user2 = auth.currentUser!;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('userdata').doc(user2.uid).collection(
          'food_track').doc(formattedDate).collection('Total').snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      try{
        calorie1 = double.parse(snapshot.data!.docs[0]["Total Calories"]);
      }
      catch(e) {
        calorie1 = 0;
      }
      try{
        calorie2 = double.parse(snapshot.data!.docs[1]["Total Calories"]);
      }
      catch(e) {
        calorie2 = 0;
      }
      try{
        calorie3 = double.parse(snapshot.data!.docs[2]["Total Calories"]);
      }
      catch(e) {
        calorie3 = 0;
      }
      try{
        calorie4 = double.parse(snapshot.data!.docs[3]["Total Calories"]);
      }
      catch(e) {
        calorie4 = 0;
      }

    }
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('userdata')
              .doc(user2.uid)
              .collection('food_track')
              .doc(formattedDate)
              .collection('Target').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      try{
        targetbreakfast = double.parse(snapshot.data!.docs[0]["Target Calories"]);
      }
      catch(e){
        targetbreakfast = 0;
      }
      try{
        targetlunch = double.parse(snapshot.data!.docs[1]["Target Calories"]);
      }
      catch(e){
        targetlunch = 0;
      }
      try{
        targetsnack = double.parse(snapshot.data!.docs[2]["Target Calories"]);
      }
      catch(e){
        targetsnack = 0;
      }
      try{
        targetdinner = double.parse(snapshot.data!.docs[3]["Target Calories"]);
      }
      catch(e){
        targetdinner = 0;
      }
    }
    List<MealsListData> mealsListData = [
      MealsListData(
        imagePath: 'assets/fitness_app/breakfast.png',
        titleTxt: 'Breakfast',
        kacl: int.parse(calorie1.toStringAsFixed(0)),
        meals: <String>['Target:', targetbreakfast.toStringAsFixed(0) + ' kacl'],
        startColor: '#FA7D82',
        endColor: '#FFB295',
        index: 0,
      ),
      MealsListData(
        imagePath: 'assets/fitness_app/lunch.png',
        titleTxt: 'Lunch',
        kacl: int.parse(calorie2.toStringAsFixed(0)),
        meals: <String>['Target:', targetlunch.toStringAsFixed(0) + ' kacl'],
        startColor: '#48D1CC',
        endColor: '#20B2AA',
        index: 1,
      ),
      MealsListData(
        imagePath: 'assets/fitness_app/snack.png',
        titleTxt: 'Snack',
        kacl: int.parse(calorie3.toStringAsFixed(0)),
        meals: <String>['Target:', targetsnack.toStringAsFixed(0) + ' kacl'],
        startColor: '#FE95B6',
        endColor: '#FF5287',
        index: 2,
      ),
      MealsListData(
        imagePath: 'assets/fitness_app/dinner.png',
        titleTxt: 'Dinner',
        kacl: int.parse(calorie4.toStringAsFixed(0)),
        meals: <String>['Target:', targetdinner.toStringAsFixed(0) + ' kacl'],
        startColor: '#6F72CA',
        endColor: '#1E1466',
        index: 3,
      ),
    ];
            return AnimatedBuilder(
              animation: widget.mainScreenAnimationController!,
              builder: (BuildContext context, Widget? child) {
                return FadeTransition(
                  opacity: widget.mainScreenAnimation!,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                    child: SizedBox(
                      height: 216,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                            top: 0, bottom: 0, right: 16, left: 16),
                        itemCount: mealsListData.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final int count =
                          mealsListData.length > 10 ? 10 : mealsListData.length;
                          final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                          animationController?.forward();

                          return MealsView(
                            mealsListData: mealsListData[index],
                            animation: animation,
                            animationController: animationController!,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        );
      }
    );
  }
}

class MealsView extends StatelessWidget {
  const MealsView(
      {Key? key, this.mealsListData, this.animationController, this.animation})
      : super(key: key);

  final MealsListData? mealsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: SizedBox(
              width: 130,
              child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  switch (mealsListData!.index) {
                    case 0:
                      getTargetData('breakfast');
                      return Dinner(
                        callingText: "breakfast",
                      );
                    case 1:
                      getTargetData('lunch');
                      return Dinner(
                        callingText: "lunch",
                      );
                    case 2:
                      getTargetData('snack');
                      return Dinner(
                        callingText: "snack",
                      );
                    case 3:
                      getTargetData('dinner');
                      return Dinner(
                        callingText: "dinner",
                      );
                    default:
                      return Dinner(
                        callingText: "dinner",
                      );
                  }
                }));
              },
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, left: 8, right: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor(mealsListData!.endColor)
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            HexColor(mealsListData!.startColor),
                            HexColor(mealsListData!.endColor),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(54.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 54, left: 16, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              mealsListData!.titleTxt,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.2,
                                color: FitnessAppTheme.white,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      mealsListData!.meals!.join('\n'),
                                      style: const TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.5,
                                        color: FitnessAppTheme.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            mealsListData?.kacl != 0
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  mealsListData!.kacl.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    letterSpacing: 0.2,
                                    color: FitnessAppTheme.white,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 4, bottom: 3),
                                  child: Text(
                                    'kcal',
                                    style: TextStyle(
                                      fontFamily:
                                      FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      letterSpacing: 0.2,
                                      color: FitnessAppTheme.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Container(
                              decoration: BoxDecoration(
                                color: FitnessAppTheme.nearlyWhite,
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: FitnessAppTheme.nearlyBlack
                                          .withOpacity(0.4),
                                      offset: const Offset(8.0, 8.0),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.add,
                                  color: HexColor(mealsListData!.endColor),
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 8,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(mealsListData!.imagePath),
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
  getTargetData(String mealType) {
    user2 = auth.currentUser!;
    FirebaseFirestore.instance
        .collection('userdata')
        .doc(user2.uid)
        .collection('food_track')
        .doc(formattedDate)
        .collection('Target')
        .doc(mealType)
        .get()
        .then((value) {
      rCalorie = double.parse(value.data()!["Target Calories"]);
      rCarbs = double.parse(value.data()!["Target Carbohydrate"]);
      rProtein = double.parse(value.data()!["Target Protein"]);
      rFat = double.parse(value.data()!["Target Fat"]);
      rSugars = double.parse(value.data()!["Target Sugars"]);
      rCholesterol = double.parse(value.data()!["Target Cholesterol"]);
    });
  }
}
