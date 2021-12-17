import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/screens/search_result.dart';
import '../constant.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String searchText = "";
  
  @override
  void initState() {
    super.initState();
    searchText = "";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 52,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kSearchBackgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            decoration: const InputDecoration.collapsed(
              hintText: 'Search for doctors',
            ),
            onChanged: (value) {
              searchText = value;
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: MaterialButton(
            onPressed: () {Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)
            => SearchResult(searchText: searchText)));},
            color:  Colors.cyan,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SvgPicture.asset('assets/icons/search.svg'),
          ),
        ),
      ],
    );
  }
}
