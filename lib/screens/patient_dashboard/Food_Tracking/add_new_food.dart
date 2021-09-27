import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mental_health/screens/Settings_Pages/NewPassword.dart';
import 'package:mental_health/services/database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


late Response response;
var dio = Dio();
String carbo ="";
String protein = "";
String fat= "";
String calories ="";
String cholesterol ="";
String sugars ="";
String food_name ="";
String quantity="";
//ignore: must_be_immutable
class AddNewFoodPage extends StatefulWidget {
  String callingText;
  AddNewFoodPage({Key? key, required this.callingText}) : super(key: key);
  @override
  _AddNewFoodPageState createState() => _AddNewFoodPageState();
}

class _AddNewFoodPageState extends State<AddNewFoodPage> {
  String dropdownValue = 'piece';
  final foodnameController = TextEditingController();
  final carboController = TextEditingController();
  final proteinController = TextEditingController();
  final fatController = TextEditingController();
  final servingsController = TextEditingController();
  final caloriesController = TextEditingController();
  final sugarsController = TextEditingController();
  final cholesterolController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Food"),
        backgroundColor: Colors.cyan,
        elevation: 1,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
              color: Colors.white54
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                ],
              ),
            ),
            SizedBox(height: 13),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: TextFormField(
                                          keyboardType:
                                          TextInputType.text,
                                          controller: foodnameController,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.fastfood),
                                            hintText: "Enter Food Name",
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(0),
                                            child: TextFormField(
                                              controller: servingsController,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.food_bank),
                                                hintText: 'Servings',
                                                hintStyle: TextStyle(
                                                    color: Colors.black45),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      padding: EdgeInsets.only(left: 20.0, right: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(50)),
                                      child: DropdownButton<String>(
                                        value: dropdownValue,
                                        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(color: Colors.black),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: <String>['piece','cups']
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    httprequest((servingsController.text.toString())+" "+dropdownValue+" "+ (foodnameController.text).toString());
                                  },

                                  child: Container(
                                    height: 50,
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
                                        "Get Data",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: TextFormField(
                                          controller: caloriesController,
                                          keyboardType: TextInputType.numberWithOptions(),
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.rice_bowl),
                                            hintText: 'Enter Calories Intake (in Kcal)',
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: TextFormField(
                                          controller: carboController,
                                          keyboardType: TextInputType.numberWithOptions(),
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.rice_bowl),
                                            hintText: 'Enter Carbohydrate (in grams)',
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: TextFormField(
                                          controller: proteinController,
                                          keyboardType: TextInputType.numberWithOptions(),
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.rice_bowl),
                                            hintText: 'Enter Protein (in grams)',
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: TextFormField(
                                          controller: fatController,
                                          keyboardType: TextInputType.numberWithOptions(),
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.rice_bowl),
                                            hintText: 'Enter Fat (in grams)',
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: TextFormField(
                                          controller: cholesterolController,
                                          keyboardType: TextInputType.numberWithOptions(),
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.rice_bowl),
                                            hintText: 'Enter Cholesterol (in grams)',
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(0),
                                        child: TextFormField(
                                          controller: sugarsController,
                                          keyboardType: TextInputType.numberWithOptions(),
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.rice_bowl),
                                            hintText: 'Enter Sugars (in grams)',
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            update_data();
                            user = auth.currentUser!;
                                FirebaseFirestore.instance.collection('userdata').doc(user.uid).
                                collection('food_track').doc(formattedDate).collection("${widget.callingText}")
                                    .get()
                                    .then((querySnapshot) {
                                  querySnapshot.docs.forEach((result) {
                                  });
                                });
                          },
                          child: Container(
                            height: 50,
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
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> httprequest(String name)
  async {
    dio.options.headers['x-app-id'] = env['APP_ID'];
    dio.options.headers["x-app-key"] = env['APP_KEY'];
    try{
      response = await dio.post(
          'https://trackapi.nutritionix.com/v2/natural/nutrients',
          data: {'query': name});
    }
    catch(e){
      Fluttertoast.showToast(msg: 'Food not found. Please enter the data yourself', gravity: ToastGravity.TOP);
    }
    food_name = response.data['foods'][0]['food_name'].toString();
    calories = response.data['foods'][0]['nf_calories'].toString();
    carbo = response.data['foods'][0]['nf_total_carbohydrate'].toString();
    protein = response.data['foods'][0]['nf_protein'].toString();
    fat = response.data['foods'][0]['nf_total_fat'].toString();
    cholesterol = (double.parse(response.data['foods'][0]['nf_cholesterol'].toString())/1000).toString();
    sugars = response.data['foods'][0]['nf_sugars'].toString();
    if (response.statusCode == 200) {
      setState(() {
        food_name = foodnameController.text;
        quantity = servingsController.text;
        carboController.text = carbo;
        proteinController.text = protein;
        fatController.text = fat;
        caloriesController.text = calories;
        sugarsController.text = sugars;
        cholesterolController.text = cholesterol;
      });
    }
  }
  Future<void> update_data() async {
    user = auth.currentUser!;
    if("${widget.callingText}" == "dinner"){
      await DatabaseService(uid: user.uid).updateFoodDataDinner(food_name, calories, carbo, protein, fat, sugars, cholesterol, quantity);
    }
    if("${widget.callingText}" == "lunch"){
      await DatabaseService(uid: user.uid).updateFoodDataLunch(food_name, calories, carbo, protein, fat, sugars, cholesterol, quantity);
    }
    if("${widget.callingText}" == "snack"){
      await DatabaseService(uid: user.uid).updateFoodDataSnack(food_name, calories, carbo, protein, fat, sugars, cholesterol, quantity);
    }
    if("${widget.callingText}" == "breakfast"){
      await DatabaseService(uid: user.uid).updateFoodDataBreakfast(food_name, calories, carbo, protein, fat, sugars, cholesterol, quantity);
    }
  }
}



