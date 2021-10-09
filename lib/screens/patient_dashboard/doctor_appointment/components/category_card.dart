
import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/screens/doctors_list.dart';

import '../constant.dart';

//ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  var _title;
  var _imageUrl;
  var _bgColor;
  var _category;

  CategoryCard(this._title, this._imageUrl, this._bgColor, this._category);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 160,
      child: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)
          => new DoctorsList(role: _category)));
        },
        child: Stack(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: 110,
                height: 137,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    _title,
                    style: TextStyle(
                      color: kTitleTextColor,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                height: 84,
                width: 84,
                decoration: BoxDecoration(
                  color: _bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  _imageUrl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
