import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/BodyMesurment/calculate.dart';
import 'package:mental_health/screens/patient_dashboard/BodyMesurment/result.dart';

const Color inactiveCard =  Color(0xFFFFFFFF);
var exerciseList = [
  "Little to no exercise",
  "Light exercise (1–3 days per week)",
  "Moderate exercise (3–5 days per week)",
  "Heavy exercise (6–7 days per week)",
  "Very heavy exercise (twice per day)"
];
var goalList = [
  "Maintain current weight",
  "Lose 0.5kg per week",
  "Lose 1kg per week",
  "Gain 0.5kg per week",
  "Gain 1kg per week"
];

class AimPage extends StatefulWidget {
  final int height, weight, age;
  final String gender;

  const AimPage(
      {Key? key, required this.height,
        required this.weight,
        required this.age,
        required this.gender}) : super(key: key);

  @override
  _AimPageState createState() => _AimPageState();
}

class _AimPageState extends State<AimPage> {
  String _activity = exerciseList[0];
  String _goal = goalList[0];
  late int height, weight, age;
  late String gender;

  @override
  void initState() {
    height = widget.height;
    weight = widget.weight;
    age = widget.age;
    gender = widget.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Goals"),
        backgroundColor:  Colors.cyan,
      ),
      backgroundColor: const Color(0xFFF2F3F8),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.cyan[200]
            ),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text("Note: ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                Text("Choose the following option to know your goals on your health for this week",style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                  height: 350,
                  width: 200,
                  decoration: BoxDecoration(
                    color: inactiveCard,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Exercise Scale",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Roboto',
                              color: Colors.cyan,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      const Divider(height: 2,thickness: 1,color: Colors.grey,indent: 25,endIndent: 25,),
                      ListTile(
                        title: Text(exerciseList[0],style: const TextStyle(fontSize: 18),),
                        leading: Radio(
                          value: exerciseList[0],
                          groupValue: _activity,
                          onChanged: (String? value) {
                            setState(() {
                              _activity = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(exerciseList[1],style: const TextStyle(fontSize: 18),),
                        leading: Radio(
                          value: exerciseList[1],
                          groupValue: _activity,
                          onChanged: (String? value) {
                            setState(() {
                              _activity = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(exerciseList[2],style: const TextStyle(fontSize: 18),),
                        leading: Radio(
                          value: exerciseList[2],
                          groupValue: _activity,
                          onChanged: (String? value) {
                            setState(() {
                              _activity = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(exerciseList[3],style: const TextStyle(fontSize: 18),),
                        leading: Radio(
                          value: exerciseList[3],
                          groupValue: _activity,
                          onChanged: (String? value) {
                            setState(() {
                              _activity = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(exerciseList[4],style: const TextStyle(fontSize: 18),),
                        leading: Radio(
                          value: exerciseList[4],
                          groupValue: _activity,
                          onChanged: (String? value) {
                            setState(() {
                              _activity = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 350,
                  width: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  decoration: BoxDecoration(
                    color: inactiveCard,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Calorie Goal",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Roboto',
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold),
                      ),
                      const Divider(height: 2,thickness: 1,color: Colors.grey,indent: 25,endIndent: 25,),
                      ListTile(
                        title: Text(goalList[0],style: const TextStyle(fontSize: 18),),
                        leading: Radio(
                          value: goalList[0],
                          groupValue: _goal,
                          onChanged: (String? value) {
                            setState(() {
                              _goal = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(goalList[1],style: const TextStyle(fontSize: 18),),
                        leading: Radio(
                          value: goalList[1],
                          groupValue: _goal,
                          onChanged: (String? value) {
                            setState(() {
                              _goal = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(goalList[2],style: const TextStyle(fontSize: 18),),
                        leading: Radio(
                          value: goalList[2],
                          groupValue: _goal,
                          onChanged: (String? value) {
                            setState(() {
                              _goal = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(goalList[3],style: const TextStyle(fontSize: 18),),
                        leading: Radio(
                          value: goalList[3],
                          groupValue: _goal,
                          onChanged: (String? value) {
                            setState(() {
                              _goal = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(goalList[4],style: const TextStyle(fontSize: 18),),
                        leading: Radio(
                          value: goalList[4],
                          groupValue: _goal,
                          onChanged: (String? value) {
                            setState(() {
                              _goal = value!;
                            });
                          },
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
              Calculate c = Calculate(
                  height: height,
                  weight: weight,
                  age: age,
                  gender: gender,
                  goal: _goal,
                  activity: _activity);
              c.calculateBMI();
              c.calculateBMR();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Result(
                    status: c.getResult(),
                    msg: c.getInterpretation(),
                    statusNumber: c.calculateBMI(),
                    currentCalorie: c.getActivity(),
                    goalCalorie: c.getGoal(),
                    bmr: c.calculateBMR(),
                    heightCm: c.getHeight().toString(),
                    weight: c.getWeight().toString(),
                    age: age.toString(),
                    gender: gender,
                  ),
                ),
              );
            },
            child: Container(
              height: 50,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              constraints: const BoxConstraints(minWidth: 50,maxWidth: 50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.cyan
              ),
              child: Column(
                children: const <Widget>[
                  Text(
                    'Calculate',
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
          const SizedBox(height: 20,),

        ],

      ),
    );
  }
}
