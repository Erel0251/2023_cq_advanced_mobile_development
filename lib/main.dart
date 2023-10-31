import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/login_screen.dart'; // 1
import 'views/home_screen.dart'; // 2
import 'views/tutor_screen.dart'; // 3
import 'views/courses_screen.dart'; //7
import 'views/course_info_screen.dart'; // 8
import 'views/explore_course_screen.dart'; //6
import 'views/history_screen.dart'; // 5
import 'views/call_screen.dart'; //9
import 'views/booking_screen.dart'; // 4

void main() {
  runApp(const MaterialApp(
    home: BookingScreen(), // home has implicit route set at '/'
  ));
}
