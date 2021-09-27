import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mental_health/screens/Settings_Pages/NewPassword.dart';
import 'package:mental_health/screens/patient_dashboard/my_diary/meals_list_view.dart';
import 'package:mental_health/services/database.dart';
import 'add_new_food.dart';
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';

double TCalorie = 0;
double TCarbs = 0;
double TProtein = 0;
double TFat = 0;
double TSugars = 0;
double TCholesterol = 0;
//ignore: must_be_immutable
class Dinner extends StatefulWidget {
  String callingText;
  Dinner({Key? key, required this.callingText}) : super(key: key);

  @override
  _DinnerState createState() => _DinnerState();
}

class _DinnerState extends State<Dinner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.callingText}"),
          backgroundColor: Colors.cyan,
          elevation: 1,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                if("${widget.callingText}" == 'dinner') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddNewFoodPage(callingText: "dinner",)));
                }
                if("${widget.callingText}" == 'lunch') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddNewFoodPage(callingText: "lunch",)));
                }
                if("${widget.callingText}" == 'snack') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddNewFoodPage(callingText: "snack",)));
                }
                if("${widget.callingText}" == 'breakfast') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddNewFoodPage(callingText: "breakfast",)));
                }
              },
            )
          ],
        ),
        body: Container(
          child: Column(children: <Widget>[
            BarChartSample1(),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('userdata')
                    .doc(user.uid)
                    .collection('food_track')
                    .doc(formattedDate)
                    .collection('${widget.callingText}')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return new Text("There is no data");
                  if (snapshot.hasData) {
                    TCalorie = 0;
                    TCarbs = 0;
                    TProtein = 0;
                    TFat = 0;
                    TSugars = 0;
                    TCholesterol = 0;
                    for (var i = 0; i < snapshot.data!.docs.length; i++) {
                      TCalorie = TCalorie +
                          double.parse(snapshot.data!.docs[i]
                          [snapshot.data!.docs[i].id]["Total Calories"]);
                      TCarbs = TCarbs +
                          double.parse(snapshot.data!.docs[i]
                          [snapshot.data!.docs[i].id]["Carbohydrate"]);
                      TProtein = TProtein +
                          double.parse(snapshot.data!.docs[i]
                          [snapshot.data!.docs[i].id]["Protein"]);
                      TFat = TFat +
                          double.parse(snapshot.data!.docs[i]
                          [snapshot.data!.docs[i].id]["Fat"]);
                      TSugars = TSugars +
                          double.parse(snapshot.data!.docs[i]
                          [snapshot.data!.docs[i].id]["Sugars"]);
                      TCholesterol = TCholesterol +
                          double.parse(snapshot.data!.docs[i]
                          [snapshot.data!.docs[i].id]["Cholesterol"]);

                    }
                    DatabaseService(uid: user.uid).updateTotalFoodData("${widget.callingText}",TCalorie.toString(), TCarbs.toString(), TProtein.toString(), TFat.toString(), TSugars.toString(), TCholesterol.toString());
                  };
                  return getExpenseItems(snapshot);
                }),
          ]),
        ));
  }
}

getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Food",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 65),
                      Text(
                        "Total Cal",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 65),
                      Text(
                        "Carbs",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 65),
                      Text(
                        "Protein",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 65),
                      Text(
                        "Fat",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 78),
                      Text(
                        "Sugars",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 60),
                      Text(
                        "Cholesterol",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 1,
                      width: 750,
                      decoration: BoxDecoration(color: Colors.black)),
                  for (var i = 0; i < snapshot.data!.docs.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i].id}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 50),
                          Container(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i][snapshot.data!.docs[i].id]["Total Calories"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 50),
                          Container(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i][snapshot.data!.docs[i].id]["Carbohydrate"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 50),
                          Container(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i][snapshot.data!.docs[i].id]["Protein"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 50),
                          Container(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i][snapshot.data!.docs[i].id]["Fat"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 50),
                          Container(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i][snapshot.data!.docs[i].id]["Sugars"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 50),
                          Container(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i][snapshot.data!.docs[i].id]["Cholesterol"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ]),
          ),
        ),
      ),
    ),
  );
}

class BarChartSample1 extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = Colors.cyan.shade50;
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      'Nutrients Intake Data',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BarChart(
                          isPlaying ? mainBarData() : mainBarData(),
                          swapAnimationDuration: animDuration,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.cyan,
    double width = 13,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow, width: 1)
              : BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 100,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(6, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, double.parse(((TCalorie/RCalorie)*100).toStringAsFixed(2))>100? 100: double.parse(((TCalorie/RCalorie)*100).toStringAsFixed(2)), isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, double.parse(((TCarbs/RCarbs)*100).toStringAsFixed(2))>100? 100: double.parse(((TCarbs/RCarbs)*100).toStringAsFixed(2)), isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, double.parse(((TProtein/RProtein)*100).toStringAsFixed(2))>100? 100:double.parse(((TProtein/RProtein)*100).toStringAsFixed(2)), isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, double.parse(((TFat/RFat)*100).toStringAsFixed(2))>100? 100:double.parse(((TFat/RFat)*100).toStringAsFixed(2)), isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, double.parse(((TSugars/RSugars)*100).toStringAsFixed(2))>100? 100:double.parse(((TSugars/RSugars)*100).toStringAsFixed(2)), isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, double.parse(((TCholesterol/RCholesterol)*100).toStringAsFixed(2))>100? 100:double.parse(((TCholesterol/RCholesterol)*100).toStringAsFixed(2)), isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Calories';
                  break;
                case 1:
                  weekDay = 'Carbohydrate';
                  break;
                case 2:
                  weekDay = 'Protein';
                  break;
                case 3:
                  weekDay = 'Fat';
                  break;
                case 4:
                  weekDay = 'Sugars';
                  break;
                case 5:
                  weekDay = 'Cholesterol';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString() + '%',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'CL';
              case 1:
                return 'C';
              case 2:
                return 'P';
              case 3:
                return 'F';
              case 4:
                return 'S';
              case 5:
                return 'CH';
              default:
                return 'N';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}
