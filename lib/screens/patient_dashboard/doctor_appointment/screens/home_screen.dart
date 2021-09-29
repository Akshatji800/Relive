import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/components/category_card.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/components/doctor_card.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/components/search_bar.dart';
import '../constant.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor\'s Appointment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Find Your Desired\nDoctor',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SearchBar(),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buildCategoryList(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Top Doctors',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buildDoctorList(),
            ],
          ),
        ),
      ),
    );
  }

  buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          CategoryCard(
            'Psychiatrist',
            'assets/icons/psychiatrist.png',
            kOrangeColor,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Dental\nSurgeon',
            'assets/icons/dental_surgeon.png',
            kBlueColor,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Heart\nSurgeon',
            'assets/icons/heart_surgeon.png',
            kYellowColor,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Eye\nSpecialist',
            'assets/icons/eye_specialist.png',
            kOrangeColor,
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }

  buildDoctorList() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: <Widget>[
          DoctorCard(
            'Dr. Stella Kane',
            'Heart Surgeon - Flower Hospitals',
            'assets/images/doctor1.png',
            kBlueColor,
          ),
          SizedBox(
            height: 20,
          ),
          DoctorCard(
            'Dr. Joseph Cart',
            'Dental Surgeon - Flower Hospitals',
            'assets/images/doctor2.png',
            kYellowColor,
          ),
          SizedBox(
            height: 20,
          ),
          DoctorCard(
            'Dr. Stephanie',
            'Eye Specialist - Flower Hospitals',
            'assets/images/doctor3.png',
            kOrangeColor,
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
