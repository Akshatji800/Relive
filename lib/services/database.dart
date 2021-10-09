import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_health/screens/Settings_Pages/NewPassword.dart';
import 'package:mental_health/screens/patient_dashboard/my_diary/my_diary_screen.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference myCollection = FirebaseFirestore.instance.collection('userdata');

  Future<void> updateUserData(String name, String username, String email, String type) async {
    return await myCollection.doc(uid).set({
      'name': name,
      'username': username,
      'email': email,
      'type': type,
    });
  }

  Future<void> updateDoctorUserData(String name, String username, String email, String specialization, String hospital, String phone, String about, String type,) async {
    return await myCollection.doc(uid).set({
      'name': name,
      'username': username,
      'email': email,
      'specialization': specialization,
      'hospital': hospital,
      'phone': phone,
      'about': about,
      'type': type,
    });
  }

  final CollectionReference foodTotalData = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('Total');

  Future<void> updateTotalFoodData(String typeOfFood, String calories, String carbo, String protein, String fat, String sugars, String cholesterol) async {
    return await foodTotalData.doc(typeOfFood).set({
      'Total Calories': calories,
      'Total Carbohydrate': carbo,
      'Total Protein': protein,
      'Total Fat': fat,
      'Total Sugars': sugars,
      'Total Cholesterol': cholesterol,
    });
  }

  final CollectionReference foodSetGoal = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('Target');

  Future<void> updateSetGoalData( String mealType, String calories, String carbo, String protein, String fat, String sugars, String cholesterol) async {
    return await foodSetGoal.doc(mealType).set({
        'Target Calories': calories,
        'Target Carbohydrate': carbo,
        'Target Protein': protein,
        'Target Fat': fat,
        'Target Sugars': sugars,
        'Target Cholesterol': cholesterol,
    });
  }

  final CollectionReference foodCollectionbreakfast = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('breakfast');

  Future<void> updateFoodDataBreakfast( String food_name, String calories, String carbo, String protein, String fat, String sugars, String cholesterol, String servings) async {
    return await foodCollectionbreakfast.doc(food_name).set({
      food_name: {
        'Total Calories': calories,
        'Carbohydrate': carbo,
        'Protein': protein,
        'Fat': fat,
        'Servings': servings,
        'Sugars': sugars,
        'Cholesterol': cholesterol,
      }
    });
  }

  final CollectionReference waterCollection = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('water_track');

  Future<void> updateWaterData(double glasses,double target,String lastSeen, String time) async {
    return await waterCollection.doc(formattedDate).set({
      'consumed(ml)': glasses,
      'target(ml)' : target,
      'last seen' : lastSeen,
      'time' : time,
    });
  }

  final CollectionReference foodCollectionTotal = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track');

  Future<void> updateFoodDataTotal(int carbohydrate, int protein, int fat) async {
    return await foodCollectionTotal.doc(formattedDate).set({
      'Total Carbohydrate': carbohydrate,
      'Total Protein': protein,
      'Total Fat': fat,
    });
  }

  final CollectionReference foodCollectionLunch = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('lunch');

  Future<void> updateFoodDataLunch( String food_name, String calories, String carbo, String protein, String fat, String sugars, String cholesterol, String servings) async {
    return await foodCollectionLunch.doc(food_name).set({
      food_name: {
        'Total Calories': calories,
        'Carbohydrate': carbo,
        'Protein': protein,
        'Fat': fat,
        'Servings': servings,
        'Sugars': sugars,
        'Cholesterol': cholesterol,
      }
    });
  }

  final CollectionReference foodCollectionSnack = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('snack');

  Future<void> updateFoodDataSnack( String food_name, String calories, String carbo, String protein, String fat, String sugars, String cholesterol, String servings) async {
    return await foodCollectionSnack.doc(food_name).set({
      food_name: {
        'Total Calories': calories,
        'Carbohydrate': carbo,
        'Protein': protein,
        'Fat': fat,
        'Servings': servings,
        'Sugars': sugars,
        'Cholesterol': cholesterol,
      }
    });
  }

  final CollectionReference foodCollectionDinner = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('dinner');

  Future<void> updateFoodDataDinner( String food_name, String calories, String carbo, String protein, String fat, String sugars, String cholesterol, String servings) async {
    return await foodCollectionDinner.doc(food_name).set({
      food_name: {
        'Total Calories': calories,
        'Carbohydrate': carbo,
        'Protein': protein,
        'Fat': fat,
        'Servings': servings,
        'Sugars': sugars,
        'Cholesterol': cholesterol,
      }
    });
  }
  final CollectionReference bodyCollection = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('body_track');
  Future<void> updateBodyMesurmentData(int height, int weight, double BMR, double BMW, String status, String lastSeen,String age, String gender) async {
    print(formattedDate);
    return await bodyCollection.doc(formattedDate).set({
      'height(cm)': height,
      'weight(kg)': weight,
      'BMR(Body Metabolic Rate)': BMR,
      'BMW(Body Mass weight)' : BMW,
      'BMW status':status,
      'last seen': lastSeen,
      'age':age,
      'gender':gender
    });
  }

}