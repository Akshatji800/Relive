import 'package:flutter/material.dart';
import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Flutter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
        ],
      ),
      body: Body(),
    );
  }
}
