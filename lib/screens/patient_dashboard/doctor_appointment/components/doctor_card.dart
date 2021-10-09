
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/screens/detail_screen.dart';
import 'package:mental_health/utils/loadProfilePic.dart';

import '../constant.dart';

//ignore: must_be_immutable
class DoctorCard extends StatelessWidget {
  String? _uid;
  String? _name;
  String? _description;
  String? _bio;
  var _bgColor;

  DoctorCard(this._uid,this._name, this._description, this._bgColor, this._bio);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)
        => new DetailScreen(_name, _description, _uid, _bio)));
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FutureBuilder(
          future: loadProfilePic(_uid!),
          builder: (context,AsyncSnapshot<Uint8List?> snapshot) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                leading: (snapshot.data != null) ? CircleAvatar(
                  radius: 35,
                  backgroundImage: Image.memory(snapshot.data!).image,
                ) : Image.asset('assets/images/doctor1.png'),
                title: Text(
                  _name!,
                  style: TextStyle(
                    color: kTitleTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  _description!,
                  style: TextStyle(
                    color: kTitleTextColor.withOpacity(0.7),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
