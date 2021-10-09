import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/components/doctor_card.dart';

import '../constant.dart';
import 'doctor_model.dart';

class DoctorsList extends StatefulWidget {
  final String role;
  const DoctorsList({Key? key, required this.role}) : super(key: key);

  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  List<DoctorModel> doctorsCategory = [DoctorModel("", "","","","","")];
  @override
  Widget build(BuildContext context) {
    doctorsCategory.removeAt(0);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.role),
        backgroundColor:  Colors.cyan,
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('userdata').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.data != null){
                snapshot.data!.docs.forEach((element) {
                  try{
                    if(element['type'] == "doctor" && element['specialization']==widget.role){
                      doctorsCategory.add(DoctorModel(element.id ,element['name'], element['specialization'],
                          element['phone'], element['hospital'], element['about']));
                    }
                  }catch (e){
                  }
                });
              }
              return Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: doctorsCategory.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: (snapshot.data != null) ? ([DoctorCard(
                            doctorsCategory[index].uid,
                            doctorsCategory[index].displayName,
                            doctorsCategory[index].specialization! + "-" + doctorsCategory[index].hospital!,
                            (index%2==0) ? kBlueColor: kYellowColor,
                            doctorsCategory[index].bio,
                          ),
                          SizedBox(height: 10,)
                        ]) : ([CircularProgressIndicator()]),
                      );
                    },
                  ),
                  SizedBox(height: 70),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
