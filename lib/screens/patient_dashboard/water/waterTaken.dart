import 'package:flutter/material.dart';

class watertaken extends StatefulWidget {
  const watertaken({Key? key}) : super(key: key);

  @override
  _watertakenState createState() => _watertakenState();
}

class _watertakenState extends State<watertaken> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water"),
      ),
    );
  }
}
