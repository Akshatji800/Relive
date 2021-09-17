import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mental_health/screens/Settings_Pages/NewPassword.dart';

var now = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
String formattedDate = formatter.format(now);
class DatabaseService {
  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference myCollection = FirebaseFirestore.instance.collection('userdata');

  Future<void> updateUserData(String name, String username, String email) async {
    return await myCollection.doc(uid).set({
      'name': name,
      'username': username,
      'email': email,
    });
  }

  final CollectionReference foodCollectionbreakfast1 = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('breakfast');

  Future<void> updateFoodDataBreakfast1(int quantity, String unit) async {
    return await foodCollectionbreakfast1.doc("Chapati").set({
      'quantity': quantity,
      'unit': unit,
    });
  }

  final CollectionReference foodCollectionbreakfast2 = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('breakfast');

  Future<void> updateFoodDataBreakfast2(int quantity, String unit) async {
    return await foodCollectionbreakfast2.doc("Dal").set({
      'quantity': quantity,
      'unit': unit,
    });
  }

  final CollectionReference waterCollection = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('water_track');

  Future<void> updateWaterData(int glasses,int target,String lastSeen, String time) async {
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

  final CollectionReference foodCollectionlunch1 = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('lunch');

  Future<void> updateFoodDataLunch1(int quantity, String unit) async {
    return await foodCollectionlunch1.doc("Chapati").set({
      'quantity': quantity,
      'unit': unit,
    });
  }

  final CollectionReference foodCollectionlunch2 = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('lunch');

  Future<void> updateFoodDataLunch2(int quantity, String unit) async {
    return await foodCollectionlunch2.doc("Dal").set({
      'quantity': quantity,
      'unit': unit,
    });
  }

  final CollectionReference foodCollectionsnack = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('snack');

  Future<void> updateFoodDataSnack(int packets) async {
    return await foodCollectionsnack.doc("Chips").set({
      'unit': packets,
    });
  }

  final CollectionReference foodCollectiondinner1 = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('dinner');

  Future<void> updateFoodDataDinner1(int quantity, String unit) async {
    return await foodCollectiondinner1.doc("Chapati").set({
      'quantity': quantity,
      'unit': unit,
    });
  }

  final CollectionReference foodCollectiondinner2 = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('food_track').doc(formattedDate).collection('dinner');

  Future<void> updateFoodDataDinner2(int quantity, String unit) async {
    return await foodCollectiondinner2.doc("Dal").set({
      'quantity': quantity,
      'unit': unit,
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