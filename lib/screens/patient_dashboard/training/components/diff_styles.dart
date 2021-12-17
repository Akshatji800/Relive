import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/training/data/data.dart';
import 'package:mental_health/screens/patient_dashboard/training/models/style.dart';
import 'package:mental_health/utils/constants.dart';


class DiffStyles extends StatelessWidget {
  const DiffStyles({Key? key}) : super(key: key);

  _buildStyles(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    Style style = styles[index];

    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.appPadding / 2),
          child: Container(
            margin:
                const EdgeInsets.only(top: Constants.appPadding * 3, bottom: Constants.appPadding * 2),
            width: size.width * 0.4,
            height: size.height * 0.2,
            decoration: BoxDecoration(
                color: Constants.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topRight: Radius.circular(100.0)),
                boxShadow: [
                  BoxShadow(
                      color: Constants.black.withOpacity(0.3),
                      blurRadius: 20.0,
                      offset: const Offset(5, 15))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: Constants.appPadding / 2,
                      right: Constants.appPadding * 3,
                      top: Constants.appPadding),
                  child: Text(
                    style.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Constants.appPadding / 2,
                      right: Constants.appPadding / 2,
                      bottom: Constants.appPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: Constants.black.withOpacity(0.3),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            style.time.toString() + ' min',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Constants.black.withOpacity(0.3)),
                            maxLines: 2,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: const Icon(
                          Icons.add,
                          color: Constants.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Image(
            width: size.width * 0.3,
            height: size.height * 0.2,
            image: AssetImage(style.imageUrl),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.appPadding, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'For Beginners',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w800, color: Colors.cyan),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: Constants.appPadding / 2),
          child: SizedBox(
            height: size.height * 0.33,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: styles.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildStyles(context, index);
                }),
          ),
        )
      ],
    );
  }
}
