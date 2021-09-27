import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/Settings_Pages/NewPassword.dart';
import 'package:mental_health/services/database.dart';

late User users;
String foodType="";
var rCalories=2500;
var rCarbohydrate=300;
var rProtein=56;
var rFat=70;
var rSugars=38;
var rCholesterol=0.3;
const Color inactiveCard = Color(0xFFE0F7FA);
const Color activeCard = Colors.white;

class meals extends StatefulWidget {
  const meals({Key? key}) : super(key: key);

  @override
  _mealsState createState() => _mealsState();
}

class _mealsState extends State<meals> {
  Color breakfastCard = activeCard,
      lunchCard = activeCard,
      snackCard = activeCard,
      dinnerCard = activeCard;
  void updateFoodTypeSelected(int x) {
    if (x == 1) {
      foodType="breakfast";
      breakfastCard = inactiveCard;
      lunchCard = activeCard;
      dinnerCard = activeCard;
      snackCard = activeCard;
    } if(x == 2){
      foodType="lunch";
      breakfastCard = activeCard;
      lunchCard = inactiveCard;
      dinnerCard = activeCard;
      snackCard = activeCard;
    }
    if(x == 3) {
      foodType = "snack";
      breakfastCard = activeCard;
      lunchCard = activeCard;
      dinnerCard = activeCard;
      snackCard = inactiveCard;
    }
    if(x == 4) {
      foodType = "dinner";
      breakfastCard = activeCard;
      lunchCard = activeCard;
      dinnerCard = inactiveCard;
      snackCard = activeCard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Goals"),
        // centerTitle: true,
//        backgroundColor: Color(0xFF313131),
        backgroundColor:  Colors.cyan,
      ),
      backgroundColor: Color(0xFFF2F3F8),
      body: ListView(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              // constraints: BoxConstraints(minWidth: 50,maxWidth: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                // color: Colors.grey
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.cyan[200]
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Note: ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                        Text("First select an option to change the nutrient goal of that type",style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                updateFoodTypeSelected(1);
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 130,
                              decoration: BoxDecoration(
                                color: breakfastCard,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black45
                                          .withOpacity(0.2),
                                      offset: const Offset(1.1, 4.0),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/fitness_app/breakfast.png', height: 100, width: 120,),
                                  SizedBox(height: 5,),
                                  Text("BREAKFAST",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),)

                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                updateFoodTypeSelected(2);
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 130,
                              decoration: BoxDecoration(
                                color: lunchCard,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black45
                                          .withOpacity(0.2),
                                      offset: const Offset(1.1, 4.0),
                                      blurRadius: 8.0),
                                ],
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/fitness_app/lunch.png', height: 100, width: 120,),
                                  SizedBox(height: 5,),
                                  Text("LUNCH",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),)

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:20,),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                updateFoodTypeSelected(3);
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 130,
                              decoration: BoxDecoration(
                                color: snackCard,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black45
                                          .withOpacity(0.2),
                                      offset: const Offset(1.1, 4.0),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/fitness_app/snack.png', height: 100, width: 120,),
                                  SizedBox(height: 5,),
                                  Text("SNACK",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),)

                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                updateFoodTypeSelected(4);
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 130,
                              decoration: BoxDecoration(
                                color: dinnerCard,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black45
                                          .withOpacity(0.2),
                                      offset: const Offset(1.1, 4.0),
                                      blurRadius: 8.0),
                                ],
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/fitness_app/dinner.png', height: 100, width: 120,),
                                  SizedBox(height: 5,),
                                  Text("DINNER",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),)

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                          decoration: BoxDecoration(
                            color: activeCard,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black45
                                      .withOpacity(0.2),
                                  offset: const Offset(1.1, 4.0),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 4,),
                              Text(
                                'TOTAL CALORIES',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(height: 1,color: Colors.black,indent: 35,endIndent: 35,),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text(
                                    rCalories.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'kcal',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.cyan
                                    ),
                                  ),

                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                                  activeTrackColor: Colors.cyan,
                                  thumbColor: Colors.cyan,
                                  inactiveTrackColor: Colors.black45,
                                ),
                                child: Slider(
                                  value: rCalories.toDouble(),
                                  min: 1000.0,
                                  max: 20000.0,
                                  onChanged: (double x) {
                                    setState(() {
                                      rCalories = x.round();
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                          decoration: BoxDecoration(
                            color: activeCard,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black45
                                      .withOpacity(0.2),
                                  offset: const Offset(1.1, 4.0),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 4,),
                              Text(
                                'TOTAL CARBOHYDRATE',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(height: 1,color: Colors.black,indent: 35,endIndent: 35,),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text(
                                    rCarbohydrate.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'grams',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.cyan
                                    ),
                                  ),

                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                                  // activeTrackColor: Color(0xffC38FFF),
                                  // thumbColor: Color(0xffC38FFF),
                                  // inactiveTrackColor: Color(0x55C38FFF),
                                  activeTrackColor: Colors.cyan,
                                  thumbColor: Colors.cyan,
                                  inactiveTrackColor: Colors.black45,
                                ),
                                child: Slider(
                                  value: rCarbohydrate.toDouble(),
                                  min: 100.0,
                                  max: 4000.0,
                                  onChanged: (double x) {
                                    setState(() {
                                      rCarbohydrate = x.round();
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                          decoration: BoxDecoration(
                            color: activeCard,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black45
                                      .withOpacity(0.2),
                                  offset: const Offset(1.1, 4.0),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 4,),
                              Text(
                                'TOTAL PROTEIN',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(height: 1,color: Colors.black,indent: 35,endIndent: 35,),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text(
                                    rProtein.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'grams',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.cyan
                                    ),
                                  ),

                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                                  activeTrackColor: Colors.cyan,
                                  thumbColor: Colors.cyan,
                                  inactiveTrackColor: Colors.black45,
                                ),
                                child: Slider(
                                  value: rProtein.toDouble(),
                                  min: 40.0,
                                  max: 2000.0,
                                  onChanged: (double x) {
                                    setState(() {
                                      rProtein = x.round();
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                          decoration: BoxDecoration(
                            color: activeCard,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black45
                                      .withOpacity(0.2),
                                  offset: const Offset(1.1, 4.0),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 4,),
                              Text(
                                'TOTAL FAT',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(height: 1,color: Colors.black,indent: 35,endIndent: 35,),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text(
                                    rFat.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'grams',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.cyan
                                    ),
                                  ),

                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                                  activeTrackColor: Colors.cyan,
                                  thumbColor: Colors.cyan,
                                  inactiveTrackColor: Colors.black45,
                                ),
                                child: Slider(
                                  value: rFat.toDouble(),
                                  min: 50.0,
                                  max: 2000.0,
                                  onChanged: (double x) {
                                    setState(() {
                                      rFat = x.round();
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                          decoration: BoxDecoration(
                            color: activeCard,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black45
                                      .withOpacity(0.2),
                                  offset: const Offset(1.1, 4.0),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 4,),
                              Text(
                                'TOTAL SUGARS',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(height: 1,color: Colors.black,indent: 35,endIndent: 35,),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text(
                                    rSugars.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'grams',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.cyan
                                    ),
                                  ),

                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                                  activeTrackColor: Colors.cyan,
                                  thumbColor: Colors.cyan,
                                  inactiveTrackColor: Colors.black45,
                                ),
                                child: Slider(
                                  value: rSugars.toDouble(),
                                  min: 20.0,
                                  max: 2000.0,
                                  onChanged: (double x) {
                                    setState(() {
                                      rSugars = x.round();
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                          decoration: BoxDecoration(
                            color: activeCard,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black45
                                      .withOpacity(0.2),
                                  offset: const Offset(1.1, 4.0),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 4,),
                              Text(
                                'TOTAL CHOLESTEROL',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(height: 1,color: Colors.black,indent: 35,endIndent: 35,),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text(
                                    rCholesterol.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'grams',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.cyan
                                    ),
                                  ),

                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                                  activeTrackColor: Colors.cyan,
                                  thumbColor: Colors.cyan,
                                  inactiveTrackColor: Colors.black45,
                                ),
                                child: Slider(
                                  value: rCholesterol.toDouble(),
                                  min: 0.0,
                                  max: 2000.0,
                                  onChanged: (double x) {
                                    setState(() {
                                      rCholesterol = x.round().toDouble();
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              users = auth.currentUser!;
              await DatabaseService(uid: users.uid).updateSetGoalData(foodType, rCalories.toString(), rCarbohydrate.toString(), rProtein.toString(), rFat.toString(), rSugars.toString(), rCholesterol.toString());
              //getTargetData();
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
        ],
      ),
    );
  }
}
