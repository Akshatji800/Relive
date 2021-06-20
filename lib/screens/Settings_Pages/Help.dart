import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}


class _SettingsPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        elevation: 1,
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
    );
  }
}