import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/components/schedule_card.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/screens/token_maker.dart';
import 'package:mental_health/utils/load_profile_pic.dart';
import '../constant.dart';
import 'audio_calling.dart';

//ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  final dynamic _name;
  final dynamic _description;
  final dynamic _uid;
  final dynamic _bio;

  const DetailScreen(this._name, this._description, this._uid, this._bio, {Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: loadProfilePic(widget._uid),
          builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
            return Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/detail_illustration.png'),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/back.svg',
                            height: 18,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/3dots.svg',
                          height: 18,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.24,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              (snapshot.data != null) ? CircleAvatar(
                                radius: 50,
                                backgroundImage: Image.memory(snapshot.data!).image,
                              ) : Image.asset('assets/images/doctor1.png', scale: 5,),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget._name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: kTitleTextColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget._description,
                                    style: TextStyle(
                                      color: kTitleTextColor.withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Scaffold(
                                                    appBar: AppBar(
                                                      backgroundColor: Colors.cyan,
                                                      title:
                                                      const Text("Audio Calling"),
                                                    ),
                                                    body: const JoinChannelAudio(),
                                                  )));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: kBlueColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icons/phone.svg',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: kYellowColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/icons/chat.svg',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Scaffold(
                                                    appBar: AppBar(
                                                      backgroundColor: Colors.cyan,
                                                      title:
                                                      const Text("Video Calling"),
                                                    ),
                                                    body: const TokenMaker(),
                                                  )));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: kOrangeColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icons/video.svg',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            'About Doctor',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: kTitleTextColor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget._bio,
                            style: TextStyle(
                              height: 1.6,
                              color: kTitleTextColor.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Upcoming Schedules',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: kTitleTextColor,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ScheduleCard(
                            'Consultation',
                            'Sunday . 9am - 11am',
                            '12',
                            'Jan',
                            kBlueColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ScheduleCard(
                            'Consultation',
                            'Sunday . 9am - 11am',
                            '13',
                            'Jan',
                            kYellowColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ScheduleCard(
                            'Consultation',
                            'Sunday . 9am - 11am',
                            '14',
                            'Jan',
                            kOrangeColor,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
