import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_route/controllers/login_action.dart';
import 'package:test_route/views/call_screen.dart';
import 'package:test_route/views/course_detail_screen.dart';
import 'package:test_route/views/course_info_screen.dart';
import 'package:test_route/views/courses_screen.dart';
import 'package:test_route/views/history_screen.dart';
import 'package:test_route/views/home_screen.dart';
import 'package:test_route/views/schedule_screen.dart';
import 'package:test_route/views/setting_screen.dart';
import 'package:test_route/views/tutor_screen.dart';
import 'views/login_screen.dart'; //            1
//import 'views/home_screen.dart'; //           2
//import 'views/tutor_screen.dart'; //          3
//import 'views/schedule_screen.dart'; //       4
//import 'views/history_screen.dart'; //        5
//import 'views/courses_screen.dart'; //        6
//import 'views/course_info_screen.dart'; //    7
//import 'views/course_detail_screen.dart'; //  8
//import 'views/call_screen.dart'; //           9
//import 'package:go_router/go_router.dart';

/*
Login                           95% password hide/show
  |-- Home (Tutors)             90% Button filter time
      |-- Tutor (Detail)        80% table
      |-- Schedule              90% need implement class
          |-- Call              80% minor stuff
      |-- History               95% dropdown Request and Review
      |-- Courses               95%
          |-- Course Info       100%
              |-- COurse Detail 80% view pdf
*/

Future main() async {
  await dotenv.load();
  await fetchLogin('phhai@ymail.com', '123456');
  runApp(const MaterialApp(
    home: CoursesScreen(),
  ));
}
