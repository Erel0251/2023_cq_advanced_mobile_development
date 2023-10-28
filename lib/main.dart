import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/login_screen.dart';
import 'views/home_screen.dart';
import 'views/tutor_screen.dart';
import 'views/courses_screen.dart';
import 'views/course_info_screen.dart';
import 'views/explore_course_screen.dart';
import 'views/history_screen.dart';
import 'views/call_screen.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(), // home has implicit route set at '/'
  ));
}
