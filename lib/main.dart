import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:let_tutor_app/controllers/authentication_controller.dart';
import 'package:let_tutor_app/views/call_screen.dart';
import 'package:let_tutor_app/views/courses/course_detail_screen.dart';
import 'package:let_tutor_app/views/courses/course_info_screen.dart';
import 'package:let_tutor_app/views/courses/courses_screen.dart';
import 'package:let_tutor_app/views/history_screen.dart';
import 'package:let_tutor_app/views/tutor/home_screen.dart';
import 'package:let_tutor_app/views/schedule_screen.dart';
import 'package:let_tutor_app/views/user/setting_screen.dart';
import 'package:let_tutor_app/views/tutor/tutor_screen.dart';

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
  await loginWithEmail('student@lettutor.com', '123456');
  runApp(const MaterialApp(
    home: HistoryScreen(),
  ));
}
