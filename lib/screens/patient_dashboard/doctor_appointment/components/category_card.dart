import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/screens/doctors_list.dart';
import '../constant.dart';

//ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  final dynamic _title;
  final dynamic _imageUrl;
  final dynamic _bgColor;
  final dynamic _category;

  const CategoryCard(this._title, this._imageUrl, this._bgColor, this._category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 160,
      child: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)
          => DoctorsList(role: _category)));
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
                padding: const EdgeInsets.symmetric(
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
