import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imagesList = [
  'https://akm-img-a-in.tosshub.com/indiatoday/sunsetyoga-2_647_062115121022.jpg?Q7x3aPFYhLV6E2CgD7oXmSdjoh5wnAiq&size=1200:675',
  'https://julierolandrealtor.com/wp-content/uploads/2017/07/yoga-silhouettes.jpg',
  'https://i.guim.co.uk/img/media/d8b7a69601c6ac049fd8e57819786adc91506003/0_2_2545_1528/master/2545.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=694f53610eb345e25c763f20935d7c90',
  'https://cdn1.coachmag.co.uk/sites/coachmag/files/2020/01/best-abs-exercises.jpg',
];


class VideoSuggestions extends StatefulWidget {
  const VideoSuggestions({key}) : super(key: key);

  @override
  _VideoSuggestionsState createState() => _VideoSuggestionsState();
}

class _VideoSuggestionsState extends State<VideoSuggestions> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            height: 170,
            onPageChanged: (index, reason) {
              setState(
                    () {
                  _currentIndex = index;
                },
              );
            },
          ),
          items: imagesList
              .map(
                (item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black45
                              .withOpacity(0.1),
                          offset: const Offset(0, 0),
                          blurRadius: 10),
                    ],
                    image: DecorationImage(
                        image: NetworkImage(
                          item,),
                        fit: BoxFit.cover),
                  color: Colors.cyan,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(55),topLeft:Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) )
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 115,),
                    Container(
                      height: 55,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) )
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 10,),
                          Icon(Icons.alarm,size: 20,color: Colors.white,),
                          Text("5 min",style: TextStyle(color: Colors.white),),
                          SizedBox(width: 100,),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(50))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.play_arrow,size: 30,)
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imagesList.map((urlOfItem) {
            int index = imagesList.indexOf(urlOfItem);
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? Color.fromRGBO(0, 0, 0, 0.8)
                    : Color.fromRGBO(0, 0, 0, 0.3),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}

