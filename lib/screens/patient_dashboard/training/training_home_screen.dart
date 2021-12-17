import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/training/components/courses.dart';
import 'package:mental_health/screens/patient_dashboard/training/components/diff_styles.dart';
import 'package:mental_health/screens/patient_dashboard/training/components/video_suggestions.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({key}) : super(key: key);

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "Training",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Icon(Platform.isAndroid ? Icons.more_vert : Icons.more_horiz,color: Colors.white,),
          const SizedBox(width: 10,)
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Column(
              children: const <Widget>[
                VideoSuggestions(),
                DiffStyles(),
                Courses(),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
