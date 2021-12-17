import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/screens/video_calling.dart';

String updatedtoken = "";
String channelNameEntered = "";
Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jetap82112.pythonanywhere.com/fetchRtcToken/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'channelName': title,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final String title;

  Album({required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      title: json['token'],
    );
  }
}

class TokenMaker extends StatefulWidget {
  const TokenMaker({Key? key}) : super(key: key);

  @override
  _TokenMakerState createState() {
    return _TokenMakerState();
  }
}

class _TokenMakerState extends State<TokenMaker> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Create Channel',
      theme: ThemeData(
        backgroundColor: Colors.cyan,
        primarySwatch: Colors.cyan,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
          ),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Channel Name'),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              channelNameEntered = _controller.text.toString();
              _futureAlbum = createAlbum(_controller.text);
            });
          },
          child: const Text('Create Channel',style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          updatedtoken = (snapshot.data!.title).toString();
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MediaChannelRelay()));
          });
          }
          else if (snapshot.hasError) {
          Fluttertoast.showToast(msg: '${snapshot.error}', gravity: ToastGravity.TOP);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}