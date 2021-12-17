import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_health/screens/patient_dashboard/BodyMesurment/aim_page.dart';
const Color inactiveCard = Color(0xFFE0F7FA);
const Color activeCard = Colors.white;

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);


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
        title: const Text("Body Mesurement"),
        // centerTitle: true,
//        backgroundColor: Color(0xFF313131),
        backgroundColor:  Colors.cyan,
      ),
      backgroundColor: const Color(0xFFF2F3F8),
      body: ListView(
        children: <Widget>[
          Container(
            // padding: EdgeInsets.all(10),
            height: 210,
            margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("Note: ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                      Text("Enter the following details below to find the Body Mass Index",style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
                const SizedBox(height:12,),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
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
                              const Icon(FontAwesomeIcons.venus,color: Colors.cyan,size: 100,),
                              const SizedBox(height: 5,),
                              Text("FEMALE",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),)

                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
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
                              const Icon(FontAwesomeIcons.mars,color: Colors.cyan,size: 100,),
                              const SizedBox(height: 5,),
                              Text("MALE",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),)

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
                  margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
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
                      const SizedBox(height: 4,),
                      const Text(
                        'HEIGHT',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(height: 1,color: Colors.black,indent: 35,endIndent: 35,),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            _height.toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'cm',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.cyan
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            heightF.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
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
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
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
                margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
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
                            const SizedBox(height: 15,),
                            const Text(
                              'Weight',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5,),
                            const Divider(height: 1,color: Colors.black,indent: 25,endIndent: 25,),
                            const SizedBox(height: 10,),
                            Text(
                              _weight.toString(),
                              style: const TextStyle(
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
                                    child: const Icon(FontAwesomeIcons.minus,color: Colors.black,),
                                    radius: 30.0,
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _weight--;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                IconButton(
                                  icon: CircleAvatar(
                                    child: const Icon(FontAwesomeIcons.plus,color: Colors.black,),
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
                            const SizedBox(height: 2,),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width:10 ,),
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
                            const SizedBox(height: 15,),
                            const Text(
                              "Age",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5,),
                            const Divider(height: 1,color: Colors.black,indent: 25,endIndent: 25,),
                            const SizedBox(height: 10,),
                            Text(
                              age.toString(),
                              style: const TextStyle(
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
                                    child: const Icon(FontAwesomeIcons.minus,color: Colors.black,),
                                    radius: 30.0,
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      age--;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                IconButton(
                                  icon: CircleAvatar(
                                    child: const Icon(FontAwesomeIcons.plus,color: Colors.black,),
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
                            const SizedBox(height: 2,),
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
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              constraints: const BoxConstraints(minWidth: 50,maxWidth: 50),
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
                children: const <Widget>[
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
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
