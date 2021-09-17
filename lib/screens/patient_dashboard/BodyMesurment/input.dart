import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_health/screens/patient_dashboard/BodyMesurment/AimPage.dart';
const Color inactiveCard = Color(0xFFE0F7FA);
const Color activeCard = Colors.white;

class InputPage extends StatefulWidget {

  @override
  _InputPageState createState() => _InputPageState();
}

// ignore: camel_case_types
class _InputPageState extends State<InputPage> {
  var _height=180;
  var _weight=60;

  Color maleCard = activeCard,
      femaleCard = activeCard;
  int height = 180,
      weight = 60,
      age = 25;
  double heightF=5.9;
  String gender="";
  void updateGenderSelected(int x) {
    if (x == 1) {
      gender="Male";
      maleCard = inactiveCard;
      femaleCard = activeCard;
    } else {
      gender="Female";
      maleCard = activeCard;
      femaleCard = inactiveCard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Body Mesurement"),
        // centerTitle: true,
//        backgroundColor: Color(0xFF313131),
        backgroundColor:  Colors.cyan,
      ),
      backgroundColor: Color(0xFFF2F3F8),
      body: ListView(
        children: <Widget>[
          Container(
            // padding: EdgeInsets.all(10),
            height: 210,
            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            // constraints: BoxConstraints(minWidth: 50,maxWidth: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              // color: Colors.grey
            ),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.cyan[200]
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Note: ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                      Text("Enter the following details below to find the Body Mass Index",style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
                SizedBox(height:12,),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              print("FEMALE");
                              updateGenderSelected(2);
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 130,
                            decoration: BoxDecoration(
                              color: femaleCard,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black45
                                        .withOpacity(0.2),
                                    offset: const Offset(1.1, 4.0),
                                    blurRadius: 8.0),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.venus,color: Colors.cyan,size: 100,),
                                SizedBox(height: 5,),
                                Text("FEMALE",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),)

                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              print("MALE");
                              updateGenderSelected(1);
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 130,
                            decoration: BoxDecoration(
                              color: maleCard,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black45
                                        .withOpacity(0.2),
                                    offset: const Offset(1.1, 4.0),
                                    blurRadius: 8.0),
                              ],
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.mars,color: Colors.cyan,size: 100,),
                                SizedBox(height: 5,),
                                Text("MALE",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),)

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 165,
                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  decoration: BoxDecoration(
                    color: activeCard,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black45
                              .withOpacity(0.2),
                          offset: const Offset(1.1, 4.0),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 4,),
                      Text(
                        'HEIGHT',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(height: 1,color: Colors.black,indent: 35,endIndent: 35,),
                      SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            _height.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'cm',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.cyan
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            heightF.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Ft',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.cyan
                            ),
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                          overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                          // activeTrackColor: Color(0xffC38FFF),
                          // thumbColor: Color(0xffC38FFF),
                          // inactiveTrackColor: Color(0x55C38FFF),
                          activeTrackColor: Colors.cyan,
                          thumbColor: Colors.cyan,
                          inactiveTrackColor: Colors.black45,
                        ),
                        child: Slider(
                          value: _height.toDouble(),
                          min: 100.0,
                          max: 240.0,
                          onChanged: (double x) {
                            setState(() {
                              _height = x.round();
                              heightF = (_height * 0.0328084);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150,
                width: 280,
                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),

                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: 50,
                        height: 150,

                        decoration: BoxDecoration(
                          color: activeCard,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black45
                                    .withOpacity(0.2),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
                          ],
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 15,),
                            Text(
                              'Weight',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Divider(height: 1,color: Colors.black,indent: 25,endIndent: 25,),
                            SizedBox(height: 10,),
                            Text(
                              _weight.toString(),
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.black54,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(FontAwesomeIcons.minus,color: Colors.black,),
                                    radius: 30.0,
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _weight--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(FontAwesomeIcons.plus,color: Colors.black,),
                                    radius: 30.0,
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _weight++;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 2,),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width:10 ,),
                    Expanded(
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: activeCard,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black45
                                    .withOpacity(0.2),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
                          ],
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 15,),
                            Text(
                              "Age",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Divider(height: 1,color: Colors.black,indent: 25,endIndent: 25,),
                            SizedBox(height: 10,),
                            Text(
                              age.toString(),
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.black54,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(FontAwesomeIcons.minus,color: Colors.black,),
                                    radius: 30.0,
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      age--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(FontAwesomeIcons.plus,color: Colors.black,),
                                    radius: 30.0,
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 2,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AimPage(height:_height ,
                    weight: _weight,
                    gender: gender,
                    age:age,
                  ),
                ),
              );
            },
            child: Container(
              height: 50,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              constraints: BoxConstraints(minWidth: 50,maxWidth: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.cyan,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black45
                          .withOpacity(0.2),
                      offset: const Offset(1.1, 4.0),
                      blurRadius: 8.0),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
