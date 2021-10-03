import 'package:mental_health/screens/patient_dashboard/training/models/course.dart';
import 'package:mental_health/screens/patient_dashboard/training/models/style.dart';

final _standStyle = Style(
  imageUrl: 'assets/images/pose2.png',
  name: 'Standing Style',
  time: 5,
);
final _sittingStyle = Style(
  imageUrl: 'assets/images/pose1.png',
  name: 'Sitting Style',
  time: 8,
);
final _legCrossStyle = Style(
  imageUrl: 'assets/images/pose3.png',
  name: 'Leg Cross Style',
  time: 6,
);
final styles = [_standStyle,_sittingStyle,_sittingStyle,_legCrossStyle];

final _course1 = Course(
    imageUrl: 'assets/images/course5.jpg',
    name: 'Cardio Exercises',
    time: 20,
    students: 'Beginner'
);

final _course2 = Course(
    imageUrl: 'assets/images/course4.jpg',
    name: 'Exercises',
    time: 20,
    students: 'Beginner'
);

final _course3 = Course(
    imageUrl: 'assets/images/course3.jpg',
    name: 'Meditation',
    time: 20,
    students: 'Beginner'
);
final _course4 = Course(
    imageUrl: 'assets/images/course2.jpg',
    name: 'Daily Yoga',
    time: 30,
    students: 'Intermediate'
);
final _course5 = Course(
    imageUrl: 'assets/images/course1.jpg',
    name: 'Advance Stretching',
    time: 45,
    students: 'Advanced'
);

final List<Course> courses = [_course1,_course3,_course2,_course4,_course5];