import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mental_health/screens/k_ten_scale/controllers/question_controller.dart';
import 'package:mental_health/screens/patient_dashboard/fitness_app_home_screen.dart';
import '../../constants.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              Text(
                "${_qnController.scoretotal}/${_qnController.questions.length * 5}",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: kSecondaryColor),
              ),
              Spacer(flex: 3),
              InterpretationTable(),
              Spacer(flex: 3),
              InkWell(
                onTap: () => Get.to(FitnessAppHomeScreen()),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
                  decoration: BoxDecoration(
                    gradient: kPrimaryGradient,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Text(
                    "Navigate to Dashboard",
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}

class InterpretationTable extends StatelessWidget {
  const InterpretationTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.grey,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Score',
              style: TextStyle(fontStyle: FontStyle.italic,
              color: Colors.black),
            ),
          ),
          DataColumn(
            label: Text(
              'Verdict',
              style: TextStyle(fontStyle: FontStyle.italic,
                  color: Colors.black),
            ),
          ),
        ],
        rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('10 - 19',
              style: TextStyle(color: Colors.black),)),
              DataCell(Text('Likely to be well',
                  style: TextStyle(color: Colors.black))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('20 - 24',
                  style: TextStyle(color: Colors.black))),
              DataCell(Text('Likely to have a mild disorder',
                  style: TextStyle(color: Colors.black))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('25 - 29',
                  style: TextStyle(color: Colors.black))),
              DataCell(Text('Likely to have a moderate disorder',
                  style: TextStyle(color: Colors.black))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('30 - 50',
                  style: TextStyle(color: Colors.black))),
              DataCell(Text('Likely to have a severe disorder',
                  style: TextStyle(color: Colors.black))),
            ],
          ),
        ],
      ),
    );
  }
}
