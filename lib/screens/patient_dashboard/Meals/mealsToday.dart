import 'package:flutter/material.dart';

class meals extends StatefulWidget {
  const meals({Key? key}) : super(key: key);

  @override
  _mealsState createState() => _mealsState();
}

class _mealsState extends State<meals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meals"),
      ),
    );
  }
}
