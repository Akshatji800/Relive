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

  Future<void> updateWaterData(int glasses) async {
    return await waterCollection.doc(formattedDate).set({
      'no. of glasses': glasses,
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

  final CollectionReference bodyCollection4 = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('body_track').doc(formattedDate).collection('bodyMeasurement');

  Future<void> updateBodyData4(String gender) async {
    return await bodyCollection4.doc("Gender").set({
      'gender': gender,
    });
  }

  final CollectionReference bodyCollection1 = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('body_track').doc(formattedDate).collection('bodyMeasurement');

  Future<void> updateBodyData1(int height) async {
    return await bodyCollection1.doc("Height").set({
      'height': height,
    });
  }

  final CollectionReference bodyCollection2 = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('body_track').doc(formattedDate).collection('bodyMeasurement');

  Future<void> updateBodyData2(int weight) async {
    return await bodyCollection2.doc("Weight").set({
      'weight': weight,
    });
  }

  final CollectionReference bodyCollection3 = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('body_track').doc(formattedDate).collection('bodyMeasurement');

  Future<void> updateBodyData3(int age) async {
    return await bodyCollection3.doc("Age").set({
      'age': age,
    });
  }

  final CollectionReference bodyCollection5 = FirebaseFirestore.instance.collection('userdata').doc(user.uid).collection('body_track').doc(formattedDate).collection('bodyMeasurement');

  Future<void> updateBodyData5(int BMR) async {
    return await bodyCollection5.doc("BMR").set({
      'BMR': BMR,
    });
  }

}