
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/screens/detail_screen.dart';
import 'package:mental_health/utils/load_profile_pic.dart';

import '../constant.dart';

//ignore: must_be_immutable
class DoctorCard extends StatelessWidget {
  final String? _uid;
  final String? _name;
  final String? _description;
  final String? _bio;
  final dynamic _bgColor;

  const DoctorCard(this._uid,this._name, this._description, this._bgColor, this._bio, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)
        => DetailScreen(_name, _description, _uid, _bio)));
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
              padding: const EdgeInsets.all(10),
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
